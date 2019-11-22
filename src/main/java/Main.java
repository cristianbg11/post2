
import INF.*;
import org.hibernate.HibernateException;
import org.hibernate.Metamodel;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import spark.ModelAndView;
import spark.Request;
import spark.template.freemarker.FreeMarkerEngine;

import javax.persistence.EntityManager;
import javax.persistence.metamodel.EntityType;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static spark.Spark.*;
import static spark.Spark.get;

public class Main {
    private static final SessionFactory ourSessionFactory;

    static {
        try {
            Configuration configuration = new Configuration();
            configuration.configure();

            ourSessionFactory = configuration.buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static Session getSession() throws HibernateException {
        return ourSessionFactory.openSession();
    }

    public static void main(final String[] args) throws Exception {
        //final Session session = getSession();
        final Session secion = getSession();
        port(8080);
        staticFiles.location("/publico");
        EntityManager em = getSession();

        long num = 1;

        if (secion.find(UsuarioEntity.class, num)==null){
            em.getTransaction().begin();
            UsuarioEntity admin = new UsuarioEntity(1, "admin", "1234", true, true, "Cristian");
            em.persist(admin);
            em.getTransaction().commit();;
        }

        post("/insertar", (request, response) -> {
            em.getTransaction().begin();
            UsuarioEntity usuario = new UsuarioEntity();
            usuario.username = request.queryParams("username");
            usuario.nombre = request.queryParams("nombre");
            usuario.password = request.queryParams("password");
            usuario.administrador = Boolean.parseBoolean(request.queryParams("administrador"));
            usuario.autor = Boolean.parseBoolean(request.queryParams("autor"));
            em.persist(usuario);
            em.getTransaction().commit();
            response.redirect("/");
            return "Usuario Creado";
        }); // Crea un usuario

        post("/crear-articulo", (request, response)-> {
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            em.getTransaction().begin();
            ArticuloEntity articulo = new ArticuloEntity();
            articulo.titulo = request.queryParams("titulo");
            articulo.cuerpo = request.queryParams("cuerpo");
            articulo.usuarioByUsuarioId = usuario;
            articulo.fecha = Date.valueOf(request.queryParams("fecha"));
            em.persist(articulo);
            em.getTransaction().commit();
            etiquetas(em, request, articulo);
            response.redirect("/index");
            return "Articulo Creado";
        });

        get("/delete", (request, response)-> {
            final Session sesion = getSession();
            long id_articulo = Integer.parseInt(request.queryParams("id_post"));
            ArticuloEntity articulo = sesion.find(ArticuloEntity.class, id_articulo);
            //em.createQuery("delete EtiquetaEntity where articuloByArticuloId.id="+id_articulo).executeUpdate();
            //em.createQuery("delete ComentarioEntity where articuloByArticuloId.id="+id_articulo).executeUpdate();
            sesion.getTransaction().begin();
            sesion.remove(articulo);
            sesion.getTransaction().commit();
            response.redirect("/articulo");
            return "Articulo Borrado";
        });

        get("/", (request, response)-> {
            //response.redirect("/login.html");
            final Session sesion = getSession();
            if (request.cookie("CookieUsuario") != null){
                //long id = Long.parseLong(request.cookie("CookieUsuario"));
                UsuarioEntity usuarioEntity = sesion.find(UsuarioEntity.class, 1);
                spark.Session session=request.session(true);
                session.attribute("usuario", usuarioEntity);
                response.redirect("/index");
            }
            return renderContent("publico/login.html");
        });

        get("/index", (request, response)-> {
            Map<String, Object> attributes = new HashMap<>();
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            String tag = request.queryParams("id_tag");
            /*
            if(usuario==null){
                response.redirect("/");
            } else if (usuario.administrador==false){
                response.redirect("/index");
            }
            */
            List<ArticuloEntity> articulos = em.createQuery("select a from ArticuloEntity a order by id desc", ArticuloEntity.class).getResultList();
            List<String> etiquetas = em.createQuery("select distinct e.etiqueta from EtiquetaEntity e", String.class).getResultList();
            attributes.put("usuario",usuario);
            attributes.put("articulos",articulos);
            attributes.put("etiquetas",etiquetas);
            attributes.put("tag", tag);
            return new ModelAndView(attributes, "index.ftl");

        } , new FreeMarkerEngine());

        post("/sesion", (request, response)-> {
            List<UsuarioEntity> users = em.createQuery("select u from UsuarioEntity u", UsuarioEntity.class).getResultList();
            String username = request.queryParams("user");
            String password = request.queryParams("pass");
            spark.Session session=request.session(true);

            for(UsuarioEntity usuario : users){
                if (usuario.username.equals(username) && usuario.password.equals(password)){
                    session.attribute("usuario", usuario);
                    if (request.queryParams("recordatorio") !=null && request.queryParams("recordatorio").equals("si") ){
                        Map<String, String> cookies=request.cookies();
                        //response.cookie("/", "CookieUsuario", String.valueOf(usuario.id), 604800, true);
                        for (String key : cookies.keySet()) {
                            if (key != null) {
                                response.removeCookie(key);
                                response.cookie("/", "CookieUsuario", cookies.get(key), 604800, false);
                            }
                        }

                    }
                    response.redirect("/index");
                }
            }
            response.redirect("/");
            return 0;
        });

        get("/post", (request, response)-> {
            final Session sesion = getSession();
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            /*
            if(usuario==null){
                response.redirect("/");
            } else if (usuario.administrador==false){
                response.redirect("/index");
            }
             */
            long id = Integer.parseInt(request.queryParams("id_post"));
            ArticuloEntity articulo = sesion.find(ArticuloEntity.class, id);
            Query cant = (Query) em.createQuery("select count(a) from LikeArticuloEntity a where a.like=true and a.articuloByIdArticulo.id=:art");
            cant.setParameter("art", id);
            Query cant2 = (Query) em.createQuery("select count(a) from LikeArticuloEntity a where a.dislike=true and a.articuloByIdArticulo.id=:art");
            cant2.setParameter("art", id);
            long likes = (long) cant.getSingleResult();
            long dislikes = (long) cant2.getSingleResult();

            Query cantLikeComment = (Query) em.createQuery("select count(a) from LikeArticuloEntity a where a.like=true and a.articuloByIdArticulo.id=:art");
            cantLikeComment.setParameter("art", id);
            articulo.comentariosById.forEach(comment->{
                comment.likeComentariosById.forEach(meGusta ->{
                    if (meGusta.like==true){
                        comment.cantLikes++;
                    } else if (meGusta.dislike==true){
                        comment.cantDisLikes++;
                    }
                });
            });
            Map<String, Object> attributes = new HashMap<>();
            attributes.put("usuario", usuario);
            attributes.put("post", articulo);
            attributes.put("likes", likes);
            attributes.put("dislikes", dislikes);
            return new ModelAndView(attributes, "post.ftl");

        } , new FreeMarkerEngine());

        post("/update", (request, response)-> {
            final Session sesion = getSession();
            long id_articulo = Integer.parseInt(request.queryParams("id_post"));
            ArticuloEntity articulo = sesion.find(ArticuloEntity.class, id_articulo);
            em.getTransaction().begin();
            articulo.setTitulo(request.queryParams("titulo"));
            articulo.setCuerpo(request.queryParams("cuerpo"));
            articulo.setFecha(Date.valueOf(request.queryParams("fecha")));
            em.merge(articulo);
            em.getTransaction().commit();
            em.getTransaction().begin();
            Query query = (Query) em.createQuery("delete EtiquetaEntity e where e.articuloByArticuloId.id = :id");
            query.setParameter("id", id_articulo);
            query.executeUpdate();
            em.getTransaction().commit();
            etiquetas(em, request, articulo);
            response.redirect("/post?id_post="+id_articulo);
            return "Articulo Actualizado";
        }); //Actualiza articulos

        get("/edita", (request, response)-> {
            final Session sesion = getSession();
            Map<String, Object> attributes = new HashMap<>();
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            if(usuario==null){
                response.redirect("/");
            } else if (usuario.administrador==false){
                response.redirect("/index");
            }
            long id = Integer.parseInt(request.queryParams("id_post"));
            ArticuloEntity articulo = sesion.find(ArticuloEntity.class, id);
            attributes.put("usuario",usuario);
            attributes.put("post",articulo);
            return new ModelAndView(attributes, "articuloedit.ftl");

        } , new FreeMarkerEngine());

        get("/salir", (request, response)->{
            spark.Session session=request.session(true);
            session.invalidate();
            response.removeCookie("CookieUsuario");
            response.redirect("/");
            return "Sesion finalizada";
        }); //Finaliza Sesión

        get("/user", (request, response)-> {
            Map<String, Object> attributes = new HashMap<>();
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            if(usuario==null){
                response.redirect("/");
            } else if (usuario.administrador==false){
                response.redirect("/index");
            }
            List<UsuarioEntity> users = em.createQuery("select u from UsuarioEntity u").getResultList();
            attributes.put("users",users);
            attributes.put("usuario",usuario);
            return new ModelAndView(attributes, "usuarios.ftl");

        } , new FreeMarkerEngine()); //Retorna un usuario a buscar

        get("/articulo", (request, response)-> {
            Map<String, Object> attributes = new HashMap<>();
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            if(usuario==null){
                response.redirect("/");
            } else if (usuario.administrador==false){
                response.redirect("/index");
            }
            List<ArticuloEntity> articulos = em.createQuery("select a from ArticuloEntity a").getResultList();
            attributes.put("usuario",usuario);
            attributes.put("articulos",articulos);
            return new ModelAndView(attributes, "articulos.ftl");

        } , new FreeMarkerEngine()); //Retorna un articulo a buscar.

        get("/crear", (request, response)-> {
            Map<String, Object> attributes = new HashMap<>();
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            if(usuario==null){
                response.redirect("/");
            } else if (usuario.administrador==false){
                response.redirect("/index");
            }
            attributes.put("usuario",usuario);
            return new ModelAndView(attributes, "crear.ftl");

        } , new FreeMarkerEngine()); //Crea un usuario

        post("/comentar", (request, response) -> {
            final Session sesion = getSession();
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            ComentarioEntity comentario = new ComentarioEntity();
            em.getTransaction().begin();
            comentario.comentario = request.queryParams("comentario");
            comentario.usuarioByUsuarioId = usuario;
            long id = Integer.parseInt(request.queryParams("articulo_id"));
            comentario.articuloByArticuloId = sesion.find(ArticuloEntity.class, id);
            em.persist(comentario);
            em.getTransaction().commit();
            response.redirect("/post?id_post="+id);
            return "Comentario Creado";
        }); //Crea un comentario en un articulo

        get("/likepost", (request, response) -> {
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            final Session sesion = getSession();
            long id = Integer.parseInt(request.queryParams("id_post"));
            ArticuloEntity articulo = sesion.find(ArticuloEntity.class, id);
            em.getTransaction().begin();
            if(articulo.likeArticulosById==null){
                LikeArticuloEntity like = new LikeArticuloEntity();
                like.like = true;
                like.dislike = false;
                like.articuloByIdArticulo = articulo;
                like.usuarioByIdUsuario = usuario;
                em.persist(like);
                em.getTransaction().commit();
            }
            else {
                Query<LikeArticuloEntity> query = (Query<LikeArticuloEntity>) em.createQuery("from LikeArticuloEntity l where l.usuarioByIdUsuario.id=:scn and l.articuloByIdArticulo.id=:art", LikeArticuloEntity.class);
                query.setParameter("scn", usuario.id);
                query.setParameter("art", id);
                LikeArticuloEntity likeUser = query.uniqueResult();
                if (likeUser==null){
                    LikeArticuloEntity like = new LikeArticuloEntity();
                    like.like = true;
                    like.dislike = false;
                    like.articuloByIdArticulo = articulo;
                    like.usuarioByIdUsuario = usuario;
                    em.persist(like);
                    em.getTransaction().commit();
                } else if (likeUser.like==true){
                    likeUser.setLike(false);
                    likeUser.setDislike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                } else if (likeUser.like==false){
                    likeUser.setLike(true);
                    likeUser.setDislike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                }
            }

            //likePost(em, request, articulo);
            response.redirect("/post?id_post="+id);
            return "Me gusta";
        }); //le da me gusta en un articulo

        get("/dislikepost", (request, response) -> {
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            final Session sesion = getSession();
            long id = Integer.parseInt(request.queryParams("id_post"));
            ArticuloEntity articulo = sesion.find(ArticuloEntity.class, id);
            //dislikePost(em, request, articulo);
            em.getTransaction().begin();
            if(articulo.likeArticulosById==null){
                LikeArticuloEntity like = new LikeArticuloEntity();
                like.like = false;
                like.dislike = true;
                like.articuloByIdArticulo = articulo;
                like.usuarioByIdUsuario = usuario;
                em.persist(like);
                em.getTransaction().commit();
            }
            else {
                Query<LikeArticuloEntity> query = (Query<LikeArticuloEntity>) em.createQuery("from LikeArticuloEntity l where l.usuarioByIdUsuario.id=:scn and l.articuloByIdArticulo.id=:art", LikeArticuloEntity.class);
                query.setParameter("scn", usuario.id);
                query.setParameter("art", id);
                LikeArticuloEntity likeUser = query.uniqueResult();
                if (likeUser==null){
                    LikeArticuloEntity like = new LikeArticuloEntity();
                    like.like = false;
                    like.dislike = true;
                    like.articuloByIdArticulo = articulo;
                    like.usuarioByIdUsuario = usuario;
                    em.persist(like);
                    em.getTransaction().commit();
                } else if (likeUser.dislike==true){
                    likeUser.setDislike(false);
                    likeUser.setLike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                } else if (likeUser.dislike==false){
                    likeUser.setDislike(true);
                    likeUser.setLike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                }
            }
            response.redirect("/post?id_post="+id);
            return "No me gusta";
        }); //le da no me gusta en un articulo

        get("/likecomment", (request, response) -> {
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            final Session sesion = getSession();
            long id = Integer.parseInt(request.queryParams("id_comment"));
            ComentarioEntity comentario = sesion.find(ComentarioEntity.class, id);
            em.getTransaction().begin();
            if(comentario.likeComentariosById==null){
                LikeComentarioEntity like = new LikeComentarioEntity();
                like.like = true;
                like.dislike = false;
                like.comentarioByIdComentario = comentario;
                like.usuarioByIdUsuario = usuario;
                em.persist(like);
                em.getTransaction().commit();
            }
            else {
                Query<LikeComentarioEntity> query = (Query<LikeComentarioEntity>) em.createQuery("from LikeComentarioEntity l where l.usuarioByIdUsuario.id=:scn and l.comentarioByIdComentario.id=:art", LikeComentarioEntity.class);
                query.setParameter("scn", usuario.id);
                query.setParameter("art", id);
                LikeComentarioEntity likeUser = query.uniqueResult();
                if (likeUser==null){
                    LikeComentarioEntity like = new LikeComentarioEntity();
                    like.like = true;
                    like.dislike = false;
                    like.comentarioByIdComentario = comentario;
                    like.usuarioByIdUsuario = usuario;
                    em.persist(like);
                    em.getTransaction().commit();
                } else if (likeUser.like==true){
                    likeUser.setLike(false);
                    likeUser.setDislike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                } else if (likeUser.like==false){
                    likeUser.setLike(true);
                    likeUser.setDislike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                }
            }
            response.redirect("/post?id_post="+comentario.articuloByArticuloId.id);
            return "Me gusta";
        }); //le da me gusta a un comentario

        get("/dislikecomment", (request, response) -> {
            spark.Session session=request.session(true);
            UsuarioEntity usuario = (UsuarioEntity)(session.attribute("usuario"));
            final Session sesion = getSession();
            long id = Integer.parseInt(request.queryParams("id_comment"));
            ComentarioEntity comentario = sesion.find(ComentarioEntity.class, id);
            em.getTransaction().begin();
            if(comentario.likeComentariosById==null){
                LikeComentarioEntity like = new LikeComentarioEntity();
                like.like = false;
                like.dislike = true;
                like.comentarioByIdComentario = comentario;
                like.usuarioByIdUsuario = usuario;
                em.persist(like);
                em.getTransaction().commit();
            }
            else {
                Query<LikeComentarioEntity> query = (Query<LikeComentarioEntity>) em.createQuery("from LikeComentarioEntity l where l.usuarioByIdUsuario.id=:scn and l.comentarioByIdComentario.id=:art", LikeComentarioEntity.class);
                query.setParameter("scn", usuario.id);
                query.setParameter("art", id);
                LikeComentarioEntity likeUser = query.uniqueResult();
                if (likeUser==null){
                    LikeComentarioEntity like = new LikeComentarioEntity();
                    like.like = false;
                    like.dislike = true;
                    like.comentarioByIdComentario = comentario;
                    like.usuarioByIdUsuario = usuario;
                    em.persist(like);
                    em.getTransaction().commit();
                } else if (likeUser.dislike==true){
                    likeUser.setDislike(false);
                    likeUser.setLike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                } else if (likeUser.dislike==false){
                    likeUser.setDislike(true);
                    likeUser.setLike(false);
                    em.merge(likeUser);
                    em.getTransaction().commit();
                }
            }
            response.redirect("/post?id_post="+comentario.articuloByArticuloId.id);
            return "No me gusta";
        }); //le da un no me gusta a un comentario

    }

    public static void etiquetas(EntityManager em, Request request, ArticuloEntity articulo) {
        String[] tags = request.queryParams("etiqueta").split(",");
        List<String> tagList = Arrays.asList(tags);
        for (int i=0; i<tagList.size(); i++){
            em.getTransaction().begin();
            EtiquetaEntity etiqueta = new EtiquetaEntity();
            etiqueta.etiqueta = tagList.get(i);
            etiqueta.articuloByArticuloId = articulo;
            em.persist(etiqueta);
            em.getTransaction().commit();
        }
    }

    private static String renderContent(String htmlFile) throws IOException, URISyntaxException {
        URL url = Main.class.getResource(htmlFile);
        Path path = Paths.get(url.toURI());
        return new String(Files.readAllBytes(path), Charset.defaultCharset());
    }

}
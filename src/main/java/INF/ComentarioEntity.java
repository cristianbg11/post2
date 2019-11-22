package INF;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "COMENTARIO", schema = "PUBLIC", catalog = "PRACTICA4")
public class ComentarioEntity {
    public long id;
    public String comentario;
    public long usuarioId;
    public long articuloId;
    public UsuarioEntity usuarioByUsuarioId;
    public ArticuloEntity articuloByArticuloId;
    public Collection<LikeComentarioEntity> likeComentariosById;
    public long cantLikes =0;
    public long cantDisLikes=0;

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "COMENTARIO", nullable = true)
    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ComentarioEntity that = (ComentarioEntity) o;
        return id == that.id &&
                usuarioId == that.usuarioId &&
                articuloId == that.articuloId &&
                Objects.equals(comentario, that.comentario);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, comentario, usuarioId, articuloId);
    }

    @ManyToOne
    @JoinColumn(name = "USUARIO_ID", referencedColumnName = "ID")
    public UsuarioEntity getUsuarioByUsuarioId() {
        return usuarioByUsuarioId;
    }

    public void setUsuarioByUsuarioId(UsuarioEntity usuarioByUsuarioId) {
        this.usuarioByUsuarioId = usuarioByUsuarioId;
    }

    @ManyToOne
    @JoinColumn(name = "ARTICULO_ID", referencedColumnName = "ID")
    public ArticuloEntity getArticuloByArticuloId() {
        return articuloByArticuloId;
    }

    public void setArticuloByArticuloId(ArticuloEntity articuloByArticuloId) {
        this.articuloByArticuloId = articuloByArticuloId;
    }

    @OneToMany(mappedBy = "comentarioByIdComentario", cascade = CascadeType.ALL)
    public Collection<LikeComentarioEntity> getLikeComentariosById() {
        return likeComentariosById;
    }

    public void setLikeComentariosById(Collection<LikeComentarioEntity> likeComentariosById) {
        this.likeComentariosById = likeComentariosById;
    }
}

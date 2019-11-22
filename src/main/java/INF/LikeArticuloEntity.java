package INF;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "LIKE_ARTICULO", schema = "PUBLIC", catalog = "PRACTICA4")
public class LikeArticuloEntity {
    public int id;
    public Boolean like;
    public Boolean dislike;
    public long idArticulo;
    public Integer idUsuario;
    public ArticuloEntity articuloByIdArticulo;
    public UsuarioEntity usuarioByIdUsuario;

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "LIKE", nullable = true)
    public Boolean getLike() {
        return like;
    }

    public void setLike(Boolean like) {
        this.like = like;
    }

    @Basic
    @Column(name = "DISLIKE", nullable = true)
    public Boolean getDislike() {
        return dislike;
    }

    public void setDislike(Boolean dislike) {
        this.dislike = dislike;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LikeArticuloEntity that = (LikeArticuloEntity) o;
        return id == that.id &&
                idArticulo == that.idArticulo &&
                Objects.equals(like, that.like) &&
                Objects.equals(dislike, that.dislike) &&
                Objects.equals(idUsuario, that.idUsuario);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, like, dislike, idArticulo, idUsuario);
    }

    @ManyToOne
    @JoinColumn(name = "ID_ARTICULO", referencedColumnName = "ID")
    public ArticuloEntity getArticuloByIdArticulo() {
        return articuloByIdArticulo;
    }

    public void setArticuloByIdArticulo(ArticuloEntity articuloByIdArticulo) {
        this.articuloByIdArticulo = articuloByIdArticulo;
    }

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO", referencedColumnName = "ID")
    public UsuarioEntity getUsuarioByIdUsuario() {
        return usuarioByIdUsuario;
    }

    public void setUsuarioByIdUsuario(UsuarioEntity usuarioByIdUsuario) {
        this.usuarioByIdUsuario = usuarioByIdUsuario;
    }
}

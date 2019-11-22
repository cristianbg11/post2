<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Articulo</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lora">
    <link rel="stylesheet" href="assets/css/Article-Clean.css">
    <link rel="stylesheet" href="assets/css/Article-List.css">
    <link rel="stylesheet" href="assets/css/Bootstrap-Tags-Input.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/smoothproducts.css">
    <link rel="stylesheet" href="assets/css/survey-comment.css">
    <link rel="stylesheet" href="assets/css/text-box.css">
    <link rel="stylesheet" href="assets/css/Footer-Clean.css">
    <link rel="stylesheet" href="css/button.css">
</head>

<body>
<nav class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar">
    <div class="container"><a class="navbar-brand logo" href="/index">Practica 4</a><button data-toggle="collapse" class="navbar-toggler" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse"
             id="navcol-1">
            <ul class="nav navbar-nav ml-auto">
                <li class="nav-item" role="presentation"><a class="nav-link active" href="/index">Inicio</a></li>
                <#if usuario?has_content>
                    <#if usuario.administrador == true>
                        <li class="nav-item" role="presentation"><a class="nav-link" href="/articulo">Articulos</a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link" href="/user">Usuarios</a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link" href="/crear">Crear</a></li>
                    <#elseif usuario.autor == true>
                        <li class="nav-item" role="presentation"><a class="nav-link" href="/articulo">Articulos</a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link" href="/crear">Crear</a></li>
                    </#if>
                </#if>
                <li class="nav-item" role="presentation"><a class="nav-link" href="/salir">Salir</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="table-responsive">
    <table class="table">
        <thead>
        <tr>
            <th>Column 1</th>
            <th>Column 2</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Cell 1</td>
            <td>Cell 2</td>
        </tr>
        <tr></tr>
        </tbody>
    </table>
</div>
<div class="article-list"></div>
<div class="article-clean">
    <div class="container">
        <div class="row">
            <div class="col-lg-10 col-xl-8 offset-lg-1 offset-xl-2">
                <div class="intro">
                    <h1 class="text-center">${post.titulo}</h1>
                    <p class="text-center"><span class="by">by</span> <a href="#">${post.usuarioByUsuarioId.nombre}</a><span class="date">${post.fecha} </span></p>
                </div>
                <div class="text">
                    <p class="text-justify" style="font-size: 18px;">${post.cuerpo}</p>
                    <a href="/likepost?id_post=${post.id}"><button class="like">
                            <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                        </button></a>
                    <label class="text-justify"><#if post.me_gusta?has_content>
                            ${post.me_gusta}
                        <#else>
                            0
                    </#if></label>
                    <a href="/dislikepost?id_post=${post.id}"><button class="dislike">
                            <i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
                        </button></a>
                    <label class="text-justify"><#if post.dislike?has_content>
                            ${post.dislike}
                        <#else>
                            0
                        </#if></label>
                    <figure>
                        <figcaption class="text-justify">Tags: <#if post.etiquetasById?has_content>
                            <#list post.etiquetasById as etiqueta>
                                ${etiqueta.etiqueta},
                            </#list>
                        </#if></figcaption>
                    </figure>
                </div>
                <h5 class="text-justify" style="padding-top: 5px;margin-bottom: 0px;">Comentarios</h5>
                <div class="row survey-comment">
                    <#if post.comentariosById?has_content>
                        <#list post.comentariosById as comentario>
                            <div class="col col-9 col-md-10 survey-comment__text"><strong class="survey-comment__author-name">${comentario.usuarioByUsuarioId.username}</strong>
                                <div class="survey-comment__text-content">
                                    <p class="text-justify text-secondary" style="font-size: 14px;">${comentario.comentario}<br></p>
                                    <a href="/likecomment?id_comment=${comentario.id}"><button class="like">
                                            <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                                        </button></a>
                                    <label class="text-justify"><#if comentario.me_gusta?has_content>
                                            ${comentario.me_gusta}
                                        <#else>
                                            0
                                        </#if></label>
                                    <a href="/dislikecomment?id_comment=${comentario.id}"><button class="dislike">
                                            <i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
                                        </button></a>
                                    <label class="text-justify"><#if comentario.dislike?has_content>
                                            ${comentario.dislike}
                                        <#else>
                                            0
                                        </#if></label>
                                </div><div class="survey-comment__date-time">
                                    <script>
                                        var mydate = new Date()
                                        mydate.setDate(mydate.getDate() - 14);
                                        var year = mydate.getYear()
                                        if (year < 1000)
                                            year += 1900
                                        var day = mydate.getDay()
                                        var month = mydate.getMonth()
                                        var daym = mydate.getDate()
                                        if (daym < 10)
                                            daym = "0" + daym
                                        var dayarray = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
                                        var montharray = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
                                        document.write("" + montharray[month] + " " + daym + ", " + year + "")
                                    </script>
                                </div></div>
                        </#list>
                    </#if>
                </div>
                <div class="card text-white bg-primary mb-1">
                    <form action="/comentar" method="POST">
                    <div class="card-header">
                        ${usuario.username}
                    </div>
                    <div class="card-body">
                        <div class=" card-text form-group">
                              <textarea rows="3" class="form-control form-control-lg" name="comentario">
                              </textarea>
                            <input type="hidden" value="${post.id}" name="articulo_id">
                        </div>
                        <button class="float-right btn btn-dark"> <i class="fa fa-comment"></i> Comenta</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer-clean">
    <footer></footer>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
<script src="assets/js/smoothproducts.min.js"></script>
<script src="assets/js/theme.js"></script>
<script src="assets/js/Bootstrap-Tags-Input-1.js"></script>
<script src="assets/js/Bootstrap-Tags-Input.js"></script>
</body>

</html>
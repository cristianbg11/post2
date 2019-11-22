<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Articulos</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/Article-List.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/smoothproducts.css">
    <link rel="stylesheet" href="assets/css/Bootstrap-Tags-Input.css">
    <link rel="stylesheet" href="assets/css/Footer-Clean.css">
</head>

<body>
<nav class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar">
    <div class="container"><a class="navbar-brand logo" href="/index">Practica 4</a><button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
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
<main class="page">
    <section class="clean-block features">
        <div class="container" style="margin-bottom: 0px;margin-top: 0px;">
            <h1 class="text-center" style="margin-bottom: 8px;margin-top: 20px;">Articulos</h1>
        </div>
        <div class="table-responsive d-lg-flex align-items-lg-center" style="margin: 0px;">
            <table class="table">
                <thead class="text-justify">
                <tr class="table-active text-monospace text-left">
                    <th>Titulo</th>
                    <th>Cuerpo</th>
                    <th>Autor</th>
                    <th>Fecha</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="d-lg-flex">TV</td>
                    <td>Text</td>
                    <td>Cristian</td>
                    <td>2019/15/2019</td>
                    <td>
                        <div class="dropdown"><button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false" type="button">Opcion&nbsp;</button>
                            <div class="dropdown-menu" role="menu"><a class="dropdown-item" role="presentation" href="#">Ver</a><a class="dropdown-item" role="presentation" href="/edita">Editar</a><a class="dropdown-item" role="presentation" href="#">Eliminar</a></div>
                        </div>
                    </td>
                </tr>

                <#list articulos as articulo>
                    <tr>
                        <td class="d-lg-flex">${articulo.titulo}</td>
                        <td>${articulo.cuerpo[0..100]}</td>
                        <td>${articulo.usuarioByUsuarioId.nombre}</td>
                        <td>${articulo.fecha}</td>
                        <td>
                            <div class="dropdown"><button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false" type="button">Opcion&nbsp;</button>
                                <div class="dropdown-menu" role="menu"><a class="dropdown-item" role="presentation" href="/post?id_post=${articulo.id}">Ver</a><a class="dropdown-item" role="presentation" href="/edita?id_post=${articulo.id}">Editar</a><a class="dropdown-item" role="presentation" href="/delete?id_post=${articulo.id}">Eliminar</a></div>
                            </div>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </section>
</main>
<div class="footer-clean">
    <footer></footer>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
<script src="assets/js/smoothproducts.min.js"></script>
<script src="assets/js/theme.js"></script>
</body>

</html>
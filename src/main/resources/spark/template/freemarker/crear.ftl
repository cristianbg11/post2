<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Articulo</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/Article-List.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/smoothproducts.css">
    <link rel="stylesheet" href="assets/css/Bootstrap-Tags-Input.css">
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
<main class="page contact-us-page">
    <section class="clean-block clean-form dark">
        <div class="container">
            <div class="block-heading">
                <h2 class="text-info">Crear articulo</h2>
            </div>
            <form action="/crear-articulo" method="POST">
                <div class="form-group"><label>Titulo</label><input class="form-control" name="titulo" type="text"></div>
                <div class="form-group"><label>Cuerpo</label><textarea class="form-control" name="cuerpo"></textarea></div>
                <div class="form-group"><label>Autor</label><input class="form-control" readonly type="text" name="autor" value="${usuario.nombre}"></div>
                <div class="form-group"><label>Fecha</label><input class="form-control" type="date" name="fecha"></div>
                <div class="form-group"><label>Etiqueta</label><input type="text" placeholder="Agrega tags" class="form-control" data-role="tagsinput" data-class="label-info" name="etiqueta"/></div>
                <div class="form-group"><button class="btn btn-primary btn-block" type="submit">Enviar</button></div>
            </form>
        </div>
    </section>
</main>
<footer class="page-footer dark" style="margin-top: 0px;"></footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
<script src="assets/js/smoothproducts.min.js"></script>
<script src="assets/js/theme.js"></script>
<script src="assets/js/Bootstrap-Tags-Input-1.js"></script>
<script src="assets/js/Bootstrap-Tags-Input.js"></script>
</body>

</html>
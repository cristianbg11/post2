<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Usuarios</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/Article-List.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/smoothproducts.css">
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
<main class="page pricing-table-page">
    <section class="clean-block clean-pricing dark">
        <div class="container">
            <div class="block-heading">
                <h2 class="text-info">Usuarios</h2>
                <p>Listado de usuarios registrados en la base de datos. Solo administradores permitidos a esta pagina.</p>
            </div>
            <div class="row justify-content-center">
                <#list users as user>
                    <div class="col-md-5 col-lg-4">
                        <div class="clean-pricing-item">
                            <div class="heading">
                                <h3>${user.username}</h3>
                            </div>
                            <div class="features">
                                <h4><span class="feature">Nombre:&nbsp;</span><span>${user.nombre}</span></h4>
                                <h4><span class="feature">Administrador:&nbsp;</span><span>${user.administrador?then('Si', 'No')}</span></h4>
                                <h4><span class="feature">Autor:&nbsp;</span><span>${user.autor?then('Si', 'No')}</span></h4>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
    </section>
</main>
<footer class="page-footer dark" style="margin-top: 0px;"></footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
<script src="assets/js/smoothproducts.min.js"></script>
<script src="assets/js/theme.js"></script>
</body>

</html>
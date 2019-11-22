<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Practica4</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/Article-List.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/smoothproducts.css">
    <link rel="stylesheet" href="assets/css/Footer-Clean.css">
    <link rel="stylesheet" href="css/jPages.css">
    <link rel="stylesheet" href="assets/css/Filter.css" />
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
<div class="article-list">
    <div class="container">
        <div class="intro">
            <h2 class="text-center">Ultimos articulos</h2>
        </div>
        <div class="filter">
            <form>
                <select onchange="location = this.options[this.selectedIndex].value;">
                    <option value="/index">Tags</option>
                    <option value="/index">Todos</option>
                    <#if etiquetas?has_content>
                        <#list etiquetas as etiqueta>
                            <option value="/index?id_tag=${etiqueta}">${etiqueta}</option>
                        </#list>
                    </#if>
                </select>
            </form>
        </div>
        <div class="cont">
            <div id="itemContainer" class="row articles">
                <#if articulos?has_content>
                    <#list articulos as articulo>
                        <#if tag?has_content>
                            <#list articulo.etiquetasById as etiqueta>
                                <#if tag==etiqueta.etiqueta>
                                    <div class="col-sm-6 col-md-4 item"><a href="#"></a>
                                        <h3 class="name">${articulo.titulo}</h3>
                                        <p class="description">${articulo.cuerpo[0..70]}</p>
                                        <a class="action" href="/post?id_post=${articulo.id}"><i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </#if>
                            </#list>
                        <#else>
                            <div class="col-sm-6 col-md-4 item"><a href="#"></a>
                                <h3 class="name">${articulo.titulo}</h3>
                                <p class="description">${articulo.cuerpo[0..70]}</p>
                                <a class="action" href="/post?id_post=${articulo.id}"><i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </#if>
                    </#list>
                </#if>
            </div>
        </div>
        <div class="holder">
        </div>
    </div>
</div>

<div class="footer-clean">
    <footer>
    </footer>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
<script src="assets/js/smoothproducts.min.js"></script>
<script src="assets/js/theme.js"></script>
<script src="js/jPages.js"></script>
<script>
    $(function(){
        /* initiate the plugin */
        $("div.holder").jPages({
            containerID  : "itemContainer",
            perPage      : 5,
            startPage    : 1,
            startRange   : 1,
            midRange     : 5,
            endRange     : 1
        });
    });
</script>
</body>
</html>
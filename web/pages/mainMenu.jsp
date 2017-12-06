<%-- 
    Document   : mainMenu
    Created on : 02-dic-2017, 20:57:13
    Author     : adoha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
        <link rel="stylesheet" href="/autopark-19k/css/base.css">
        <link rel="stylesheet" href="/autopark-19k/css/mainMenu.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
    </head>
    <body>
        <div  id="navbarmain" class="pos-f-t">
            <nav class="navbar navbar-dark bg-dark">
                <div id="logoword">
                    <span class="blue">Auto</span> <span class="orange">Park</span>
                </div>
                <button id="mainbutton" class="navbar-toggler" type="button" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </nav>
            <div class="collapse" id="navbarToggleExternalContent">
                <div class="bg-dark p-4">
                    <ul class="list-group">
                        <li class="list-group-item"><a href="/autopark-19k/pages/Inicio.jsp">Inicio</a></li>
                        <li class="list-group-item"><a href="/autopark-19k/pages/MantenedorEstacionamiento.jsp">Estacionamientos</a></li>
                        <li class="list-group-item"><a href="/autopark-19k/pages/PaginaPrincipal.jsp">Pago de Tickets</a></li>
                        <li class="list-group-item"><a href="/autopark-19k/pages/BuscarPedidos.jsp">Historial de Pagos</a></li>
                        <li class="list-group-item"><a href="#">Soporte</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {

                $("#navbarmain").mouseenter(function () {
                    $("#navbarToggleExternalContent").finish();
                    $("#navbarToggleExternalContent").slideDown('fast');
                    $("#navbarToggleExternalContent").addClass("show");

                });
                $("#navbarmain").mouseleave(function () {
                    $("#navbarToggleExternalContent").finish();
                    $("#navbarToggleExternalContent").slideUp('fast');
                    $("#navbarToggleExternalContent").removeClass("show");

                });

                $(".navbar-toggler").click(function () {
                    $("#navbarToggleExternalContent").slideToggle('fast');
                    $("#navbarToggleExternalContent").toggleClass("show");
                });
            });
        </script>
    </body>
</html>

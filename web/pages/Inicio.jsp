<%-- 
    Document   : Inicio
    Created on : 06-dic-2017, 1:33:51
    Author     : adoha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Custom fonts for this template -->
        <link href="https://blackrockdigital.github.io/startbootstrap-landing-page/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="https://blackrockdigital.github.io/startbootstrap-landing-page/vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
        <link href="https://blackrockdigital.github.io/startbootstrap-landing-page/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="https://blackrockdigital.github.io/startbootstrap-landing-page/css/landing-page.min.css" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            i:before{
                color: #c30;
            }
            body {
                background-image: url('/autopark-19k/images/AutoPark-Logo.png')!important;
                background-size: 800px!important;
                background-position: center 150px!important;
                background-repeat: no-repeat!important;
            }
            .bg-dark {
                background-color: transparent !important;
            }
            .features-icons {
                padding-top: 550px!important;
                padding-bottom: 7rem!important;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/mainMenu.jsp" />

        <!-- Icons Grid -->
        <section class="features-icons  text-center">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                            <div class="features-icons-icon d-flex">
                                <i class="icon-screen-desktop m-auto text-primary"></i>
                            </div>
                            <h3>Fully Responsive</h3>
                            <p class="lead mb-0">This theme will look great on any device, no matter the size!</p>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                            <div class="features-icons-icon d-flex">
                                <i class="icon-layers m-auto text-primary"></i>
                            </div>
                            <h3>Bootstrap 4 Ready</h3>
                            <p class="lead mb-0">Featuring the latest build of the new Bootstrap 4 framework!</p>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="features-icons-item mx-auto mb-0 mb-lg-3">
                            <div class="features-icons-icon d-flex">
                                <i class="icon-check m-auto text-primary"></i>
                            </div>
                            <h3>Fácil de Usar</h3>
                            <p class="lead mb-0">Con una interfaz </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>

<%-- 
    Document   : MantenedorEstacionamiento
    Created on : 02-12-2017, 18:41:19
    Author     : Serph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="listaEstacionamientos" scope="page" class="dao.EstacionamientoDaoImp"/>
<jsp:useBean id="estacionamientos" class="dao.EstacionamientoDaoImp" />
<jsp:useBean id="tickets" class="dao.DetalleTicketDaoImp" />
<jsp:useBean id="boletas" class="dao.BoletaDaoImp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/autopark-19k/css/map.css">
        <link rel="stylesheet" href="/autopark-19k/css/pagoTickets.css">
        <link rel="stylesheet" href="/autopark-19k/css/vistaEstacionamiento.css">

        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDWReh5q1uQVH-bmpTKXFJXeAroCCuFJ80"></script>
        <script type="text/javascript" src="https://cdn.sobekrepository.org/includes/gmaps-markerwithlabel/1.9.1/gmaps-markerwithlabel-1.9.1.min.js"></script>
        <title>Mantenedor/Grilla</title>
    </head>
    <body>
        <jsp:include page="/pages/mainMenu.jsp" />
        <div id="vista-estacionamientos" class="right-container">
            <div class="container-title">
                <h4>Estacionamientos</h4>
            </div>
            <div class="container-content">
                <div id="datos-pago">
                    <div id="est_select">
                        <c:forEach var="estacionamiento" items="${estacionamientos.listar()}">
                            <div class="est">
                                <input type="hidden" class="lat" value="${estacionamiento.getLatitud()}" />
                                <input type="hidden" class="lng" value="${estacionamiento.getLongitud()}" />
                                <input onclick="toggleDetails(this)" name="estacionamiento" class="addTicketchk" id="ticket_est_${estacionamiento.getId()}" type="radio" value="${estacionamiento.getId()}" />
                                <label id="label_${estacionamiento.getId()}" class="addTicket" for="ticket_est_${estacionamiento.getId()}">${estacionamiento.getDescripcion()}</label>
                                <p class="estDetails">
                                    <b>LAT:</b> ${estacionamiento.getLatitud()}
                                    <br/>
                                    <b>LNG:</b> ${estacionamiento.getLongitud()}
                                    <br/>
                                    <b>Monto:</b> $${estacionamiento.getMonto()}
                                    <br/>
                                    <a href="https://www.google.com/maps/?q=${estacionamiento.getLatitud()},${estacionamiento.getLongitud()}">Ver en Google Maps</a> 
                                </p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <button id="datosBoucher" onclick="toggleAgregarEstacionamiento();" value="continuar" type="submit" class="btn btn-primary btn-block">Agregar Estacionamiento</button>
                <div id='agregar-est'>
                    <form action="/autopark-19k/AgregarEst" method="POST">
                        <p>
                            <input class="form-control" type="text" name="txtDescripcion" value="" placeholder="Descripción" required/>
                        </p>
                        <p>
                            <input class="form-control" min="0" type="number" name="txtMonto" value="" placeholder="Monto" required/>
                        </p>
                        <p>
                            <input class="form-control" type="number" step="any" name="txtLatitud" value="" placeholder="Latitud" required/>
                        </p>
                        <p>
                            <input class="form-control" type="number" step="any" name="txtLongitud" value="" placeholder="Longitud" required/>
                        </p>
                        <p>
                            <button type="submit" value="Grabar" name="btnGrabar" class="btn btn-primary btn-block">Agregar</button>
                        </p>
                    </form> 
                </div>
            </div>
        </div>




        <div id="map_canvas"></div>
        <script type="text/javascript">
            var markers = [];
            var infoWindows = [];
            var map;
            $(document).ready(function () {
                if (${sessionScope.cliente != null}) {
                    $("#datos-personales").hide();
                    $("#datos-pago").show();
                }
            <c:if test="${ticketEliminado != null}">
                $("#datos-pago").hide();
                $("#boucher").show();
            </c:if>
                var styledMapType = new google.maps.StyledMapType(
                        [
                            {
                                "featureType": "all",
                                "elementType": "all",
                                "stylers": [
                                    {
                                        "invert_lightness": true
                                    },
                                    {
                                        "saturation": 10
                                    },
                                    {
                                        "lightness": 30
                                    },
                                    {
                                        "gamma": 0.5
                                    },
                                    {
                                        "hue": "#435158"
                                    }
                                ]
                            }
                        ]
                        );
                var latLng = new google.maps.LatLng(-33.441919, -70.651274);
                var homeLatLng = new google.maps.LatLng(49.47805, -123.84716);
                map = new google.maps.Map(document.getElementById('map_canvas'), {
                    zoom: 16,
                    center: latLng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    mapTypeControl: false,
                    fullscreenControl: false,
                });
                map.mapTypes.set('styled_map', styledMapType);
                map.setMapTypeId('styled_map');
            <c:forEach var ="estacionamiento" items="${estacionamientos.listar()}" >
                var marker = new MarkerWithLabel({
                    position: new google.maps.LatLng(${estacionamiento.getLatitud()},${estacionamiento.getLongitud()}),
                    draggable: false,
                    raiseOnDrag: false,
                    map: map,
                    labelContent: "<div id='est_${estacionamiento.getId()}' class='tip'>${estacionamiento.getDescripcion()}</div>",
                    labelAnchor: new google.maps.Point(${(estacionamiento.getDescripcion().length() *9)/2}, 52),
                    labelClass: "labels pointed", // the CSS class for the label
                    labelStyle: {opacity: 1.0},
                    icon: "http://media.philly.com/images/small_red.png",
                    id: ${estacionamiento.getId()}
                });

                var infowindow = new google.maps.InfoWindow({
                    content: "",
                    pixelOffset: new google.maps.Size(0, -60)
                });

                google.maps.event.addListener(map, 'click', (function (marker) {
                    deactivateMarkers();
                    infowindow.close();

                }));

                google.maps.event.addListener(map, 'zoom_changed', (function (marker) {
                    deactivateMarkers();
                    infowindow.close();

                }));

                google.maps.event.addListener(marker, 'click', (function (marker) {
                    return function () {
                        activateMarker(marker);
                        infowindow.open(map, marker);
                        infowindow.setContent("<span style='color:black'><b>LAT:</b> ${estacionamiento.getLatitud()}<br/><b>LNG:</b> ${estacionamiento.getLongitud()}<br/><b>Monto:</b> $${estacionamiento.getMonto()}<br/><a href='https://www.google.com/maps/?q=${estacionamiento.getLatitud()},${estacionamiento.getLongitud()}'>Ver en Google Maps</a></span> ");
                    }
                })(marker));


                infoWindows.push(infowindow);
                markers.push(marker);

            </c:forEach>

            });
            window.addEventListener('load', function () {
                for (var i = 0; i < markers.length; i++) {
                    markers[i].set("labelAnchor", new google.maps.Point(document.getElementById("est_" + markers[i].get("id")).offsetWidth / 2 + 19, 52));
                }
            }
            );

            function deactivateMarkers() {
                $(".addTicket").removeClass("estInputHovered");
                for (var i = 0; i < markers.length; i++) {
                    markers[i].set("labelClass", "labels pointed");
                    infoWindows[i].close();
                }
            }

            function activateMarker(marker) {

                if (marker.get("labelClass") == "labels pointed active") {
                    marker.set("labelClass", "labels pointed");
                    $("#label_" + marker.get("id")).removeClass("estInputHovered");
                } else {
                    deactivateMarkers();
                    //map.panTo(new google.maps.LatLng(marker.getPosition().lat(), marker.getPosition().lng()));
                    marker.set("labelClass", "labels pointed active");
                    $("#label_" + marker.get("id")).addClass("estInputHovered");
                }
            }

            function preventSubmit(element, event) {
                if (element == "continuar") {
                    continuarPago();
                    return false;
                }

                return true;
            }

            function continuarPago() {
                $("input[name='txtRut']").val($("input[name='temp_txtRut']").val());
                $("input[name='txtNombre']").val($("input[name='temp_txtNombre']").val());
                $("input[name='txtTelefono']").val($("input[name='temp_txtTelefono']").val());
                $("input[name='txtEmail']").val($("input[name='temp_txtEmail']").val());

                $("#datos-personales").slideToggle();
                $("#datos-pago").slideToggle();
            }


            $(".addTicket").mouseenter(function () {
                var lat = $(this).closest(".est").find(".lat").first().val();
                var lng = $(this).closest(".est").find(".lng").first().val();
                map.panTo(new google.maps.LatLng(lat, lng));
                deactivateMarkers();
                $("#est_" + $(this).closest(".est").find(".addTicketchk").first().val()).closest(".labels").addClass("active");
            });

            $(".addTicket").mouseleave(function () {
                $("#est_" + $(this).closest(".est").find(".addTicketchk").first().val()).closest(".labels").removeClass("active");
            });

            function toggleAgregarEstacionamiento() {
                if ($("#agregar-est").is(":hidden")) {
                    $("#datosBoucher").html("Volver a Estacionamientos");
                } else {

                    $("#datosBoucher").html("Agregar Estacionamiento");
                }

                $("#datos-pago").slideToggle();
                $("#agregar-est").slideToggle();
            }
            function toggleDetails(element) {
                $(".estDetails").not($(element).closest(".est").find(".estDetails")).slideUp()
                $(element).closest(".est").find(".estDetails").slideToggle();
            }

        </script>
        <h4>Listado Estacionamientos</h4>
        <table class="table table-striped" border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descripcion</th>
                    <th>Monto</th>
                    <th>Coordenadas</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="Est" items="${listaEstacionamientos.listar()}" >
                    <tr>
                        <td><c:out value="${ Est.getId() }" /></td> 
                        <td><c:out value="${ Est.getDescripcion()}" /></td>
                        <td><c:out value="${ Est.getMonto() }" /></td>      
                        <td><c:out value="${ Est.getLatitud() }" />, <c:out value="${ Est.getLongitud() }" /></td>
                    </tr>
                </c:forEach>

            </tbody>
        </table>        
        <a href="/autopark-19k/pages/AgregarEst.jsp"><input type="submit" value="Nuevo" /></a>
        <a href="/autopark-19k/pages/ModificarEst.jsp"><input type="submit" value="Modificar" /></a>
        <form action="/autopark-19k/EliminarEstacionamiento">            
            <input type="submit" value="Eliminar ID" name="btnEliminar" />
            <select name="cmbIdEst">
                <c:forEach var="Est" items="${listaEstacionamientos.listar()}">
                    <option>${Est.getId()}</option>
                </c:forEach>
            </select>
        </form>

        <c:set var="mensaje" scope="request" value="${mensaje}" />
        <c:if test="${mensaje != null }">
            <script>
                confirm("${mensaje}")
            </script>
        </c:if>

    </body>
</html>

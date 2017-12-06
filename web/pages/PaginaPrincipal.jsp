<%-- 
    Document   : PaginaPrincipal
    Created on : 01-dic-2017, 13:40:47
    Author     : adoha
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="estacionamientos" class="dao.EstacionamientoDaoImp" />
<jsp:useBean id="tickets" class="dao.DetalleTicketDaoImp" />
<jsp:useBean id="boletas" class="dao.BoletaDaoImp" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" href="/autopark-19k/css/map.css">
        <link rel="stylesheet" href="/autopark-19k/css/pagoTickets.css">

        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDWReh5q1uQVH-bmpTKXFJXeAroCCuFJ80"></script>
        <script type="text/javascript" src="https://cdn.sobekrepository.org/includes/gmaps-markerwithlabel/1.9.1/gmaps-markerwithlabel-1.9.1.min.js"></script>
        <title>AutoPark - Pagina Principal</title>
    </head>
    <body>
        <jsp:include page="/pages/mainMenu.jsp" />
        <div id="pago-tickets" class="right-container">
            <div class="container-title">
                <h4><span class="blue">Pago</span> de <span class="orange">Tickets</span></h4>
            </div>
            <div class="container-content">
                <c:if test="${sessionScope.cliente == null}">
                    <div id="datos-personales">
                        <form action="/autopark-19k/AgregarCliente" method="POST" id="pago-tickets-form">
                            <p>Antes de continuar, por favor, ingresa tus datos:</p>
                            <p><input required type="number" class="form-control" name="txtRut" placeholder="Rut (sin DV)"></p>
                            <p><input required type="text" class="form-control" name="txtNombre" placeholder="Nombre"></p>
                            <p><input required type="number" class="form-control" name="txtTelefono" placeholder="Teléfono"></p>
                            <p><input type="text" class="form-control" name="txtEmail" placeholder="E-mail"></p>
                            <button id="continuar" onclick="this.form.submited = this.value;" value="continuar" type="submit" class="btn btn-primary btn-block">Continuar</button>
                        </form>
                    </div>
                </c:if>
                <c:if test="${sessionScope.cliente != null}">
                    <div id="datos-pago">
                        <div id="est_select">
                            <h3>${sessionScope.cliente.getNombre()},</h3>
                            <p>haz click en un estacionamiento para agregar ticket.</p>
                            <form action="/autopark-19k/AgregarTicket" method="POST">
                                <c:forEach var="estacionamiento" items="${estacionamientos.listar()}">
                                    <p class="est">
                                        <input type="hidden" class="lat" value="${estacionamiento.getLatitud()}" />
                                        <input type="hidden" class="lng" value="${estacionamiento.getLongitud()}" />
                                        <input onclick="this.form.submit()" name="estacionamiento" class="addTicketchk" id="ticket_est_${estacionamiento.getId()}" type="radio" value="${estacionamiento.getId()}" />
                                        <label id="label_${estacionamiento.getId()}" class="addTicket" for="ticket_est_${estacionamiento.getId()}">${estacionamiento.getDescripcion()}</label>
                                        <span class="add">+</span>
                                    </p>
                                </c:forEach>
                            </form>
                        </div>
                    </div>
                    <button id="datosBoucher" onclick="continuarBoucher();" value="continuar" type="submit" class="btn btn-primary btn-block">Continuar a Boucher</button>
                    <div id="boucher">
                        <c:if test="${tickets.listarPorBoucher(boletas.getBoletaNoLista(sessionScope.cliente.getRut())).size() != 0}"> 
                            <p>Haz click en un ticket para removerlo.</p>
                            <c:set var="total" value="${0}"/>
                            <form action="/autopark-19k/removerTicket" method="POST">
                                <c:forEach var="ticket" items="${tickets.listarPorBoucher(boletas.getBoletaNoLista(sessionScope.cliente.getRut()))}">
                                    <p class="tickets">
                                        <input onclick="this.form.submit()" name="ticket" class="addTicketchk" id="ticket_${ticket.getN_ticket()}" type="radio" value="${ticket.getN_ticket()}" />
                                        <label id="ticket_label_${estacionamiento.getId()}" class="removeTicket" for="ticket_${ticket.getN_ticket()}">${estacionamientos.getEstacionamiento(ticket.getId_estacionamiento()).getDescripcion()} $${estacionamientos.getEstacionamiento(ticket.getId_estacionamiento()).getMonto()} Ticket #${ticket.getN_ticket()}</label>
                                        <span class="add">-</span>
                                    </p>
                                    <c:set var="total" value="${total + estacionamientos.getEstacionamiento(ticket.getId_estacionamiento()).getMonto()}"/>
                                </c:forEach>
                            </form>
                            <form action="/autopark-19k/PagarBoucher" method="POST">
                                <p>Forma de Pago <br /><br/>
                                    <select class="form-control" name="formaPago">
                                        <option>Transferencia</option>
                                        <option>Pago en Línea</option>
                                        <option>Orden de Compra</option>
                                    </select>
                                </p>
                                <p>Envío de Boleta <br /><br/>
                                    <select class="form-control" name="envioBoleta">
                                        <option>Correo Electrónico</option>
                                        <option>Dirección Particular</option>
                                    </select>
                                </p>
                                <button type="submit" class="btn btn-primary btn-block">Pagar $${total}</button>
                            </form>
                        </c:if>
                        <c:if test="${tickets.listarPorBoucher(boletas.getBoletaNoLista(sessionScope.cliente.getRut())).size() == 0}">
                            <p>No tienes tickets pendientes. Vuelve a estacionamientos para agregar tickets.</p>
                        </c:if>
                    </div>
                </c:if>
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
                <c:if test="${sessionScope.cliente != null}">
                var infowindow = new google.maps.InfoWindow({
                    content: "",
                    pixelOffset: new google.maps.Size(0, -60)
                });

                google.maps.event.addListener(infowindow, 'closeclick', function () {
                    deactivateMarkers();
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
                        infowindow.setContent("<form action='/autopark-19k/AgregarTicket' method='POST'><input type='hidden' name='estacionamiento' value='${estacionamiento.getId()}' /><input class='addTicket' type='submit' value='Agregar Ticket' /></form>");
                    }
                })(marker));



                infoWindows.push(infowindow);
                </c:if>
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

            function continuarBoucher() {
                if ($("#boucher").is(":hidden")) {
                    $("#datosBoucher").html("Volver a Estacionamientos");
                } else {

                    $("#datosBoucher").html("Continuar a Boucher");
                }

                $("#datos-pago").slideToggle();
                $("#boucher").slideToggle();
            }
        </script>
    </body>


</html>
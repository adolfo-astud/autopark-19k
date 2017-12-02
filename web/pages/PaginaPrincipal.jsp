<%-- 
    Document   : PaginaPrincipal
    Created on : 01-dic-2017, 13:40:47
    Author     : adoha
--%>

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="estacionamientos" class="dao.EstacionamientoDaoImp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>AutoPark - Pagina Principal</title>
        <style type="text/css">
            html,body,#map_canvas {
                height:100%;
                margin:0;
            }

            .tip {
                color:black;
                background-color:#3366ff;
                border-radius:3px;
                padding:7px 7px 7px 30px;
                text-align:center;
                font-size: 13px;
                color:white;
                background-image: url('http://www.willowsigns.com/images/products/parking-icon-reflective-sign-450x450mm-RdXH.png');
                background-size: auto 20px;
                background-position: 5px 5px;
                background-repeat: no-repeat;
                box-shadow: 5px 5px 5px #0009;
                margin: 0px 10px 10px 0;
                position: relative;
                white-space: nowrap;
            }

            .tip:after {
                top: 100%;
                left: 50%;
                border: solid transparent;
                content:" ";
                height: 0;
                width: 0;
                position: absolute;
                pointer-events: none;
                border-color: rgba(255, 255, 255, 0);
                border-top-color: #3366ff;
                border-width: 10px;
                margin-left: -10px;
            }

            .active .tip {
                background-color:#009966;
            }

            .active .tip:after {
                border-top-color: #009966;
            }
        </style>
        <script
            src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDWReh5q1uQVH-bmpTKXFJXeAroCCuFJ80&callback=initMap"></script>
        <script type="text/javascript" src="https://cdn.sobekrepository.org/includes/gmaps-markerwithlabel/1.9.1/gmaps-markerwithlabel-1.9.1.min.js"></script>

    </head>
    <body>
        <div id="map_canvas"></div>
        <div id="log">adwdawdawdad</div>
        <script type="text/javascript">
            var markers = [];
            $(document).ready(function () {
                var styledMapType = new google.maps.StyledMapType(
                        [
                            {
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#1d2c4d"
                                    }
                                ]
                            },
                            {
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#8ec3b9"
                                    }
                                ]
                            },
                            {
                                "elementType": "labels.text.stroke",
                                "stylers": [
                                    {
                                        "color": "#1a3646"
                                    }
                                ]
                            },
                            {
                                "featureType": "administrative.country",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#4b6878"
                                    }
                                ]
                            },
                            {
                                "featureType": "administrative.land_parcel",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#64779e"
                                    }
                                ]
                            },
                            {
                                "featureType": "administrative.province",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#4b6878"
                                    }
                                ]
                            },
                            {
                                "featureType": "landscape.man_made",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#334e87"
                                    }
                                ]
                            },
                            {
                                "featureType": "landscape.natural",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#023e58"
                                    }
                                ]
                            },
                            {
                                "featureType": "poi",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#283d6a"
                                    }
                                ]
                            },
                            {
                                "featureType": "poi",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#6f9ba5"
                                    }
                                ]
                            },
                            {
                                "featureType": "poi",
                                "elementType": "labels.text.stroke",
                                "stylers": [
                                    {
                                        "color": "#1d2c4d"
                                    }
                                ]
                            },
                            {
                                "featureType": "poi.park",
                                "elementType": "geometry.fill",
                                "stylers": [
                                    {
                                        "color": "#023e58"
                                    }
                                ]
                            },
                            {
                                "featureType": "poi.park",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#3C7680"
                                    }
                                ]
                            },
                            {
                                "featureType": "road",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#304a7d"
                                    }
                                ]
                            },
                            {
                                "featureType": "road",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#98a5be"
                                    }
                                ]
                            },
                            {
                                "featureType": "road",
                                "elementType": "labels.text.stroke",
                                "stylers": [
                                    {
                                        "color": "#1d2c4d"
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#2c6675"
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "geometry.stroke",
                                "stylers": [
                                    {
                                        "color": "#255763"
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#b0d5ce"
                                    }
                                ]
                            },
                            {
                                "featureType": "road.highway",
                                "elementType": "labels.text.stroke",
                                "stylers": [
                                    {
                                        "color": "#023e58"
                                    }
                                ]
                            },
                            {
                                "featureType": "transit",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#98a5be"
                                    }
                                ]
                            },
                            {
                                "featureType": "transit",
                                "elementType": "labels.text.stroke",
                                "stylers": [
                                    {
                                        "color": "#1d2c4d"
                                    }
                                ]
                            },
                            {
                                "featureType": "transit.line",
                                "elementType": "geometry.fill",
                                "stylers": [
                                    {
                                        "color": "#283d6a"
                                    }
                                ]
                            },
                            {
                                "featureType": "transit.station",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#3a4762"
                                    }
                                ]
                            },
                            {
                                "featureType": "water",
                                "elementType": "geometry",
                                "stylers": [
                                    {
                                        "color": "#0e1626"
                                    }
                                ]
                            },
                            {
                                "featureType": "water",
                                "elementType": "labels.text.fill",
                                "stylers": [
                                    {
                                        "color": "#4e6d70"
                                    }
                                ]
                            }
                        ]
                        );
                var latLng = new google.maps.LatLng(-33.441919, -70.651274);
                var homeLatLng = new google.maps.LatLng(49.47805, -123.84716);
                var map = new google.maps.Map(document.getElementById('map_canvas'), {
                    zoom: 16,
                    center: latLng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    mapTypeControl: false
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
                    labelClass: "labels", // the CSS class for the label
                    labelStyle: {opacity: 1.0},
                    icon: "http://media.philly.com/images/small_red.png",
                    id: ${estacionamiento.getId()}
                });
                
                

                google.maps.event.addListener(marker, 'click', (function (marker) {
                    return function () {
                        for (var i = 0; i < markers.length; i++) {
                            markers[i].set("labelClass", "");
                        }

                        // set the icon for the clicked marker
                        marker.set("labelClass", "active");

                        // update the value of activeMarker

                    }
                })(marker));


                markers.push(marker);

            </c:forEach>

            });

        </script>
        <script>
            $(window).on("load", (function () {
                for (var i = 0; i < markers.length; i++) {
                    markers[i].set("labelAnchor", new google.maps.Point(document.getElementById("est_" + markers[i].get("id")).offsetWidth / 2, 52));
                }
            }
            ));
        </script>
    </body>


</html>
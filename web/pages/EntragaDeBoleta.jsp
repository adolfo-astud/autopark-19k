<%-- 
    Document   : EntregaDeBoleta
    Created on : 05-12-2017, 19:04:51
    Author     : Serph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="estacionamientos" class="dao.EstacionamientoDaoImp" />
<jsp:useBean id="tickets" class="dao.DetalleTicketDaoImp" />
<jsp:useBean id="boletas" class="dao.BoletaDaoImp" />
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/autopark-19k/css/map.css">
        <link rel="stylesheet" href="/autopark-19k/css/pagoTickets.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entrega de Boleta</title>
    </head>
    <body>
        <jsp:include page="/pages/mainMenu.jsp" />
        <div class="container-main">
            <c:set var="boleta" scope="request" value="${boleta}" ></c:set>
            <h2>Boucher N° ${boleta.getN_boucher()}</h2>


            <p>Haz click en un ticket para removerlo.</p>

            <c:forEach var="ticket" items="${tickets.listarPorBoucher(boleta.getN_boucher())}" >


                <form action="/autopark-19k/EliminarTicket" method="POST">                                
                    <input type="hidden" name="txtN_ticket" value="${ticket.getN_ticket()}" />
                    <input type="hidden" name="txtN_Boleta" value="${boleta.getN_boucher()}" />
                    <p class="tickets">
                        <input onclick="this.form.submit()" name="ticket" class="addTicketchk" id="ticket_${ticket.getN_ticket()}" type="radio" value="${ticket.getN_ticket()}" />
                        <label id="ticket_label_${estacionamiento.getId()}" class="removeTicket" for="ticket_${ticket.getN_ticket()}">${estacionamientos.getEstacionamiento(ticket.getId_estacionamiento()).getDescripcion()} $${estacionamientos.getEstacionamiento(ticket.getId_estacionamiento()).getMonto()} Ticket #${ticket.getN_ticket()}</label>
                        <span class="add">-</span>
                    </p>
                </form>

            </c:forEach>

            <h4> Total a Pagar: $ ${boleta.getTotal_boleta()}</h4>
            <h3 class="envio">Opcion de Envio: ${boleta.getOp_de_envio()}</h3>
            <p>
                Muchas gracias por su preferencia.
            </p>
            <p>
                <a href="/autopark-19k/pages/PaginaPrincipal.jsp">Volver</a>
            </p>

            <c:set var="mensaje" scope="request" value="${mensaje}" />
            <c:if test="${mensaje != null }">
                <script>
                confirm("${mensaje}")
                </script>
            </c:if>
        </div>

    </body>
</html>

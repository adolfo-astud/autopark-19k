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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entrega de Boleta</title>
    </head>
    <body>
        <c:set var="boleta" scope="request" value="${boleta}" ></c:set>
        <h2>Boucher N° ${boleta.getN_boucher()}</h2>
        
        
        <table border="1">
            <thead>
                <tr>
                    <th>Estacionamiento</th>
                    <th>Monto</th>
                    <th>N° Ticket</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ticket" items="${tickets.listarPorBoucher(boleta.getN_boucher())}" >
                    <tr>
                        <td>${ estacionamientos.getEstacionamiento(ticket.getId_estacionamiento()).getDescripcion() }</td>
                        <td>${ estacionamientos.getEstacionamiento(ticket.getId_estacionamiento()).getMonto() }</td>
                        <td>${ ticket.getN_ticket() }</td>
                        <td> 
                            <form action="/autopark-19k/EliminarTicket" method="POST">                                
                                <input type="hidden" name="txtN_ticket" value="${ticket.getN_ticket()}" />
                                <input type="hidden" name="txtN_Boleta" value="${boleta.getN_boucher()}" />
                                <input type="submit" value="-" name="btnEliminar" />
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <h2> Total a Pagar: $ ${boleta.getTotal_boleta()}</h2>
        <h3>Opcion de Envio: ${boleta.getOp_de_envio()}</h3>
        
        Muchas gracias por su preferencia.
        
        
        <c:set var="mensaje" scope="request" value="${mensaje}" />
        <c:if test="${mensaje != null }">
            <script>
                confirm("${mensaje}")
            </script>
        </c:if>
        

    </body>
</html>

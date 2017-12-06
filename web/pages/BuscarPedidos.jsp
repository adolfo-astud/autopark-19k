<%-- 
    Document   : BuscarPedidos
    Created on : 04-12-2017, 17:05:20
    Author     : Diego
--%>

<%@page import="dto.EstacionamientoDto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="listaRut"  scope="page"  class="dao.ClienteDaoImp" />
<jsp:useBean id="listaboletas" scope="page" class="dao.BoletaDaoImp" />


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="/pages/mainMenu.jsp" />
        <div class="container-main">
            <h2>Buscar Pedidos</h2>

            <form action="/autopark-19k/BuscarPedidos" method="POST">
                <table border="0">

                    <tbody>
                        <tr>
                            <td><input type="text" class="form-control" placeholder="Ingresa RUT" name="ddlRut">
                            </td>
                            <td> <button type="submit" value="Buscar" name="btnBuscar" class="btn btn-primary btn-block">Buscar</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </form>
            <c:set var="lista" scope="request" value="${lista}" ></c:set>
            <c:if test="${lista.size() != 0}">                
                <table class="table table-dark">
                    <thead>
                        <tr>
                            <th>Estacionamiento</th>
                            <th>Monto</th>
                            <th>Pedir</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="boleta" items="${lista}" >
                            <tr>
                                <td>${ listaboletas.descripcionBoleta(boleta.getN_boucher()) }</td>
                                <td>${ boleta.getTotal_boleta() }</td>
                                <td> 
                                    <form action="/autopark-19k/EntregaDeBoleta" method="POST">
                                        <input type="hidden" name="txtN_Boleta" value="${boleta.getN_boucher()}" />
                                        <input type="submit" value="+" name="btnPedir" />
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>        
            </c:if>  
        </div>
        <c:set var="mensaje" scope="request" value="${mensaje}" />
        <c:if test="${mensaje != null }">
            <script>
                alert("${mensaje}");
            </script>
        </c:if>
    </body>
</html>

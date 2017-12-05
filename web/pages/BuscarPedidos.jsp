<%-- 
    Document   : BuscarPedidos
    Created on : 04-12-2017, 17:05:20
    Author     : Diego
--%>

<%@page import="dto.EstacionamientoDto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="listaRut" class="dao.ClienteDaoImp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h3>Buscar Pedidos</h3>
        <form action="/autopark_19K/BuscarPedidos" method="POST">
            <table border="0">
                
                <tbody>
                    <tr>
                        <td><select name="ddlRut">
                                <option>Rut Cliente</option>
                                <c:forEach var="Rut" items="${listaRut.listarRut()}">
                                <option>${Rut}</option>
                                </c:forEach>
                            </select></td>
                            <td> <input type="submit" value="Buscar" name="btnBuscar" /></td>
                    </tr>
                </tbody>
            </table>

        </form>
        
         <% ArrayList<EstacionamientoDto> lista = 
              (ArrayList<EstacionamientoDto>)request.getAttribute("lista"); 
        if(lista!=null){%>                     
        <table border="1">
            <thead>
                <tr>
                    <th>Estacionamiento</th>
                    <th>Monto</th>
                    <th>Pedir</th>
                </tr>
            </thead>
            <tbody>
                <% for(EstacionamientoDto dto: lista){ %>
                    <tr>
                        <td><%= dto.getDescripcion() %></td>
                        <td><%= dto.getMonto() %></td>
                        <td> <input type="submit" value="+" name="btnPedir" /></td>
                    </tr>
                <% } %>    
            </tbody>
        </table>

        
        <% }%>
        
    </body>
</html>

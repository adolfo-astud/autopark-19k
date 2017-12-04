<%-- 
    Document   : MantenedorEstacionamiento
    Created on : 02-12-2017, 18:41:19
    Author     : Serph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="listaEstacionamientos" scope="page" class="dao.EstacionamientoDaoImp"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mantenedor/Grilla</title>
    </head>
    <body>
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

<%-- 
    Document   : ModificarEst
    Created on : 02-12-2017, 20:01:59
    Author     : Serph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="ListaEst" scope="page" class="dao.EstacionamientoDaoImp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Modificar Farmaco</h1>

        <form action="/autopark-19k/ModificarEst" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Id Farmaco</td>
                        <td>
                            <select name="cmbIdEst">
                                <c:forEach var="Est" items="${ListaEst.listar()}">
                                    <option>${ Est.getId() }</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Descripcion</td>
                        <td><input type="text" name="txtDescripcion" value="" required/></td>
                    </tr>
                    <tr>
                        <td>Monto</td>
                        <td><input min="0" type="number" name="txtMonto" value="" required/></td>
                    </tr>
                    <tr>
                        <td>Latitud</td>
                        <td><input type="number" step="any" name="txtLatitud" value="" required/></td>
                    </tr>
                    <tr>
                        <td>Longitud</td>
                        <td><input type="number" step="any" name="txtLongitud" value="" required/></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Modificar" name="btnGrabar" />                    
        </form>
        <a href="/autopark-19k/pages/MantenedorEstacionamiento.jsp"><input type="submit" value="Cancelar" /></a>
        <br>
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
                <c:forEach var="Est" items="${ListaEst.listar()}" >
                 <tr>
                    <td><c:out value="${ Est.getId() }" /></td> 
                    <td><c:out value="${ Est.getDescripcion()}" /></td>
                    <td><c:out value="${ Est.getMonto() }" /></td>      
                    <td><c:out value="${ Est.getLatitud() }" />, <c:out value="${ Est.getLongitud() }" /></td>
                 </tr>
                </c:forEach>                
            </tbody>
        </table>   
    </body>
</html>

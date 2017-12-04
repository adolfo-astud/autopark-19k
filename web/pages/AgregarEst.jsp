<%-- 
    Document   : AgregarEst
    Created on : 02-12-2017, 19:45:10
    Author     : Serph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="listaEst" class="dao.EstacionamientoDaoImp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Estacionamiento</title>
    </head>
    <body>
        <h1>Agregar Est</h1>
        <form action="/autopark-19k/AgregarEst" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <th>Descripcion</th>
                        <td><input type="text" name="txtDescripcion" value="" required/></td>
                    </tr>
                    <tr>
                        <th>Monto</th>
                        <td><input min="0" type="number" name="txtMonto" value="" required/></td>
                    </tr>
                    <tr>
                        <th>Latitud</th>
                        <td><input type="number" step="any" name="txtLatitud" value="" required/></td>
                    </tr>
                    <tr>
                        <td>Longitud</td>
                        <td><input type="number" step="any" name="txtLongitud" value="" required/></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Grabar" name="btnGrabar" /> 
        </form> 
        <a href="/autopark-19k/pages/MantenedorEstacionamiento.jsp"><input type="submit" value="Cancelar" /></a>
    </body>
</html>

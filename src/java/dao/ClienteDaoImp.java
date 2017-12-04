/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ClienteDto;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sql.Conexion;

/**
 *
 * @author Serph
 */
public class ClienteDaoImp implements ClienteDao{

    @Override
    public boolean agregar(ClienteDto dto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean eliminar(ClienteDto dto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean modificar(ClienteDto dto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<String> listarRut() {
        try (PreparedStatement listar = Conexion.getConexion().prepareStatement( "SELECT * FROM cliente")) {
            try (ResultSet rs = listar.executeQuery()) {
                List listado = new ArrayList<>();
                while (rs.next()) {
                    listado.add(rs.getString("rut"));
                }

                return listado;
            }
        } catch (SQLException ex) {
            System.out.println("Problema listando ruts: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    @Override
    public ClienteDto getCliente(int rut) {
        String query = "SELECT * FROM cliente where rut = ?";
        try (PreparedStatement buscar = Conexion.getConexion().prepareStatement(query)) {
            buscar.setInt(1,rut);
            try (ResultSet rs = buscar.executeQuery()) {
                if (rs.next()) {
                    ClienteDto cliente = new ClienteDto();
                    
                    cliente.setRut(rut);
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setEmail(rs.getString("e-mail"));

                    return cliente;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema Obteninedo cliente: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
    
}

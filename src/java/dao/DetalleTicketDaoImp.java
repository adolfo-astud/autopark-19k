/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.DetalleTicketDto;
import java.sql.Connection;
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
public class DetalleTicketDaoImp implements DetalleTicketDao{

    @Override
    public boolean agregar(DetalleTicketDto dto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean eliminar(DetalleTicketDto dto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean modificar(DetalleTicketDto dto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<DetalleTicketDto> listarPorBoucher(int n_boucher) {
        String query = "SELECT * FROM ticket where n_boucher = ?";
        try (PreparedStatement listar = Conexion.getConexion().prepareStatement(query)) {
            listar.setInt(1,n_boucher);
            try (ResultSet rs = listar.executeQuery()) {
                List tickets = new ArrayList<DetalleTicketDto>();
                while (rs.next()) {
                    DetalleTicketDto ticket = new DetalleTicketDto();
                    
                    
                    ticket.setN_boucher(n_boucher);
                    ticket.setN_ticket(rs.getInt("n_ticket"));
                    ticket.setId_estacionamiento(rs.getInt("Id_estacionamiento"));

                    tickets.add(ticket);
                }

                return tickets;
            }
        } catch (SQLException ex) {
            System.out.println("Problema listando estacionamientos: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
    
}

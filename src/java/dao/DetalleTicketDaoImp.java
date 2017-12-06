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
        String query = "INSERT INTO ticket(id_estacionamiento,n_boucher) values(?,?)";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement insert = conexion.prepareStatement(query)) {
                
                insert.setInt(1, dto.getId_estacionamiento());
                insert.setInt(2, dto.getN_boucher());

                if (insert.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema insertando ticket: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    @Override
    public boolean eliminar(DetalleTicketDto dto) {
        String query = "DELETE FROM ticket WHERE n_ticket = ?";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement delete = conexion.prepareStatement(query)) {
                delete.setInt(1, dto.getN_ticket());

                if (delete.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema eliminando ticket: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
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
            System.out.println("Problema listando tickets: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    @Override
    public DetalleTicketDto getTicket(int n_ticket) {
        String query = "SELECT * FROM ticket where n_ticket = ?";
        try (PreparedStatement buscar = Conexion.getConexion().prepareStatement(query)) {
            buscar.setInt(1,n_ticket);
            try (ResultSet rs = buscar.executeQuery()) {
                if (rs.next()) {
                    
                    DetalleTicketDto ticket = new DetalleTicketDto();
                    
                    ticket.setN_ticket(n_ticket);
                    ticket.setN_boucher(rs.getInt("n_boucher"));
                    ticket.setId_estacionamiento(rs.getInt("Id_estacionamiento"));
                       System.out.println("ticket con n de boleta :"+rs.getInt("n_boucher"));
                    return ticket;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema Obteninedo boleta: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BoletaDto;
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
public class BoletaDaoImp implements BoletaDao {

    @Override
    public boolean agregar(BoletaDto dto) {
        String query = "INSERT INTO boucher(op_de_envio,forma_de_pago, total_boleta, rut_cliente) values(?,?,0,?)";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement insert = conexion.prepareStatement(query)) {
                insert.setString(1, dto.getOp_de_envio());
                insert.setString(2, dto.getForma_de_pago());
                insert.setInt(3, dto.getRut_cliente());

                if (insert.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema insertando Boleta: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    @Override
    public boolean eliminar(BoletaDto dto) {
        String query = "DELETE FROM boucher WHERE n_bocheur = ?";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement delete = conexion.prepareStatement(query)) {
                delete.setInt(1, dto.getN_boucher());

                if (delete.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema eliminando Boleta: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    @Override
    public boolean modificar(BoletaDto dto) {
        String query = "UPDATE boucher set op_de_envio = ?, forma_de_pago = ?, total_boleta = ?, rut_cliente = ?"
                + " WHERE n_boucher = ?";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement update = conexion.prepareStatement(query)) {
                update.setString(1, dto.getOp_de_envio());
                update.setString(2, dto.getForma_de_pago());
                update.setInt(3, dto.getTotal_boleta());
                update.setInt(4, dto.getRut_cliente());
                update.setInt(5, dto.getN_boucher());

                if (update.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema modificando Boleta: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    @Override
    public List<BoletaDto> listarPorRut(int rut) {
        String query = "SELECT * FROM boucher where rut_cliente = ?";
        try (PreparedStatement listar = Conexion.getConexion().prepareStatement(query)) {
            listar.setInt(1, rut);
            try (ResultSet rs = listar.executeQuery()) {
                List listado = new ArrayList<BoletaDto>();
                while (rs.next()) {
                    BoletaDto boleta = new BoletaDto();

                    boleta.setN_boucher(rs.getInt("n_boucher"));
                    boleta.setOp_de_envio(rs.getString("op_de_envio"));
                    boleta.setForma_de_pago(rs.getString("forma_de_pago"));
                    boleta.setTotal_boleta(rs.getInt("total_boleta"));
                    boleta.setRut_cliente(rut);

                    listado.add(boleta);
                }

                return listado;
            }
        } catch (SQLException ex) {
            System.out.println("Problema listando Boleta: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    @Override
    public String descripcionBoleta(int n_boucher) {

        String descripcion = "";
        for (DetalleTicketDto ticket : new DetalleTicketDaoImp().listarPorBoucher(n_boucher)) {
            descripcion += new EstacionamientoDaoImp().getEstacionamiento(ticket.getId_estacionamiento()).getDescripcion() + " / ";
        }
        return descripcion;
    }

    @Override
    public int getUltimaBoleta() {
        String query = "select max(n_boucher) as n_boucher from boucher";
        try (ResultSet rs = Conexion.getConexion().prepareStatement(query).executeQuery()) {
            if (rs.next()) {
                return rs.getInt("n_boucher");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BoletaDaoImp.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No se pudo encontrar la receta");
        }

        return 0;
    }

    @Override
    public int getBoletaNoLista(int rut) {
        String query = "select n_boucher from boucher where forma_de_pago = 'temp' and rut_cliente = ?";
        try (PreparedStatement buscar = Conexion.getConexion().prepareStatement(query)) {
            buscar.setInt(1,rut);
            try (ResultSet rs = buscar.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("n_boucher");
                }
            }
        } catch (SQLException ex) {
            System.out.println("No se pudo encotnrar la boleta no lista: " + ex.getMessage());
            Logger.getLogger(BoletaDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

}

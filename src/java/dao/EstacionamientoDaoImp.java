package dao;

import dto.EstacionamientoDto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sql.Conexion;

/**
 *
 * @author adoha
 */
public class EstacionamientoDaoImp implements EstacionamientoDao {

    @Override
    public List<EstacionamientoDto> listar() {
        String query = "SELECT * FROM estacionamiento";
        try (Connection conexion = Conexion.getConexion()) {
            try (ResultSet rs = conexion.prepareStatement(query).executeQuery()) {
                List estacionamientos = new ArrayList<EstacionamientoDto>();
                while (rs.next()) {
                    EstacionamientoDto estacionamiento = new EstacionamientoDto();
                    estacionamiento.setId(rs.getInt("id_estacionamiento"));
                    estacionamiento.setDescripcion(rs.getString("descripcion"));
                    estacionamiento.setMonto(rs.getInt("monto"));
                    estacionamiento.setLatitud((rs.getFloat("latitud") + 0));
                    estacionamiento.setLongitud((rs.getFloat("longitud") + 0));

                    estacionamientos.add(estacionamiento);
                }

                return estacionamientos;
            }
        } catch (SQLException ex) {
            System.out.println("Problema listando estacionamientos: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    @Override
    public boolean agregar(EstacionamientoDto dto) {
        String query = "INSERT INTO estacionamiento(descripcion,monto,coordenadas) values(?,?,?)";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement insert = conexion.prepareStatement(query)) {
                insert.setString(1, dto.getDescripcion());
                insert.setInt(2, dto.getMonto());
                insert.setFloat(3, dto.getLatitud());

                if (insert.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema insertando estacionamiento: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    @Override
    public boolean eliminar(EstacionamientoDto dto) {
        String query = "DELETE FROM estacionamiento WHERE id_estacionamiento = ?";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement delete = conexion.prepareStatement(query)) {
                delete.setInt(1, dto.getId());

                if (delete.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema eliminando estacionamiento: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    @Override
    public boolean modificar(EstacionamientoDto dto) {
        String query = "UPDATE estacionamiento set descripcion = ?, monto = ?, coordenadas = ? "
                + "WHERE id_estacionamiento = ?";
        try (Connection conexion = Conexion.getConexion()) {
            try (PreparedStatement update = conexion.prepareStatement(query)) {
                update.setString(1, dto.getDescripcion());
                update.setInt(2, dto.getMonto());
                //update.setString(3, dto.getCoordenadas());
                update.setInt(4, dto.getId());

                if (update.executeUpdate() > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema modificando estacionamiento: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    @Override
    public EstacionamientoDto getEstacionamiento(int id_estacionamiento) {
        String query = "SELECT * FROM estacionamiento where id_estacionamiento = ?";
        try (PreparedStatement buscar = Conexion.getConexion().prepareStatement(query)) {
            buscar.setInt(1,id_estacionamiento);
            try (ResultSet rs = buscar.executeQuery()) {
                if (rs.next()) {
                    EstacionamientoDto estacionamiento = new EstacionamientoDto();
                    
                    estacionamiento.setId(id_estacionamiento);
                    estacionamiento.setDescripcion(rs.getString("descripcion"));
                    estacionamiento.setMonto(rs.getInt("monto"));
                    estacionamiento.setLatitud((rs.getFloat("latitud") + 0));
                    estacionamiento.setLongitud((rs.getFloat("longitud") + 0));

                    return estacionamiento;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Problema listando estacionamientos: " + ex.getMessage());
            Logger.getLogger(EstacionamientoDaoImp.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

}

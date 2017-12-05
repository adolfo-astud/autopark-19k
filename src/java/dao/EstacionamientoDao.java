package dao;

import dto.EstacionamientoDto;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author adoha
 */
public interface EstacionamientoDao extends BaseDao<EstacionamientoDto>{
    public List<EstacionamientoDto> listar();
    public EstacionamientoDto getEstacionamiento(int n_ticket);
    public ArrayList<EstacionamientoDto> EstacionamientoPorRut(String Rut);
}

package dao;

import dto.EstacionamientoDto;
import java.util.List;

/**
 *
 * @author adoha
 */
public interface EstacionamientoDao extends BaseDao<EstacionamientoDto>{
    public List<EstacionamientoDto> listar();
}

package sql;
import java.sql.Connection;
import java.sql.DriverManager;
public class Conexion {   
        public static Connection getConexion() {

        Connection connection = null;
        try {
           String driverClassName = "com.mysql.jdbc.Driver";
           String driverUrl="jdbc:mysql://localhost/el_don_muerto_sano";
           Class.forName(driverClassName);
           connection = DriverManager.getConnection(driverUrl, "root","");
        }catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
    
}

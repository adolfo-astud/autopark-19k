
package dto;


public class ClienteDto {
    
    private int rut;
    private String nombre;
    private String telefono;
    private String email;

    public ClienteDto(int rut, String nombre, String telefono, String email) {
        this.rut = rut;
        this.nombre = nombre;
        this.telefono = telefono;
        this.email = email;
    }

    public ClienteDto() {
    }

    public int getRut() {
        return rut;
    }

    public void setRut(int rut) {
        this.rut = rut;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 41 * hash + this.rut;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ClienteDto other = (ClienteDto) obj;
        if (this.rut != other.rut) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ClienteDto{" + "rut=" + rut + ", nombre=" + nombre + ", telefono=" + telefono + ", email=" + email + '}';
    }
    
    
    
}

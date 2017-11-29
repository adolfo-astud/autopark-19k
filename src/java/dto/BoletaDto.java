
package dto;


public class BoletaDto {
    
    private int n_boucher;
    private String op_de_envio;
    private String forma_de_pago;
    private int total_boleta;
    private int rut_cliente;

    public BoletaDto(int n_boucher, String op_de_envio, String forma_de_pago, int total_boleta, int rut_cliente) {
        this.n_boucher = n_boucher;
        this.op_de_envio = op_de_envio;
        this.forma_de_pago = forma_de_pago;
        this.total_boleta = total_boleta;
        this.rut_cliente = rut_cliente;
    }

    public BoletaDto() {
    }

    public int getN_boucher() {
        return n_boucher;
    }

    public void setN_boucher(int n_boucher) {
        this.n_boucher = n_boucher;
    }

    public String getOp_de_envio() {
        return op_de_envio;
    }

    public void setOp_de_envio(String op_de_envio) {
        this.op_de_envio = op_de_envio;
    }

    public String getForma_de_pago() {
        return forma_de_pago;
    }

    public void setForma_de_pago(String forma_de_pago) {
        this.forma_de_pago = forma_de_pago;
    }

    public int getTotal_boleta() {
        return total_boleta;
    }

    public void setTotal_boleta(int total_boleta) {
        this.total_boleta = total_boleta;
    }

    public int getRut_cliente() {
        return rut_cliente;
    }

    public void setRut_cliente(int rut_cliente) {
        this.rut_cliente = rut_cliente;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 89 * hash + this.n_boucher;
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
        final BoletaDto other = (BoletaDto) obj;
        if (this.n_boucher != other.n_boucher) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "BoletaDto{" + "n_boucher=" + n_boucher + ", op_de_envio=" + op_de_envio + ", forma_de_pago=" + forma_de_pago + ", total_boleta=" + total_boleta + ", rut_cliente=" + rut_cliente + '}';
    }
    
    
    
}

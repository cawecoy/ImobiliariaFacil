/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SQL;

import java.sql.*;
/**
 *
 * @author Leonardo
 */
public class Pagamento {
    private Timestamp data;
    private float valor;
    private int cliente_cpf;
    private int imovel_cep;
    private int imovel_numero;
    private String nome_cliente;
    private int id_contrato;
    
    private ResultSet resultSetQuery;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;

    public Pagamento(Timestamp data, float valor, int cliente_cpf, int imovel_cep, int imovel_numero){
        this.data = data;
        this.valor = valor;
        this.cliente_cpf = cliente_cpf;
        this.imovel_cep = imovel_cep;
        this.imovel_numero = imovel_numero;
        this.lastMessage = null;
    }
    
    public Pagamento(Timestamp data, float valor, int cliente_cpf, int imovel_cep, int imovel_numero, String nome_cliente, int id_contrato){
        this.data = data;
        this.valor = valor;
        this.cliente_cpf = cliente_cpf;
        this.imovel_cep = imovel_cep;
        this.imovel_numero = imovel_numero;
        this.nome_cliente = nome_cliente;
        this.id_contrato = id_contrato;
        this.lastMessage = null;
    }
    
    public Pagamento(){
        this.data = null;
        this.valor = -1;
        this.cliente_cpf = -1;
        this.imovel_cep = -1;
        this.imovel_numero = -1;
        this.lastMessage = null;
    }
    
    /**
     * @return the data
     */
    public Timestamp getData() {
        return data;
    }

    /**
     * @param data the data to set
     */
    public void setData(Timestamp data) {
        this.data = data;
    }
    
    /**
     * @return the cliente_cpf
     */
    public float getValor() {
        return valor;
    }

    /**
     * @param cliente_cpf the cliente_cpf to set
     */
    public void setValor(float valor) {
        this.valor = valor;
    }
    
    /**
     * @return the cliente_cpf
     */
    public int getCliente_cpf() {
        return cliente_cpf;
    }

    /**
     * @param cliente_cpf the cliente_cpf to set
     */
    public void setCliente_cpf(int cliente_cpf) {
        this.cliente_cpf = cliente_cpf;
    }

    /**
     * @return the imovel_cep
     */
    public int getImovel_cep() {
        return imovel_cep;
    }

    /**
     * @param imovel_cep the imovel_cep to set
     */
    public void setImovel_cep(int imovel_cep) {
        this.imovel_cep = imovel_cep;
    }

    /**
     * @return the imovel_numero
     */
    public int getImovel_numero() {
        return imovel_numero;
    }

    /**
     * @param imovel_numero the imovel_numero to set
     */
    public void setImovel_numero(int imovel_numero) {
        this.imovel_numero = imovel_numero;
    }
    
    /**
     * @return the imovel_numero
     */
    public int getId_contrato() {
        return id_contrato;
    }

    /**
     * @param imovel_numero the imovel_numero to set
     */
    public void setId_contrato(int id_contrato) {
        this.id_contrato = id_contrato;
    }
    
    /**
     * @return the imovel_numero
     */
    public String getNome_cliente() {
        return nome_cliente;
    }

    /**
     * @param imovel_numero the imovel_numero to set
     */
    public void setNome_cliente(String nome_cliente) {
        this.nome_cliente = nome_cliente;
    }
    
    /**
     * @return the lastMessage
     */
    public String getLastMessage() {
        String message = lastMessage;
        lastMessage = null;
        return message;
    }

    /**
     * @param lastMessage the lastMessage to set
     */
    public void setLastMessage(String lastMessage) {
        this.lastMessage = lastMessage;
    }
    
//    public void getAluga(){
//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            bdConn = DriverManager.getConnection("jdbc:mysql://localhost/imobiliaria_facil", "root", "");
//            statement = bdConn.createStatement();
//            
//            resultSetQuery = statement.executeQuery("SELECT * FROM `imovel` WHERE cep = " + cep + " and numero = " + numero);
//            
//            resultSetQuery.first();
//            
//            System.out.println("Carregando dados da Venda");
//            //System.out.println(this.cep = resultSetQuery.getInt("cep"));
//            
//            statement.close();
//        } 
//        catch (Exception e) {
//            this.lastMessage = e.getMessage();
//        }
//        finally{
//            try{
//                bdConn.close();
//            }
//            catch(Exception e){
//                this.lastMessage = e.getMessage();
//            }
//        }
//    }
    
    public void save(){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            statement.execute("INSERT INTO pagamento (data, valor, cliente_cpf, imovel_cep, imovel_numero) VALUES ('" + data + "', " + valor + ", " + cliente_cpf + ", " + imovel_cep + ", " + imovel_numero + ");");
            
            System.out.print("");
            System.out.println("Pagamento registrado com sucesso!");
            
            statement.close();
        }
        catch(Exception e){
            e.printStackTrace();
            this.lastMessage = e.getMessage();
        }
        finally{
            try{
                bdConn.close();
            }
            catch(Exception e){
                this.lastMessage = e.getMessage();
            }
        }
    }

//	public void edit(){
//        try{
//            Class.forName("com.mysql.jdbc.Driver");
//            bdConn = DriverManager.getConnection("jdbc:mysql://localhost/imobiliaria_facil", "root", "");
//            statement = bdConn.createStatement();
//            statement.execute("UPDATE imovel SET cep = " + cep + ", numero = '" + numero + "', suites = '" + suites + "', cozinhas = '" + cozinhas + "', quartos = '" + quartos + "', garagens = '" + garagens + "', banheiros = '" + banheiros + "', m2 = '" + m2 + "', mobiliada = " + mobiliada + ", outros = '" + outros + "', preco_aluguel = '" + preco_aluguel + "', preco_venda = '" + preco_venda + "', tipo = '" + tipo + "', url_foto = '" + url_foto + "', cidade = '" + cidade + "', rua = '" + rua + "', bairro = '" + bairro + "', proprietario_cpf = " + proprietario_cpf + " WHERE cep = " + cep_antigo + " and numero = " + numero_antigo + ";");
//
//            System.out.print("");
//            System.out.println("Imóvel salvo com sucesso!");
//            
//            statement.close();
//        }
//        catch(Exception e){
//            this.lastMessage = e.getMessage();
//        }
//        finally{
//            try{
//                bdConn.close();
//            }
//            catch(Exception e){
//                this.lastMessage = e.getMessage();
//            }
//        }
//    }
}

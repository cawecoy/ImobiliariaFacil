/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SQL;

import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author cawecoyrodriguesmarega
 */
public class ListaPagamentos {
    private ArrayList lista;
    private int id_contrato;
    private Timestamp data_inicio;
    private Timestamp data_fim;
    private float valor;
    private int imovel_cep;
    private int imovel_numero;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;
    private ResultSet resultSetQuery;
    
    public ListaPagamentos(){
        lista = new ArrayList();
        id_contrato = -1;
        data_inicio = null;
        data_fim = null;
        valor = -1;
        imovel_cep = -1;
        imovel_numero = -1;
        lastMessage = null;
    }
    
    public ListaPagamentos(Timestamp data_inicio, Timestamp data_fim, int imovel_cep, int imovel_numero){
        this.lista = new ArrayList();
        this.data_inicio = data_inicio;
        this.data_fim = data_fim;
        this.imovel_cep = imovel_cep;
        this.imovel_numero = imovel_numero;
        this.lastMessage = null;
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
    
    public ArrayList getList(){
        return lista;
    }
    
    public void loadList(){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            resultSetQuery = statement.executeQuery("SELECT * FROM pagamento WHERE ( imovel_cep = " + imovel_cep + " ) AND ( imovel_numero = " + imovel_numero + " ) AND ( data >= '" + data_inicio + "' ) AND ( data <= '" + data_fim + "' ) ORDER BY data;");
            
            while(resultSetQuery.next()){
                String nome_cliente;
                Cliente cliente = new Cliente();
                cliente.getCliente(resultSetQuery.getInt("cliente_cpf"));
                nome_cliente = cliente.getNome();
                
                lista.add(new Pagamento(resultSetQuery.getTimestamp("data"), resultSetQuery.getFloat("valor"), resultSetQuery.getInt("cliente_cpf"), resultSetQuery.getInt("imovel_cep"), resultSetQuery.getInt("imovel_numero"), nome_cliente, resultSetQuery.getInt("id_contrato")));
            }
            
            System.out.println("");
            System.out.println("Pagamentos carregados com sucesso!");
            
            statement.close();
        }
        catch(Exception e){
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
}

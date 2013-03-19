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
public class ListaCliente {
    private ArrayList lista;
    private int cpf;
    private int corretor_cpf;
    private String rg;
    private String nome;
    private String endereco;
    private String telefone;
    private String email;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;
    private ResultSet resultSetQuery;
    
    public ListaCliente(){
        lista = new ArrayList();
        cpf = -1;
        corretor_cpf = -1;
        rg = null;
        nome = null;
        endereco = null;
        telefone = null;
        email = null;
        lastMessage = null;
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
            resultSetQuery = statement.executeQuery("SELECT * FROM cliente ORDER BY nome");
            
            while(resultSetQuery.next()){
                lista.add(new Cliente(resultSetQuery.getInt("cpf"), resultSetQuery.getString("rg"), resultSetQuery.getString("nome"), resultSetQuery.getString("endereco"), resultSetQuery.getString("telefone"), resultSetQuery.getString("email"), resultSetQuery.getInt("corretor_cpf")));
            }
            
            System.out.println("");
            System.out.println("Clientes carregados com sucesso!");
            
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

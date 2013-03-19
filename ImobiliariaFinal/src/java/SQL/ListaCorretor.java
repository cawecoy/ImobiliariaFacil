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
public class ListaCorretor {
    private ArrayList lista;
    private int cpf;
    private String rg;
    private String nome;
    private String endereco;
    private String telefone;
    private String email;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;
    private ResultSet resultSetQuery;
    
    public ListaCorretor(){
        lista = new ArrayList();
        cpf = -1;
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
            resultSetQuery = statement.executeQuery("SELECT * FROM corretor ORDER BY nome");
            
            while(resultSetQuery.next()){
                lista.add(new Corretor(resultSetQuery.getInt("cpf"), resultSetQuery.getString("rg"), resultSetQuery.getString("nome"), resultSetQuery.getString("endereco"), resultSetQuery.getString("telefone"), resultSetQuery.getString("email")));
            }
            
            System.out.println("");
            System.out.println("Corretores carregados com sucesso!");
            
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

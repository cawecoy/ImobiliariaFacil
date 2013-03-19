package SQL;

import java.sql.*;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author cawecoyrodriguesmarega
 */
public class Corretor {
    private int cpf;
    private String rg;
    private String nome;
    private String endereco;
    private String telefone;
    private String email;
    
    private int cpf_antigo;
    
    private ResultSet resultSetQuery;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;

    public Corretor(int cpf, String rg, String nome, String endereco, String telefone, String email){
        this.cpf_antigo = this.cpf = cpf;
        this.rg = rg;
        this.nome = nome;
        this.endereco = endereco;
        this.telefone = telefone;
        this.email = email;
        this.lastMessage = null;
    }
    
    public Corretor(){
        cpf_antigo = cpf = -1;
        rg = null;
        nome = null;
        endereco = null;
        telefone = null;
        email = null;
        lastMessage = null;
    }

    /**
     * @return the cpf
     */
    public int getCpf() {
        return cpf;
    }

    /**
     * @param cpf the cpf to set
     */
    public void setCpf(int cpf) {
        this.cpf = cpf;
    }

    /**
     * @return the rg
     */
    public String getRg() {
        return rg;
    }

    /**
     * @param rg the rg to set
     */
    public void setRg(String rg) {
        this.rg = rg;
    }

    /**
     * @return the nome
     */
    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * @return the endereco
     */
    public String getEndereco() {
        return endereco;
    }

    /**
     * @param endereco the endereco to set
     */
    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    /**
     * @return the telefone
     */
    public String getTelefone() {
        return telefone;
    }

    /**
     * @param telefone the telefone to set
     */
    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setCpfAntigo(int cpf_antigo){
        this.cpf_antigo = cpf_antigo;
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
    
    public void getCorretor(int cpf){
        try {
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            
            resultSetQuery = statement.executeQuery("SELECT * FROM corretor WHERE cpf = " + cpf);
            
            resultSetQuery.next();
            
            System.out.println("Carregando dados do corretor cpf = " + (this.cpf = cpf));
            System.out.println(this.rg = resultSetQuery.getString("rg"));
            System.out.println(this.nome = resultSetQuery.getString("nome"));
            System.out.println(this.endereco = resultSetQuery.getString("endereco"));
            System.out.println(this.telefone = resultSetQuery.getString("telefone"));
            System.out.println(this.email = resultSetQuery.getString("email"));
            
            statement.close();
        } 
        catch (Exception e) {
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
    
    public void save(){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            statement.execute("INSERT INTO corretor VALUES (" + cpf + ", '" + rg + "', '" + nome + "', '" + endereco + "', '" + telefone + "', '" + email + "');");
            
            System.out.print("");
            System.out.println("Corretor " + nome + " inserido com sucesso!");
            
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
    
    public void edit(){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            statement.execute("UPDATE corretor SET cpf = " + cpf + ", rg = '" + rg + "', nome = '" + nome + "', endereco = '" + endereco + "', telefone = '" + telefone + "', email = '" + email + "' WHERE cpf = " + cpf_antigo + ";");
            
            System.out.print("");
            System.out.println("Corretor " + nome + " editado com sucesso!");
            
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

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SQL;

import java.sql.*;



/**
 *
 * @author cawecoyrodriguesmarega
 */
public class Login {
    private String nome;
    private int cargo; // 1 = Gerente, 0 = corretor
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;
    private ResultSet resultSetQuery;
    
    public Login(){
        this.nome = "";
        this.cargo = -1;
    }
    
    public String getNome(){
        return this.nome;
    }
    
    public int getCargo(){
        return this.cargo;
    }
    
    public boolean eValido(String email, String cpf, int cargo){
        if(cargo == 0){
            return loginCorretor(email, cpf, cargo);
        }
        else{
            return loginGerente(email, cpf, cargo);
        }
    }
    
    public boolean loginCorretor(String email, String cpf, int cargo){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = (Connection) DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = (Statement) bdConn.createStatement();
            
            resultSetQuery = statement.executeQuery("SELECT nome FROM corretor WHERE email = '" + email + "' and cpf = " + cpf);
            
            if(resultSetQuery.next() == true){
                System.out.println("");
                System.out.println("Login efetuado com sucesso. Email: " + email + " | CPF:" + cpf);
                
                this.nome = resultSetQuery.getString(1);
                this.cargo = cargo;
                
                statement.close();
                bdConn.close();
                
                return true;
            }
            else{
                System.out.println("");
                System.out.println("Login não efetuado: Email ou CPF inválido. Email: " + email + " | CPF:" + cpf);
                
                this.nome = "";
                this.cargo = -1;
                
                statement.close();
                bdConn.close();
                
                return false;
            }
        }
        catch(SQLException e){
            System.out.println("");
            System.out.println("Erro na consulta do Banco de Dados. Email: " + email + " | CPF:" + cpf);
            
            e.printStackTrace();
            
            this.lastMessage = e.getMessage();
            return false;
        }
        catch (ClassNotFoundException e) {
            System.out.println("");
            System.out.println("Erro ao carregar Driver para acesso ao Banco de Dados.");
            
            //e.printStackTrace();
            
            this.lastMessage = e.getMessage();
            return false;
        }
    }
    
    public boolean loginGerente(String email, String cpf, int cargo){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = (Connection) DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = (Statement) bdConn.createStatement();
            
            resultSetQuery = statement.executeQuery("SELECT nome FROM gerente WHERE email = '" + email + "' and cpf = " + cpf);
            
            if(resultSetQuery.next() == true){
                System.out.println("");
                System.out.println("Login efetuado com sucesso. Email: " + email + " | CPF: " + cpf);
                
                this.nome = resultSetQuery.getString(1);
                this.cargo = cargo;
                
                statement.close();
                bdConn.close();
                
                return true;
            }
            else{
                System.out.println("");
                System.out.println("Login não efetuado: Email ou CPF inválido. Email: " + email + " | CPF: " + cpf);
                
                this.nome = "";
                this.cargo = -1;
                
                statement.close();
                bdConn.close();
                
                return false;
            }
        }
        catch(SQLException e){
            System.out.println("");
            System.out.println("Erro na consulta do Banco de Dados. Email: " + email + " | CPF: " + cpf);
            
            e.printStackTrace();
            
            this.lastMessage = e.getMessage();
            return false;
        }
        catch (ClassNotFoundException e) {
            System.out.println("");
            System.out.println("Erro ao carregar Driver para acesso ao Banco de Dados.");
            
            //e.printStackTrace();
            
            this.lastMessage = e.getMessage();
            return false;
        }
    }
}

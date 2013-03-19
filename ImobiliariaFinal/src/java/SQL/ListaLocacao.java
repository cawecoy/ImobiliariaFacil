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
public class ListaLocacao {
    private ArrayList lista;
    private int imovel_cep;
    private int imovel_numero;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;
    private ResultSet resultSetQuery;
    
    public ListaLocacao(int imovel_cep, int imovel_numero){
        this.lista = new ArrayList();;
        this.imovel_cep = imovel_cep;
        this.imovel_numero = imovel_numero;
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
            resultSetQuery = statement.executeQuery("SELECT * FROM aluga WHERE ( imovel_cep = " + imovel_cep + " ) AND ( imovel_numero = " + imovel_numero + " ) ORDER BY data_inicio");
            
            while(resultSetQuery.next()){
                String nome_cliente;
                Cliente cliente = new Cliente();
                cliente.getCliente(resultSetQuery.getInt("cliente_cpf"));
                nome_cliente = cliente.getNome();
                
                lista.add(new Aluga(resultSetQuery.getInt("dia_pagamento"), resultSetQuery.getTimestamp("data_inicio"), resultSetQuery.getTimestamp("data_fim"), resultSetQuery.getInt("cliente_cpf"), resultSetQuery.getInt("imovel_cep"), resultSetQuery.getInt("imovel_numero"), nome_cliente));
            }
            
            System.out.println("");
            System.out.println("Lista de Locações carregada com sucesso!");
            
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
}

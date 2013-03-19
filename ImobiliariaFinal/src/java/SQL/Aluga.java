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
public class Aluga {
    private int dia_pagamento;
    private Timestamp data_inicio;
    private Timestamp data_fim;
    private int cliente_cpf;
    private int imovel_cep;
    private int imovel_numero;
    private String nome_cliente;
    private String endereco;
    
    private ResultSet resultSetQuery;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;

    public Aluga(int dia_pagamento, Timestamp data_inicio, Timestamp data_fim, int cliente_cpf, int imovel_cep, int imovel_numero){
        this.dia_pagamento = dia_pagamento;
        this.data_inicio = data_inicio;
        this.data_fim = data_fim;
        this.cliente_cpf = cliente_cpf;
        this.imovel_cep = imovel_cep;
        this.imovel_numero = imovel_numero;
        this.lastMessage = null;
    }
    
    public Aluga(int dia_pagamento, Timestamp data_inicio, Timestamp data_fim, int cliente_cpf, int imovel_cep, int imovel_numero, String nome_cliente){
        this.dia_pagamento = dia_pagamento;
        this.data_inicio = data_inicio;
        this.data_fim = data_fim;
        this.cliente_cpf = cliente_cpf;
        this.imovel_cep = imovel_cep;
        this.imovel_numero = imovel_numero;
        this.nome_cliente = nome_cliente;
        this.lastMessage = null;
    }
    
    public Aluga(){
        this.dia_pagamento = -1;
        this.data_inicio = null;
        this.data_fim = null;
        this.cliente_cpf = -1;
        this.imovel_cep = -1;
        this.imovel_numero = -1;
        this.lastMessage = null;
    }

    /**
     * @return the data_pagamento
     */
    public int getDia_pagamento() {
        return dia_pagamento;
    }

    /**
     * @param data_pagamento the data_pagamento to set
     */
    public void setDia_pagamento(int dia_pagamento) {
        this.dia_pagamento = dia_pagamento;
    }

    /**
     * @return the data_inicio
     */
    public Timestamp getData_inicio() {
        return data_inicio;
    }

    /**
     * @param data_inicio the data_inicio to set
     */
    public void setData_inicio(Timestamp data_inicio) {
        this.data_inicio = data_inicio;
    }

    /**
     * @return the data_fim
     */
    public Timestamp getData_fim() {
        return data_fim;
    }

    /**
     * @param data_fim the data_fim to set
     */
    public void setData_fim(Timestamp data_fim) {
        this.data_fim = data_fim;
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
     * @return the lastMessage
     */
    public String getLastMessage() {
        String message = lastMessage;
        lastMessage = null;
        return message;
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
    public String getNome_cliente() {
        return this.nome_cliente;
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
            statement.execute("INSERT INTO aluga VALUES (" + dia_pagamento + ", '" + data_inicio + "', '" + data_fim + "', " + cliente_cpf + ", " + imovel_cep + ", " + imovel_numero + ");");
            
            System.out.print("");
            System.out.println("Imóvel alugado com sucesso!");
            
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

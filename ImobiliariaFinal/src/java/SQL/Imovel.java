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
public class Imovel {
    private int cep;
    private int numero;
    private int suites;
    private int cozinhas;
    private int quartos;
    private int garagens;
    private int banheiros;
    private int m2;
    private boolean mobiliada;
    private String outros;
    private float preco_aluguel;
    private float preco_venda;
    private String tipo;
    private String url_foto;
    private String cidade;
    private String rua;
    private String bairro;
    private int proprietario_cpf;

    private int cep_antigo;
    private int numero_antigo;
    
    private ResultSet resultSetQuery;
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;

    public Imovel(int cep, int numero, int suites, int cozinhas, int quartos, int garagens, int banheiros, int m2, boolean mobiliada, String outros, float preco_aluguel, float preco_venda, String tipo, String url_foto, String cidade, String rua, String bairro, int proprietario_cpf){
        this.cep_antigo = this.cep = cep;
        this.numero_antigo = this.numero = numero;
        this.suites = suites;
        this.cozinhas = cozinhas;
        this.quartos = quartos;
        this.garagens = garagens;
        this.proprietario_cpf = proprietario_cpf;
        this.banheiros = banheiros;
        this.m2 = m2;
        this.mobiliada = mobiliada;
        this.outros = outros;
        this.preco_aluguel = preco_aluguel;
        this.preco_venda = preco_venda;
        this.tipo = tipo;
        this.url_foto = url_foto;
        this.cidade = cidade;
        this.rua = rua;
        this.bairro = bairro;
        this.lastMessage = null;
    }
    
    public Imovel(){
        cep_antigo = cep = -1;
        numero_antigo = numero = -1;
        suites = 0;
        cozinhas = 0;
        quartos = 0;
        garagens = 0;
        proprietario_cpf = -1;
        banheiros = 0;
        m2 = 0;
        mobiliada = false;
        outros = null;
        preco_aluguel = 0;
        preco_venda = 0;
        tipo = null;
        url_foto = null;
        cidade = null;
	rua = null;
        bairro = null;
        lastMessage = null;
    }
     
    public int getCep() {
        return cep;
    }

   
    public void setCep(int cep) {
        this.cep = cep;
    }

    public int getNumero() {
        return numero;
    }

   
    public void setNumero(int numero) {
        this.numero = numero;
    }
    
    public int getSuites() {
        return suites;
    }

   
    public void setSuites(int suites) {
        this.suites = suites;
    }
    
    public int getCozinhas() {
        return cozinhas;
    }
   
    public void setCozinhas(int cozinhas) {
        this.cozinhas = cozinhas;
    }
    
    public int getQuartos() {
        return quartos;
    }
   
    public void setQuartos(int quartos) {
        this.quartos = quartos;
    }
    
    public int getGaragens() {
        return garagens;
    }
   
    public void setGaragens(int garagens) {
        this.garagens = garagens;
    }
    
    public int getBanheiros() {
        return banheiros;
    }
   
    public void setBanheiros(int banheiros) {
        this.banheiros = banheiros;
    }
    
    public int getM2() {
        return m2;
    }
   
    public void setM2(int m2) {
        this.m2 = m2;
    }
    
    public boolean getMobiliada() {
        return mobiliada;
    }
   
    public void setMobiliada(boolean mobiliada) {
        this.mobiliada = mobiliada;
    }
    
    public String getOutros() {
        return outros;
    }
   
    public void setOutros(String outros) {
        this.outros = outros;
    }
    
    public float getPreco_aluguel() {
        return preco_aluguel;
    }
   
    public void setPreco_aluguel(float preco_aluguel) {
        this.preco_aluguel = preco_aluguel;
    }
    
     public float getPreco_venda() {
        return preco_venda;
    }
   
    public void setPreco_venda(float preco_venda) {
        this.preco_venda = preco_venda;
    }
    
     
    public String getTipo() {
        return tipo;
    }
   
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public String getUrl_foto() {
        return url_foto;
    }
   
    public void setUrl_foto(String url_foto) {
        this.url_foto = url_foto;
    }
    
    public String getCidade() {
        return cidade;
    }
   
    public void setCidade(String cidade) {
        this.cidade = cidade;
    }
    
	public String getRua() {
        return rua;
    }
   
    public void setRua(String rua) {
        this.rua = rua;
    }
	
    public String getBairro() {
        return bairro;
    }
   
    public void setBairro(String bairro) {
        this.bairro = bairro;
    }
    
    public int getProprietario_cpf() {
        return proprietario_cpf;
    }

    public void setProprietario_cpf(int proprietario_cpf) {
        this.proprietario_cpf = proprietario_cpf;
    }

    public void setCepAntigo(int cep_antigo){
            this.cep_antigo = cep_antigo;
    }

    public void setNumeroAntigo(int numero_antigo){
            this.numero_antigo = numero_antigo;
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
    
    public void getImovel(int cep, int numero){
        try {
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            
            resultSetQuery = statement.executeQuery("SELECT * FROM imovel WHERE cep = " + cep + " and numero = " + numero);
            
            resultSetQuery.next();
            
            System.out.println("Carregando dados do Imovel");
            System.out.println(this.cep = resultSetQuery.getInt("cep"));
            System.out.println(this.numero = resultSetQuery.getInt("numero"));
            System.out.println(this.suites = resultSetQuery.getInt("suites"));
            System.out.println(this.cozinhas = resultSetQuery.getInt("cozinhas"));
            System.out.println(this.quartos = resultSetQuery.getInt("quartos"));
            System.out.println(this.garagens = resultSetQuery.getInt("garagens"));
            System.out.println(this.banheiros = resultSetQuery.getInt("banheiros"));
            System.out.println(this.m2 = resultSetQuery.getInt("m2"));
            System.out.println(this.mobiliada = resultSetQuery.getBoolean("mobiliada"));
            System.out.println(this.outros = resultSetQuery.getString("outros"));
            System.out.println(this.preco_aluguel = resultSetQuery.getFloat("preco_aluguel"));
            System.out.println(this.preco_venda = resultSetQuery.getFloat("preco_venda"));
            System.out.println(this.cidade = resultSetQuery.getString("cidade"));
            System.out.println(this.tipo = resultSetQuery.getString("tipo"));
            System.out.println(this.url_foto = resultSetQuery.getString("url_foto"));
            System.out.println(this.rua = resultSetQuery.getString("rua"));
            System.out.println(this.bairro = resultSetQuery.getString("bairro"));
            System.out.println(this.proprietario_cpf = resultSetQuery.getInt("proprietario_cpf"));
            
            statement.close();
        } 
        catch (Exception e) {
            this.lastMessage = e.getMessage();
            e.printStackTrace();
        }
        finally{
            try{
                bdConn.close();
            }
            catch(Exception e){
                this.lastMessage = e.getMessage();
                e.printStackTrace();
            }
        }
    }
    
    public void save(){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            statement.execute("INSERT INTO imovel VALUES (" + cep + ", '" + numero + "', '" + suites + "', '" + cozinhas + "', '" + quartos + "', '" + garagens + "','" + banheiros + "', '" + m2 + "', " + mobiliada + ", '" + outros + "', '" + preco_aluguel + "', '" + preco_venda + "',  '" + tipo + "',  '" + url_foto + "', '" + cidade + "', '" + rua + "', '" + bairro + "', " + proprietario_cpf + ");");
            
            System.out.print("");
            System.out.println("Imóvel inserido com sucesso!");
            
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

    public void vender(int cpf_novo_proprietario, int cep, int numero){
        try{
            Class.forName("org.postgresql.Driver");
            bdConn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/imobiliaria", "postgres", "marega");
            statement = bdConn.createStatement();
            statement.execute("UPDATE imovel SET proprietario_cpf = " + cpf_novo_proprietario + " WHERE cep = " + cep + " and numero = " + numero + ";");

            System.out.print("");
            System.out.println("Imóvel foi vendido e passado para seu novo proprietário com sucesso!");
            
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
            statement.execute("UPDATE imovel SET cep = " + cep + ", numero = '" + numero + "', suites = '" + suites + "', cozinhas = '" + cozinhas + "', quartos = '" + quartos + "', garagens = '" + garagens + "', banheiros = '" + banheiros + "', m2 = '" + m2 + "', mobiliada = " + mobiliada + ", outros = '" + outros + "', preco_aluguel = '" + preco_aluguel + "', preco_venda = '" + preco_venda + "', tipo = '" + tipo + "', url_foto = '" + url_foto + "', cidade = '" + cidade + "', rua = '" + rua + "', bairro = '" + bairro + "', proprietario_cpf = " + proprietario_cpf + " WHERE cep = " + cep_antigo + " and numero = " + numero_antigo + ";");

            System.out.print("");
            System.out.println("Imóvel salvo com sucesso!");
            
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

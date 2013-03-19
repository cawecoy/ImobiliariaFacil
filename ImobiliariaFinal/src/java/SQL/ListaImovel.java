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
public class ListaImovel {
    private ArrayList lista;
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
    
    private String lastMessage;
    
    private Connection bdConn;
    private Statement statement;
    private ResultSet resultSetQuery;
    
    public ListaImovel(){
        lista = new ArrayList();
        cep = -1;
        numero = -1;
        suites = -1;
        cozinhas = -1;
        quartos = -1;
        garagens = -1;
        banheiros = -1;
        m2 = -1;
        mobiliada = false;
        outros = null;
        preco_aluguel = -1;
        preco_venda = -1;
        tipo = null;
        url_foto = null;
        cidade = null;
        rua = null;
        bairro = null;
        proprietario_cpf = -1;
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
            resultSetQuery = statement.executeQuery("SELECT * FROM imovel ORDER BY rua");
            
            while(resultSetQuery.next()){
                lista.add(new Imovel(resultSetQuery.getInt("cep"), resultSetQuery.getInt("numero"), resultSetQuery.getInt("suites"), resultSetQuery.getInt("cozinhas"), resultSetQuery.getInt("quartos"), resultSetQuery.getInt("garagens"), resultSetQuery.getInt("banheiros"), resultSetQuery.getInt("m2"), resultSetQuery.getBoolean("mobiliada"), resultSetQuery.getString("outros"), resultSetQuery.getFloat("preco_aluguel"), resultSetQuery.getFloat("preco_venda"), resultSetQuery.getString("tipo"), resultSetQuery.getString("url_foto"), resultSetQuery.getString("cidade"), resultSetQuery.getString("rua"), resultSetQuery.getString("bairro"), resultSetQuery.getInt("proprietario_cpf")));
            }
            
            System.out.println("");
            System.out.println("Imóveis carregados com sucesso!");
            
            statement.close();
        }
        catch(Exception e){
            System.out.println("");
            System.out.println("Não foi possível carregar os imóveis.");
            
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

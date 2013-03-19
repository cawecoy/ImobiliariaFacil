<%-- 
    Document   : CadastrarCliente
    Created on : Sep 2, 2011, 8:44:39 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.ListaCliente"%>
<%@page import="SQL.Cliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar Imovel</title>
        <link rel="stylesheet" type="text/css" href="../Stylesheet/stylesheet.css" />
    </head>
    <body>
        <%
        Login login;

        login = (Login) session.getAttribute("login");

        if(login == null){
            response.sendRedirect("../index.jsp?loginExpirado=yes");
        }
        else if(login.getCargo() == -1){
            response.sendRedirect("../index.jsp?semPermissao=yes");
        }
        %>
        
        <div style="width: 100%; background-color: #880000; color: #ffffff;">
            &nbsp;Olá, <%=login.getNome()%> | <a STYLE="text-decoration:none; color: #cccccc;" href="../index.jsp?logout=yes">Logout</a>
        </div>
        
        <img src="../Images/logo.png"/>

        <br/>
        <br/>
        
        <%@ page import="SQL.Imovel" %>
        <%
            Imovel imovel = null;
            
            if(request.getParameter("inserted") != null){
                imovel = (Imovel) session.getAttribute("imovel");
        %>
        
        <script type="text/javascript">
            alert("Imóvel <%=imovel.getRua()%> | <%=imovel.getNumero()%> inserido com sucesso!");
        </script>
        
        <%
            }
            else if(request.getParameter("erro") != null){
        %>
        <script type="text/javascript">
            alert("Desculpe, imóvel não foi cadastrado com sucesso :/");
        </script>
        
        <%
            }
        %>
        
        <form action="VerificaCadastro.jsp" method="POST">
            <table class="tabela">
                <thead>
                    <tr>
                        <td class="titleForm">
                            Cadastrar Imóvel
                        </td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="form">
                            Rua (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="rua" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Número (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="numero" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Bairro (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="bairro" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            CEP (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cep" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Cidade e Estado (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cidade" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Tipo (Apartamento, Casa, etc; Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="tipo" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Preço para Locação (só se estiver para locação)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="preco_aluguel" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Preço para Venda (só se estiver para venda)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="preco_venda" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Mobiliada?
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="radio" name="mobiliada" value="true" /> Sim <input type="radio" name="mobiliada" value="false" checked="checked" /> Não
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Quartos
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="quartos" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Suítes
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="suites" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Cozinhas
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cozinhas" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Banheiros
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="banheiros" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Garagens
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="garagens" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Metros Quadrados
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="m2" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Outros
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="outros" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            URL Foto
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="url_foto" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Proprietário (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <select name="proprietario_cpf" class="input">
                                <%
                                    ListaCliente lista = new ListaCliente();
                                    ArrayList clientes;

                                    lista.loadList();
                                    clientes = lista.getList();

                                    Iterator it = clientes.iterator();

                                    while(it.hasNext()){
                                        Cliente c = (Cliente) it.next();
                                        %>

                                        <option value="<%=c.getCpf()%>"><%=c.getNome()%></option>

                                        <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="submit" value="Cadastrar" name="CadastrarImovel" class="input" />
                        </td>
                    </tr>
                    </form>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td><input type="button" value="Sobre" name="Sobre" class="botoes" onclick="javascript: alert('Trabalho de Banco de Dados\nCiência da Computação, UEL\nAutores: Leonardo e Cawe Coy\nProf. Daniel Kaster');" /></td>
                                        <td><input type="button" value="Ajuda" name="Ajuda" class="botoes" onclick="javascript: alert('Para qualquer dúvida entre em contato:\ncawecoy@gmail.com\ntonzarlf@gmail.com');" /></td>
                                        <td><a href="../Inicio/menu.jsp"><input type="button" value="Voltar" name="Voltar" class="botoes" /></a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
    </body>
</html>
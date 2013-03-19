<%-- 
    Document   : PesquisarCliente
    Created on : Sep 3, 2011, 3:29:16 PM
    Author     : leonardo
--%>

<%@page import="SQL.Login"%>
<%@page import="SQL.Imovel"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.ListaImovel;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pesquisar - Editar / Visualizar Imóveis</title>
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
        
        <form method="POST" action="VisualizarEditarImovel.jsp">
            <table class="tabela">
                <thead>
                    <tr>
                        <th>Pesquisar Imóveis</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td><input type="submit" value="Visualizar / Editar" name="VisualizarImovel" class="botoes" /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td>
                                            <select name="cep_numero" id="Lista" size="15" multiple="multiple" class="list" style="width: 450px; font-size: 14px; color: #222222;">

                                                <%
                                                    ListaImovel lista = new ListaImovel();
                                                    ArrayList imoveis;

                                                    lista.loadList();
                                                    imoveis = lista.getList();

                                                    Iterator it = imoveis.iterator();

                                                    while(it.hasNext()){
                                                        Imovel imv = (Imovel) it.next();
                                                        
                                                        %>

                                                        <option value="<%=imv.getCep()%>:<%=imv.getNumero()%>"><%=imv.getRua()%> | <%=imv.getNumero()%> | <%=imv.getCidade()%></option>

                                                        <%
                                                    }
                                                %>

                                            </select>
                                            <script type="text/javascript">document.getElementById("Lista").focus();</script>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </td>
                    </tr>
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
        </form>
    </body>
</html>


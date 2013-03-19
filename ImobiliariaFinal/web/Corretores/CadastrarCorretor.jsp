<%-- 
    Document   : CadastrarCliente
    Created on : Sep 2, 2011, 8:44:39 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar Corretor</title>
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
        
        <%@ page import="SQL.Corretor" %>
        <%
            Corretor corretor = null;
            
            if(request.getParameter("inserted") != null){
                corretor = (Corretor) session.getAttribute("corretor");
                %>

                <script type="text/javascript">
                    alert("Corretor <%=corretor.getNome()%> inserido com sucesso!");
                </script>

                <%
            }
            else if(request.getParameter("erro") != null){
                %>
                <script type="text/javascript">
                    alert("Desculpe, corretor não foi cadastrado com sucesso :/");
                </script>

                <%
            }
        %>
        
        <form action="VerificaCadastro.jsp" method="POST">
            <table class="tabela">
                <thead>
                    <tr>
                        <td class="titleForm">
                            Cadastrar Corretor
                        </td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="form">
                            Nome Completo (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="nome" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            CPF (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cpf" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            RG
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="rg" value="0" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Endereço Completo
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="endereco" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Telefone (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="telefone" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            E-mail (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="email" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="submit" value="Cadastrar" name="CadastrarCorretor" class="input" />
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
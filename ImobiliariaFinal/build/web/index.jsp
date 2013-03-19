<%-- 
    Document   : index
    Created on : Sep 2, 2011, 5:01:25 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Imobiliária Fácil</title>
        
        <link rel="stylesheet" type="text/css" href="Stylesheet/stylesheet.css" />
    </head>
    <body>
        <%
            session.setAttribute("login", new Login());
            
            if(request.getParameter("erro") != null){
            %>
            <script type="text/javascript">
                alert("Login falhou. Verifique seu e-mail ou cpf!");
            </script>
            <%
            }
            else if(request.getParameter("semPermissao") != null){
            %>
            <script type="text/javascript">
                alert("Por favor, faça login para acessar o sistema.");
            </script>
            <%
            }
            else if(request.getParameter("logout") != null){
                session.setAttribute("login", new Login());
                %>
            <script type="text/javascript">
                alert("Logout realizado com sucesso.");
            </script>
            <%
            }
            else if(request.getParameter("loginExpirado") != null){
                session.setAttribute("login", new Login());
                %>
            <script type="text/javascript">
                alert("O tempo de login expirou.");
            </script>
            <%
            }
        %>
        <img src="Images/logo.png"/>

        <br/>
        <br/>
        <table class="tabela">
            <thead>
                <tr>
                    <td class="tittleForm">Seja bem vindo a página de login!</td>
                </tr>
            </thead>
            <tbody>
                <form action="Inicio/VerificaLogin.jsp" method="POST">
                    <tr>
                        <td class="form">E-mail</td>
                    </tr>
                    <tr>
                        <td class="form"><input type="text" name="email" value="" id="Email" class="input" /></td>
                        <script type="text/javascript">document.getElementById("Email").focus();</script>
                    </tr>
                    <tr>
                        <td class="form">Password</td>
                    </tr>
                    <tr>
                        <td class="form"><input type="password" name="cpf" value="" class="input" /></td>
                    </tr>
                    <tr>
                        <td class="form"><input type="radio" name="cargo" value="0" checked="checked" /> Corretor <input type="radio" name="cargo" value="1" /> Gerente</td>
                    </tr>
                    <tr>
                        <td class="form"><input type="submit" value="Entrar" name="Login" class="input" /></td>
                    </tr>
                </form>
                <tr>
                    <td>
                        <table class="tabela">
                            <tbody>
                                <tr>
                                    <td><input type="button" value="Sobre" name="Sobre" class="botoes" onclick="javascript: alert('Trabalho de Banco de Dados\nCiência da Computação, UEL\nAutores: Leonardo e Cawe Coy\nProf. Daniel Kaster');" /></td>
                                    <td><input type="button" value="Ajuda" name="Ajuda" class="botoes" onclick="javascript: alert('Para qualquer dúvida entre em contato:\ncawecoy@gmail.com\ntonzarlf@gmail.com');" /></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>

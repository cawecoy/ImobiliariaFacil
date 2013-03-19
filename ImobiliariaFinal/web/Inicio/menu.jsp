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

        <table class="tabela">
            <thead>
                <tr>
                    <th>Pagamentos</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><a href="../Pagamentos/RegistrarPagamento.jsp"><input type="button" value="Registrar" name="RegistrarPagamento" class="botoes" /></a></td>
                    <td><a href="../Pagamentos/VerificarPagamento.jsp"><input type="button" value="Verificar" name="VerificarPagamento" class="botoes" /></a></td>
                    <td></td>
                </tr>
            </tbody>
        </table>

        <table class="tabela">
            <thead>
                <tr>
                    <th>Clientes</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><a href="../Clientes/PesquisarCliente.jsp"><input type="button" value="Pesquisar / Editar" name="PesquisarClientes" class="botoes"/></a></td>
                    <td><a href="../Clientes/CadastrarCliente.jsp"><input type="button" value="Cadastrar" name="CadastrarCliente" class="botoes" /></a></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <% if(login.getCargo() == 1){ %>
        <table class="tabela">
            <thead>
                <tr>
                    <th>Corretores</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><a href="../Corretores/PesquisarCorretor.jsp"><input type="button" value="Pesquisar / Editar" name="PesquisarCorretor" class="botoes" /></a></td>
                    <td><a href="../Corretores/CadastrarCorretor.jsp"><input type="button" value="Cadastrar" name="CadastrarCorretor" class="botoes" /></a></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <% } %>
        <table class="tabela">
            <thead>
                <tr>
                    <th>Imóveis</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><a href="../Imoveis/PesquisarImovel.jsp"><input type="button" value="Pesquisar / Editar" name="PesquisarImovel" class="botoes" /></a></td>
                    <td><a href="../Imoveis/CadastrarImovel.jsp"><input type="button" value="Cadastrar" name="CadastrarImovel" class="botoes" /></a></td>
                </tr>
                <tr>
                    <td><a href="../Imoveis/PesquisarNegociacoes.jsp"><input type="button" value="Histórico Negociações" name="NegociacoesImovel" class="botoes" /></a></td>
                    <td><a href="../Imoveis/VenderImovel.jsp"><input type="button" value="Vender / Alugar" name="VenderImovel" class="botoes" /></a></td>
                </tr>
            </tbody>
        </table>

        <table class="tabela">
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="button" value="Sobre" name="Sobre" class="botoes" onclick="javascript: alert('Trabalho de Banco de Dados\nCiência da Computação, UEL\nAutores: Leonardo e Cawe Coy\nProf. Daniel Kaster');" /></td>
                    <td><input type="button" value="Ajuda" name="Ajuda" class="botoes" onclick="javascript: alert('Para qualquer dúvida entre em contato:\ncawecoy@gmail.com\ntonzarlf@gmail.com');" /></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>

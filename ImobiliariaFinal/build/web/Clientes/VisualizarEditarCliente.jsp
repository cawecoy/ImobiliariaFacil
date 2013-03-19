<%@page import="SQL.Corretor"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.ListaCorretor"%>
<%@page import="SQL.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visualizar / Editar Cliente</title>
        <link rel="stylesheet" type="text/css" href="../Stylesheet/stylesheet.css" />
        <script type="text/javascript">
            function Editar(){
                document.getElementById("EditarCadastrar").innerHTML = '<input type="submit" value="Salvar" name="SalvarCliente" class="input" />';
                
                document.getElementById("Nome").disabled = false;
                document.getElementById("Nome").focus();
                
                document.getElementById("Cpf").disabled = false;
                document.getElementById("Cpf").focus();
                
                document.getElementById("Rg").disabled = false;
                document.getElementById("Rg").focus();
                
                document.getElementById("Endereco").disabled = false;
                document.getElementById("Endereco").focus();
                
                document.getElementById("Telefone").disabled = false;
                document.getElementById("Telefone").focus();
                
                document.getElementById("Email").disabled = false;
                document.getElementById("Email").focus();
                
                document.getElementById("Corretores").disabled = false;
                document.getElementById("Corretores").focus();
                
                document.getElementById("Nome").focus();
            }
        </script>
    </head>
    <body>
        <%@ page import="SQL.Cliente" %>
        <%@ page import="SQL.ListaCliente" %>
        <%
        Login login;
        Cliente cliente = null;

        login = (Login) session.getAttribute("login");

        if(login == null){
            response.sendRedirect("../index.jsp?loginExpirado=yes");
        }
        else if(login.getCargo() == -1){
            response.sendRedirect("../index.jsp?semPermissao=yes");
        }

        if(request.getParameter("edited") != null){
            cliente = (Cliente) session.getAttribute("cliente");
        %>
        
            <script type="text/javascript">
                alert("Cliente <%=cliente.getNome()%> salvo com sucesso!");
            </script>
        
        <%
        }
        else if(request.getParameter("erro") != null){
            cliente = (Cliente) session.getAttribute("cliente");
        %>
            <script type="text/javascript">
                alert("Desculpe, alteração não foi realizada com sucesso :/");
            </script>
        
        <%
        }
        else{
            cliente = new Cliente();
            cliente.getCliente(Integer.parseInt(request.getParameter("cpf")));
            session.setAttribute("cliente", cliente);
        }
        
        session.setAttribute("cpf_antigo", cliente.getCpf());
        %>
        
        <div style="width: 100%; background-color: #880000; color: #ffffff;">
            &nbsp;Olá, <%=login.getNome()%> | <a STYLE="text-decoration:none; color: #cccccc;" href="../index.jsp?logout=yes">Logout</a>
        </div>
        
        <img src="../Images/logo.png"/>

        <br/>
        <br/>
        
        <form action="VerificaCadastro.jsp?editar=yes" method="POST">
            <table class="tabela">
                <thead>
                    <tr>
                        <td class="titleForm">
                            Visualizar / Editar Cliente
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
                            <input type="text" name="nome" value="<%=cliente.getNome()%>" disabled="true" id="Nome" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            CPF (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cliente_cpf" value="<%=cliente.getCpf()%>" disabled="true" id="Cpf" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            RG
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="rg" value="<%=cliente.getRg()%>" disabled="true" id="Rg" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Endereço Completo
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="endereco" value="<%=cliente.getEndereco()%>" disabled="true" id="Endereco" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Telefone (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="telefone" value="<%=cliente.getTelefone()%>" disabled="true" id="Telefone" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            E-mail
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="email" value="<%=cliente.getEmail()%>" disabled="true" id="Email" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Corretor que atende este cliente (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <select name="corretor_cpf" disabled="true" id="Corretores" class="input">
                                <%
                                    ListaCorretor lista = new ListaCorretor();
                                    ArrayList corretores;

                                    lista.loadList();
                                    corretores = lista.getList();

                                    Iterator it = corretores.iterator();

                                    while(it.hasNext()){
                                        Corretor c = (Corretor) it.next();
                                        
                                        if(c.getCpf() == cliente.getCorretor_cpf()){
                                            %>

                                            <option value="<%=c.getCpf()%>" selected="true"><%=c.getNome()%></option>

                                            <%
                                        }
                                        else{
                                            %>

                                            <option value="<%=c.getCpf()%>"><%=c.getNome()%></option>

                                            <%
                                        }
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <div id="EditarCadastrar"><input type="button" value="Editar" name="EditarCliente" onclick="javascript: Editar();" class="input" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td><input type="button" value="Sobre" name="Sobre" class="botoes" onclick="javascript: alert('Trabalho de Banco de Dados\nCiência da Computação, UEL\nAutores: Leonardo e Cawe Coy\nProf. Daniel Kaster');" /></td>
                                        <td><input type="button" value="Ajuda" name="Ajuda" class="botoes" onclick="javascript: alert('Para qualquer dúvida entre em contato:\ncawecoy@gmail.com\ntonzarlf@gmail.com');" /></td>
                                        <td><a href="PesquisarCliente.jsp"><input type="button" value="Voltar" name="Voltar" class="botoes" /></a></td>
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

<%-- 
    Document   : PesquisarCliente
    Created on : Sep 3, 2011, 3:29:16 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Cliente"%>
<%@page import="SQL.ListaCliente"%>
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
        <title>Registrar Pagamento</title>
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
        
        if(request.getParameter("pagamento") != null){
            %>
            
            <script type="text/javascript">
                alert("Pagamento registrado com sucesso!");
            </script>
            
            <%
        }
        else if(request.getParameter("erro") != null){
            %>
            
            <script type="text/javascript">
                alert("Desculpe, o pagamento não foi realizado com sucesso :/");
            </script>
        
            <%
        }
        %>
        
        <div style="width: 100%; background-color: #880000; color: #ffffff;">
            &nbsp;Olá, <%=login.getNome()%> | <a STYLE="text-decoration:none; color: #cccccc;" href="../index.jsp?logout=yes">Logout</a>
        </div>
        
        <img src="../Images/logo.png"/>

        <br/>
        <br/>
        
        <form method="POST" action="VerificarRegistroPagamento.jsp">
            <table class="tabela">
                <thead>
                    <tr>
                        <th>Registrar Pagamento</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="form">
                            Selecione o imóvel do cliente que realizou o pagamento
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div style="width: 450px; overflow: auto;"><select name="cep_numero" id="Lista" size="8" multiple="multiple" style="font-size: 14px; color: #222222;">

                                                <%
                                                    ListaImovel lista = new ListaImovel();
                                                    ArrayList imoveis;

                                                    lista.loadList();
                                                    imoveis = lista.getList();

                                                    Iterator it = imoveis.iterator();

                                                    while(it.hasNext()){
                                                        Imovel imv = (Imovel) it.next();
                                                        
                                                        %>

                                                        <option value="<%=imv.getCep()%>:<%=imv.getNumero()%>"><%=imv.getRua()%> | <%=imv.getNumero()%> | <%=imv.getCidade()%> | Aluguel: <%=imv.getPreco_aluguel()%> | Venda: <%=imv.getPreco_venda()%></option>

                                                        <%
                                                    }
                                                %>

                                            </select></div>
                                            <script type="text/javascript">document.getElementById("Lista").focus();</script>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Selecione o cliente que realizou o pagamento
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div style="width: 450px; overflow: auto;"><select name="cliente_cpf" id="clientes" size="8" multiple="multiple" class="list" style="width: 450px; font-size: 14px; color: #222222;">

                                                <%
                                                    ListaCliente lista_clientes = new ListaCliente();
                                                    ArrayList clientes;

                                                    lista_clientes.loadList();
                                                    clientes = lista_clientes.getList();

                                                    it = clientes.iterator();

                                                    while(it.hasNext()){
                                                        Cliente c = (Cliente) it.next();
                                                        
                                                        %>

                                                        <option value="<%=c.getCpf()%>"><%=c.getNome()%></option>

                                                        <%
                                                    }
                                                %>
                                            </select></div>
                                            <script type="text/javascript">document.getElementById("clientes").focus();</script>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Data do Pagamento
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" size="4" maxlength="2" name="dia" value="" class="data" />/<input type="text" size="4" maxlength="2" name="mes" value="" class="data" />/<input type="text" size="4" maxlength="4" name="ano" value="" class="data" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Valor
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="valor" value="" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="submit" value="Registrar Pagamento" name="RegistrarPagamento" class="input" />
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


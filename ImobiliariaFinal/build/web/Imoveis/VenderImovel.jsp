<%-- 
    Document   : PesquisarCliente
    Created on : Sep 3, 2011, 3:29:16 PM
    Author     : leonardo
--%>

<%@page import="SQL.Cliente"%>
<%@page import="SQL.ListaCliente"%>
<%@page import="SQL.Imovel"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.ListaImovel"%>
<%@page import="SQL.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vender / Alugar Imóvel</title>
        <link rel="stylesheet" type="text/css" href="../Stylesheet/stylesheet.css" />
        <script type="text/javascript">
            function Locacao(){
                document.getElementById("negocio").value = "Realizar Locação";
                document.getElementById("venda").disabled = true;
                document.getElementById("locacao").disabled = false;
                
                document.getElementById("inicio_dia").disabled = false;
                document.getElementById("inicio_mes").disabled = false;
                document.getElementById("inicio_ano").disabled = false;
                
                document.getElementById("fim_dia").disabled = false;
                document.getElementById("fim_mes").disabled = false;
                document.getElementById("fim_ano").disabled = false;
                
                document.getElementById("dia_pagamento").disabled = false;
            }
            
            function Venda(){
                document.getElementById("negocio").value = "Realizar Venda";
                document.getElementById("venda").disabled = false;
                document.getElementById("locacao").disabled = true;
                
                document.getElementById("inicio_dia").disabled = true;
                document.getElementById("inicio_mes").disabled = true;
                document.getElementById("inicio_ano").disabled = true;
                
                document.getElementById("fim_dia").disabled = true;
                document.getElementById("fim_mes").disabled = true;
                document.getElementById("fim_ano").disabled = true;
                
                document.getElementById("dia_pagamento").disabled = true;
            }
        </script>
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
        
        if(request.getParameter("aluga") != null){
            %>
            
            <script type="text/javascript">
                alert("Imóvel alugado com sucesso!");
            </script>
            
            <%
        }
        else if(request.getParameter("compra") != null){
            %>

            <script type="text/javascript">
            alert("Imóvel vendido com sucesso!");
            </script>

            <%
        }
        else if(request.getParameter("erro") != null){
            %>
            
            <script type="text/javascript">
                alert("Desculpe, o negocio não foi realizada com sucesso :/");
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
        
        <form method="POST" action="VerificarNegociacao.jsp">
            <table class="tabela">
                <thead>
                    <tr>
                        <th>Alugar / Vender Imóveis</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="form">
                            Imóveis para venda
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td>
                                            <select name="cep_numero_venda" id="venda" size="8" multiple="multiple" disabled="true" class="list" style="width: 450px; font-size: 14px; color: #222222;">

                                                <%
                                                    ListaImovel lista = new ListaImovel();
                                                    ArrayList imoveis;

                                                    lista.loadList();
                                                    imoveis = lista.getList();

                                                    Iterator it = imoveis.iterator();

                                                    while(it.hasNext()){
                                                        Imovel imv = (Imovel) it.next();
                                                        
                                                        if(imv.getPreco_venda() != 0){
                                                            %>

                                                            <option value="<%=imv.getCep()%>:<%=imv.getNumero()%>"><%=imv.getRua()%> | <%=imv.getNumero()%> | <%=imv.getCidade()%></option>

                                                            <%
                                                        }
                                                    }
                                                %>

                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Imóveis para locação
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td>
                                            <select name="cep_numero_locacao" id="locacao" size="8" multiple="multiple" class="list" style="width: 450px; font-size: 14px; color: #222222;">

                                                <%
                                                    it = imoveis.iterator();

                                                    while(it.hasNext()){
                                                        Imovel imv = (Imovel) it.next();
                                                        
                                                        if(imv.getPreco_aluguel() != 0){
                                                            %>

                                                            <option value="<%=imv.getCep()%>:<%=imv.getNumero()%>"><%=imv.getRua()%> | <%=imv.getNumero()%> | <%=imv.getCidade()%></option>

                                                            <%
                                                        }
                                                    }
                                                %>

                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="radio" name="negocio" value="true" checked="checked" onclick="Locacao();" /> Locação <input type="radio" name="negocio" value="false" onclick="Venda();" /> Venda
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Clientes
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td>
                                            <select name="cliente_cpf" id="clientes" size="8" multiple="multiple" class="list" style="width: 450px; font-size: 14px; color: #222222;">

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

                                            </select>
                                            <script type="text/javascript">document.getElementById("clientes").focus();</script>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Datas (Obrigatório para Locação)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Início do Contrato <input type="text" size="4" maxlength="2" name="inicio_dia" id="inicio_dia" value="01" class="data" />/<input type="text" size="4" maxlength="2" name="inicio_mes" id="inicio_mes" value="01" class="data" />/<input type="text" size="4" maxlength="4" name="inicio_ano" id="inicio_ano" value="2012" class="data" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Fim do Contrato <input type="text" size="4" maxlength="2" name="fim_dia" id="fim_dia" value="01" class="data" />/<input type="text" size="4" maxlength="2" name="fim_mes" id="fim_mes" value="01" class="data" />/<input type="text" size="4" maxlength="4" name="fim_ano" id="fim_ano" value="2013" class="data" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Dia do pagamento <input type="text" size="4" maxlength="2" name="dia_pagamento" id="dia_pagamento" value="01" class="data" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="submit" value="Realizar Locação" name="NegociarImovel" id="negocio" class="input" />
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


<%-- 
    Document   : PesquisarCliente
    Created on : Sep 3, 2011, 3:29:16 PM
    Author     : leonardo
--%>


<%@page import="SQL.Login"%>
<%@page import="SQL.Imovel"%>
<%@page import="SQL.Compra"%>
<%@page import="SQL.ListaCompra"%>
<%@page import="SQL.Aluga"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.ListaLocacao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Histórico de Negociações</title>
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
        
        Imovel imovel = new Imovel();
        String cep_numero = request.getParameter("cep_numero");
        
        int cep = Integer.valueOf(cep_numero.substring(0, cep_numero.lastIndexOf(":")));
        int numero = Integer.valueOf(cep_numero.substring(cep_numero.lastIndexOf(":") + 1));
        
        imovel.getImovel(cep, numero);
        
        if(imovel.getLastMessage() != null){
            response.sendRedirect("VerificarPagamento.jsp?erro=yes");
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
                    <th>Histórico de Negociações</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="form">
                        Imóvel: <%=imovel.getRua()%> | <%=imovel.getNumero()%> | <%=imovel.getCidade()%>
                    </td>
                </tr>
                <tr>
                    <td class="form">
                        <b>Locações</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="tabela">
                            <tbody>
                                <tr>
                                    <td>
                                        <table class="tabela">
                                            <tbody>
                                                <%
                                                try{
                                                    ListaLocacao lista = new ListaLocacao(cep, numero);
                                                    ArrayList locacoes;

                                                    lista.loadList();
                                                    locacoes = lista.getList();

                                                    Iterator it = locacoes.iterator();

                                                    while(it.hasNext()){
                                                        Aluga a = (Aluga) it.next();
                                                        
                                                        %>
                                                        
                                                        <tr>
                                                            <td class="form">
                                                                <br/>
                                                                Nome: <%=a.getNome_cliente()%> | CPF: <%=a.getCliente_cpf()%>
                                                                <br/>
                                                                Início do contrato: <%=a.getData_inicio().toString()%> | Fim do contrato: <%=a.getData_fim().toString()%>
                                                                <br/>
                                                                Data do pagamento: <%=a.getDia_pagamento()%>
                                                                <br/>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        
                                                        <%
                                                    }
                                                }
                                                catch(Exception e){
                                                    //e.printStackTrace();
                                                }
                                                %>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="form">
                        <b>Compras</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="tabela">
                            <tbody>
                                <tr>
                                    <td>
                                        <table class="tabela">
                                            <tbody>
                                                <%
                                                try{
                                                    ListaCompra listaCompra = new ListaCompra(cep, numero);
                                                    ArrayList compras;

                                                    listaCompra.loadList();
                                                    compras = listaCompra.getList();

                                                    Iterator it2 = compras.iterator();

                                                    while(it2.hasNext()){
                                                        Compra c = (Compra) it2.next();
                                                        
                                                        %>
                                                        
                                                        <tr>
                                                            <td class="form">
                                                                <br/>
                                                                Nome: <%=c.getNome_cliente()%> | CPF: <%=c.getCliente_cpf()%>
                                                                <br/>
                                                                Data: <%=c.getData().toString()%>
                                                                <br/>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        
                                                        <%
                                                    }
                                                }
                                                catch(Exception e){
                                                    //e.printStackTrace();
                                                }
                                                %>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="form">
                        <input type="button" value="Imprimir" name="Imprimir" onclick="window.print();" class="input" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="tabela">
                            <tbody>
                                <tr>
                                    <td><input type="button" value="Sobre" name="Sobre" class="botoes" onclick="javascript: alert('Trabalho de Banco de Dados\nCiência da Computação, UEL\nAutores: Leonardo e Cawe Coy\nProf. Daniel Kaster');" /></td>
                                    <td><input type="button" value="Ajuda" name="Ajuda" class="botoes" onclick="javascript: alert('Para qualquer dúvida entre em contato:\ncawecoy@gmail.com\ntonzarlf@gmail.com');" /></td>
                                    <td><a href="PesquisarNegociacoes.jsp"><input type="button" value="Voltar" name="Voltar" class="botoes" /></a></td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>


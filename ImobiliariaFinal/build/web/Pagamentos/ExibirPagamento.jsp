<%-- 
    Document   : PesquisarCliente
    Created on : Sep 3, 2011, 3:29:16 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="java.sql.Timestamp"%>
<%@page import="SQL.Pagamento"%>
<%@page import="SQL.ListaPagamentos"%>
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
        <title>Relatório de pagamento</title>
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
                    <th>Relatório de Pagamento</th>
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
                        <b>Lista de pagamentos</b>
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
                                                    Timestamp data_inicio;
                                                    Timestamp data_fim;
                                                    
                                                    data_inicio = Timestamp.valueOf(request.getParameter("inicio_ano") + "-" + request.getParameter("inicio_mes") + "-" + request.getParameter("inicio_dia") + " 00:00:00");
                                                    data_fim = Timestamp.valueOf(request.getParameter("fim_ano") + "-" + request.getParameter("fim_mes") + "-" + request.getParameter("fim_dia") + " 00:00:00");
                                                    
                                                    ListaPagamentos lista = new ListaPagamentos(data_inicio, data_fim, cep, numero);
                                                    ArrayList pagamentos;

                                                    lista.loadList();
                                                    pagamentos = lista.getList();

                                                    Iterator it = pagamentos.iterator();

                                                    while(it.hasNext()){
                                                        Pagamento pg = (Pagamento) it.next();
                                                        
                                                        %>
                                                        
                                                        <tr>
                                                            <td class="form">
                                                                <br/>
                                                                ID do pagamento: <%=pg.getId_contrato()%>
                                                                <br/>
                                                                Nome: <%=pg.getNome_cliente()%> | CPF: <%=pg.getCliente_cpf()%>
                                                                <br/>
                                                                Data: <%=pg.getData()%>
                                                                <br/>
                                                                Valor: <%=pg.getValor()%>
                                                                <br/>
                                                                <br/>
                                                            </td>
                                                        </tr>
                                                        
                                                        <%
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


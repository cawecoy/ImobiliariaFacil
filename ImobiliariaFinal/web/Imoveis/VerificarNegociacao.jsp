<%-- 
    Document   : doCadastrarCliente
    Created on : Sep 12, 2011, 12:00:51 PM
    Author     : leonardo
--%>

<%@page import="SQL.Login"%>
<%@page import="SQL.Imovel"%>
<%@page import="SQL.Compra"%>
<%@page import="SQL.Aluga"%>
<%@page import="java.sql.Timestamp"%>
<%
    Timestamp data_inicio;
    Timestamp data_fim;
    String cep_numero;
    int dia_pagamento;
    int cliente_cpf;
    int cep;
    int numero;
    boolean locacao;
    
    try{
        Login login;

        login = (Login) session.getAttribute("login");

        if(login == null){
            response.sendRedirect("../index.jsp?loginExpirado=yes");
        }
        else if(login.getCargo() == -1){
            response.sendRedirect("../index.jsp?semPermissao=yes");
        }
        
        cliente_cpf = Integer.valueOf(request.getParameter("cliente_cpf"));
        locacao = Boolean.parseBoolean(request.getParameter("negocio"));
        
        //System.out.println("LOCAÇÃO? " + locacao);

        if(locacao == true){
            Aluga aluga = new Aluga();
            
            data_inicio = Timestamp.valueOf(request.getParameter("inicio_ano") + "-" + request.getParameter("inicio_mes") + "-" + request.getParameter("inicio_dia") + " 00:00:00");
            data_fim = Timestamp.valueOf(request.getParameter("fim_ano") + "-" + request.getParameter("fim_mes") + "-" + request.getParameter("fim_dia") + " 00:00:00");
            dia_pagamento = Integer.valueOf(request.getParameter("dia_pagamento"));
            
            cep_numero = request.getParameter("cep_numero_locacao");
            
            cep = Integer.valueOf(cep_numero.substring(0, cep_numero.lastIndexOf(":")));
            numero = Integer.valueOf(cep_numero.substring(cep_numero.lastIndexOf(":") + 1));
            
            aluga.setData_inicio(data_inicio);
            aluga.setData_fim(data_fim);
            aluga.setDia_pagamento(dia_pagamento);
            aluga.setImovel_cep(cep);
            aluga.setImovel_numero(numero);
            aluga.setCliente_cpf(cliente_cpf);
            
            System.out.println("");
            System.out.println(":: Locação de Imóvel ::");
            System.out.println("Data de Inicio de contrato: " + aluga.getData_inicio().toString());
            System.out.println("Data de Fim de contrato: " + aluga.getData_fim().toString());
            System.out.println("Dia de pagamento: " + aluga.getDia_pagamento());
            System.out.println("CPF do cliente que alugou: " + aluga.getCliente_cpf());
            System.out.println("CEP do imóvel alugado: " + aluga.getImovel_cep());
            System.out.println("Número do imóvel alugado: " + aluga.getImovel_numero());
            
            aluga.save();
            
            if(aluga.getLastMessage() != null){
                //System.out.println("Exceção: " + aluga.getLastMessage());
                response.sendRedirect("VenderImovel.jsp?erro=yes");
            }
            else{
                response.sendRedirect("VenderImovel.jsp?aluga=yes");
            }
        }
        else{
            Compra compra = new Compra();
            
            cep_numero = request.getParameter("cep_numero_venda");
            
            cep = Integer.valueOf(cep_numero.substring(0, cep_numero.lastIndexOf(":")));
            numero = Integer.valueOf(cep_numero.substring(cep_numero.lastIndexOf(":") + 1));
            
            compra.setImovel_cep(cep);
            compra.setImovel_numero(numero);
            compra.setCliente_cpf(cliente_cpf);
            
            System.out.println("");
            System.out.println(":: Locação de Imóvel ::");
            System.out.println("CPF do cliente que alugou: " + compra.getCliente_cpf());
            System.out.println("CEP do imóvel alugado: " + compra.getImovel_cep());
            System.out.println("Número do imóvel alugado: " + compra.getImovel_numero());
            
            compra.save();
            
            Imovel im = new Imovel();
            
            // passa o Imovel para seu novo Dono
            im.vender(cliente_cpf, cep, numero);
            
            if(compra.getLastMessage() != null){
                //System.out.println("Exceção: " + compra.getLastMessage());
                response.sendRedirect("VenderImovel.jsp?erro=yes");
            }
            else{
                response.sendRedirect("VenderImovel.jsp?compra=yes");
            }
        }
        
    }
    catch(Exception e){
        //System.out.println("Exceção: " + e.getMessage());
        response.sendRedirect("VenderImovel.jsp?erro=yes");
    }
%>

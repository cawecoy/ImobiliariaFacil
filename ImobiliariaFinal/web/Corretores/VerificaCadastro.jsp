<%-- 
    Document   : doCadastrarCliente
    Created on : Sep 12, 2011, 12:00:51 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Login"%>
<%@ page import="SQL.Corretor;"%>
<%
    Corretor corretor = new Corretor();
    String editar = request.getParameter("editar");
    
    try{
        Login login;

        login = (Login) session.getAttribute("login");

        if(login == null){
            response.sendRedirect("../index.jsp?loginExpirado=yes");
        }
        else if(login.getCargo() == -1){
            response.sendRedirect("../index.jsp?semPermissao=yes");
        }
        
        corretor.setNome(request.getParameter("nome"));
        corretor.setCpf(Integer.parseInt(request.getParameter("cpf")));
        corretor.setRg(request.getParameter("rg"));
        corretor.setEmail(request.getParameter("email"));
        corretor.setEndereco(request.getParameter("endereco"));
        corretor.setTelefone(request.getParameter("telefone"));

        System.out.println("");
        System.out.println(":: Cadastro de Cliente ::");
        System.out.println("Nome: " + corretor.getNome());
        System.out.println("CPF Cliente: " + corretor.getCpf());
        System.out.println("RG Cliente: " + corretor.getRg());
        System.out.println("Email: " + corretor.getEmail());
        System.out.println("Endereco: " + corretor.getEndereco());
        System.out.println("Telefone: " + corretor.getTelefone());

        if(editar != null){
            int cpf_antigo = (Integer) session.getAttribute("cpf_antigo");
            corretor.setCpfAntigo(cpf_antigo);
            
            System.out.println("CPF Antigo: " + cpf_antigo);
            
            corretor.edit();
            
            if(corretor.getLastMessage() != null){
                System.out.println("Exceção: " + corretor.getLastMessage());
                response.sendRedirect("VisualizarEditarCorretor.jsp?erro=yes");
            }
            else{
                session.setAttribute("corretor", corretor);
                response.sendRedirect("VisualizarEditarCorretor.jsp?edited=yes");
            }
        }
        else{
            corretor.save();
            
            if(corretor.getLastMessage() != null){
                System.out.println("Exceção: " + corretor.getLastMessage());
                response.sendRedirect("CadastrarCorretor.jsp?erro=yes");
            }
            else{
                session.setAttribute("corretor", corretor);
                response.sendRedirect("CadastrarCorretor.jsp?inserted=yes");
            }
        }
        
    }
    catch(Exception e){
        //System.out.println("Exceção: " + e.getMessage());
        
        if(editar != null){
            response.sendRedirect("VisualizarEditarCorretor.jsp?erro=yes");
        }
        else{
            response.sendRedirect("CadastrarCorretor.jsp?erro=yes");
        }
    }
%>

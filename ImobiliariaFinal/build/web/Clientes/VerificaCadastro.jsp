<%-- 
    Document   : doCadastrarCliente
    Created on : Sep 12, 2011, 12:00:51 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Login"%>
<%@ page import="SQL.Cliente;"%>
<%
    Cliente cliente = new Cliente();
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
        
        cliente.setNome(request.getParameter("nome"));
        cliente.setCpf(Integer.parseInt(request.getParameter("cliente_cpf")));
        cliente.setRg(request.getParameter("rg"));
        cliente.setCorretor_cpf(Integer.parseInt(request.getParameter("corretor_cpf")));
        cliente.setEmail(request.getParameter("email"));
        cliente.setEndereco(request.getParameter("endereco"));
        cliente.setTelefone(request.getParameter("telefone"));

        System.out.println("");
        System.out.println(":: Cadastro de Cliente ::");
        System.out.println("Nome: " + cliente.getNome());
        System.out.println("CPF Cliente: " + cliente.getCpf());
        System.out.println("RG Cliente: " + cliente.getRg());
        System.out.println("CPF Corretor: " + cliente.getCorretor_cpf());
        System.out.println("Email: " + cliente.getEmail());
        System.out.println("Endereco: " + cliente.getEndereco());
        System.out.println("Telefone: " + cliente.getTelefone());

        if(editar != null){
            int cpf_antigo = (Integer) session.getAttribute("cpf_antigo");
            cliente.setCpfAntigo(cpf_antigo);
            
            System.out.println("CPF Antigo: " + cpf_antigo);
            
            cliente.edit();
            
            if(cliente.getLastMessage() != null){
                //System.out.println("Exceção: " + cliente.getLastMessage());
                response.sendRedirect("VisualizarEditarCliente.jsp?erro=yes");
            }
            else{
                session.setAttribute("cliente", cliente);
                response.sendRedirect("VisualizarEditarCliente.jsp?edited=yes");
            }
        }
        else{
            cliente.save();
            
            if(cliente.getLastMessage() != null){
                //System.out.println("Exceção: " + cliente.getLastMessage());
                response.sendRedirect("CadastrarCliente.jsp?erro=yes");
            }
            else{
                session.setAttribute("cliente", cliente);
                response.sendRedirect("CadastrarCliente.jsp?inserted=yes");
            }
        }
        
    }
    catch(Exception e){
        //System.out.println("Exceção: " + e.getMessage());
        
        if(editar != null){
            response.sendRedirect("VisualizarEditarCliente.jsp?erro=yes");
        }
        else{
            response.sendRedirect("CadastrarCliente.jsp?erro=yes");
        }
    }
%>

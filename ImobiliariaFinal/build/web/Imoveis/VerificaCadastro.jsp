<%-- 
    Document   : doCadastrarCliente
    Created on : Sep 12, 2011, 12:00:51 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Login"%>
<%@ page import="SQL.Imovel;"%>
<%
    Imovel imovel = new Imovel();
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
        
        imovel.setCep(Integer.valueOf(request.getParameter("cep")));
        imovel.setNumero(Integer.valueOf(request.getParameter("numero")));
        imovel.setSuites(Integer.valueOf(request.getParameter("suites")));
        imovel.setCozinhas(Integer.valueOf(request.getParameter("cozinhas")));
        imovel.setQuartos(Integer.valueOf(request.getParameter("quartos")));
        imovel.setGaragens(Integer.valueOf(request.getParameter("garagens")));
        imovel.setBanheiros(Integer.valueOf(request.getParameter("banheiros")));
        imovel.setM2(Integer.valueOf(request.getParameter("m2")));
        imovel.setMobiliada(Boolean.parseBoolean(request.getParameter("mobiliada")));
        imovel.setOutros(request.getParameter("outros"));
        imovel.setPreco_aluguel(Float.parseFloat(request.getParameter("preco_aluguel")));
        imovel.setPreco_venda(Float.parseFloat(request.getParameter("preco_venda")));
        imovel.setTipo(request.getParameter("tipo"));
        imovel.setUrl_foto(request.getParameter("url_foto"));
        imovel.setCidade(request.getParameter("cidade"));
        imovel.setRua(request.getParameter("rua"));
        imovel.setBairro(request.getParameter("bairro"));
        imovel.setProprietario_cpf(Integer.valueOf(request.getParameter("proprietario_cpf")));

        System.out.println("");
        System.out.println(":: Cadastro de Imóvel ::");
        System.out.println("Rua: " + imovel.getRua());

        if(editar != null){
            int cep_antigo = (Integer) session.getAttribute("cep_antigo");
            int numero_antigo = (Integer) session.getAttribute("numero_antigo");
            
            imovel.setCepAntigo(cep_antigo);
            imovel.setNumeroAntigo(numero_antigo);
            
            System.out.println("CEP Antigo: " + cep_antigo);
            System.out.println("Número Antigo: " + numero_antigo);
            
            imovel.edit();
            
            if(imovel.getLastMessage() != null){
                //System.out.println("Exceção: " + imovel.getLastMessage());
                response.sendRedirect("VisualizarEditarImovel.jsp?erro=yes");
            }
            else{
                session.setAttribute("imovel", imovel);
                response.sendRedirect("VisualizarEditarImovel.jsp?edited=yes");
            }
        }
        else{
            imovel.save();
            
            if(imovel.getLastMessage() != null){
                //System.out.println("Exceção: " + imovel.getLastMessage());
                response.sendRedirect("CadastrarImovel.jsp?erro=yes");
            }
            else{
                session.setAttribute("imovel", imovel);
                response.sendRedirect("CadastrarImovel.jsp?inserted=yes");
            }
        }
        
    }
    catch(Exception e){
        //System.out.println("Exceção: " + e.getMessage());
        
        if(editar != null){
            response.sendRedirect("VisualizarEditarImovel.jsp?erro=yes");
        }
        else{
            response.sendRedirect("CadastrarImovel.jsp?erro=yes");
        }
    }
%>

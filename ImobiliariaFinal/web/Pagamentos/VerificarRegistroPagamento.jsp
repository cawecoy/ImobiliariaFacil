<%-- 
    Document   : doCadastrarCliente
    Created on : Sep 12, 2011, 12:00:51 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Login"%>
<%@page import="SQL.Pagamento"%>
<%@page import="java.sql.Timestamp"%>
<%
    Timestamp data;
    
    float valor;
    int cep;
    int numero;
    int cpf;
    String cep_numero;
    Pagamento pagamento = new Pagamento();
    
    try{
        Login login;

        login = (Login) session.getAttribute("login");

        if(login == null){
            response.sendRedirect("../index.jsp?loginExpirado=yes");
        }
        else if(login.getCargo() == -1){
            response.sendRedirect("../index.jsp?semPermissao=yes");
        }
        
        data = Timestamp.valueOf(request.getParameter("ano") + "-" + request.getParameter("mes") + "-" + request.getParameter("dia") + " 00:00:00");
        
        valor = Float.parseFloat(request.getParameter("valor"));
        cpf = Integer.valueOf(request.getParameter("cliente_cpf"));
        cep_numero = request.getParameter("cep_numero");

        cep = Integer.valueOf(cep_numero.substring(0, cep_numero.lastIndexOf(":")));
        numero = Integer.valueOf(cep_numero.substring(cep_numero.lastIndexOf(":") + 1));
        
        pagamento.setData(data);
        pagamento.setValor(valor);
        pagamento.setImovel_cep(cep);
        pagamento.setImovel_numero(numero);
        pagamento.setCliente_cpf(cpf);

        System.out.println("");
        System.out.println(":: Locação de Imóvel ::");
        System.out.println("Data: " + pagamento.getData().toString());
        System.out.println("Valor do Pagamento: " + pagamento.getValor());
        System.out.println("CPF do cliente que pagou: " + pagamento.getCliente_cpf());
        System.out.println("CEP do imóvel: " + pagamento.getImovel_cep());
        System.out.println("Número do imóvel: " + pagamento.getImovel_numero());

        pagamento.save();

        if(pagamento.getLastMessage() != null){
            //System.out.println("Exceção: " + aluga.getLastMessage());
            response.sendRedirect("RegistrarPagamento.jsp?erro=yes");
        }
        else{
            response.sendRedirect("RegistrarPagamento.jsp?pagamento=yes");
        }
    }
    catch(Exception e){
        System.out.println("Exceção: " + e.getMessage());
        response.sendRedirect("RegistrarPagamento.jsp?erro=yes");
    }
%>

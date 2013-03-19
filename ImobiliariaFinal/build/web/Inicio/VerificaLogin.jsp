<%-- 
    Document   : VerificaLogin
    Created on : Nov 1, 2011, 5:12:19 PM
    Author     : cawecoyrodriguesmarega
--%>

<%@page import="SQL.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%
            Login login = new Login();
            
            String email = request.getParameter("email");
            String cpf = request.getParameter("cpf");
            int cargo = Integer.valueOf(request.getParameter("cargo")); //1 = gerente, 0 = corretor
            
            if(login.eValido(email, cpf, cargo) == true){
                session.setAttribute("login", login);
                response.sendRedirect("menu.jsp");
            }
            else{
                response.sendRedirect("../index.jsp?erro=yes");
            }
        %>
    </body>
</html>

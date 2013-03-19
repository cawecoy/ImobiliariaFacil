<%-- 
    Document   : index
    Created on : Sep 2, 2011, 5:01:25 PM
    Author     : leonardo
--%>

<%@page import="SQL.Cliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.ListaCliente"%>
<%@page import="SQL.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visualizar / Editar Imóveis</title>
        <link rel="stylesheet" type="text/css" href="../Stylesheet/stylesheet.css" />
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script type="text/javascript">
            function Editar(){
                document.getElementById("EditarCadastrar").innerHTML = '<input type="submit" value="Salvar" name="SalvarImovel" class="input" />';
                
                document.getElementById("cep").disabled = false;
                document.getElementById("cep").focus();
                
                document.getElementById("numero").disabled = false;
                document.getElementById("numero").focus();
                
                document.getElementById("suites").disabled = false;
                document.getElementById("suites").focus();
                
                document.getElementById("cozinhas").disabled = false;
                document.getElementById("cozinhas").focus();
                
                document.getElementById("quartos").disabled = false;
                document.getElementById("quartos").focus();
                
                document.getElementById("garagens").disabled = false;
                document.getElementById("garagens").focus();
                
                document.getElementById("banheiros").disabled = false;
                document.getElementById("banheiros").focus();
                
                document.getElementById("m2").disabled = false;
                document.getElementById("m2").focus();
                
                document.getElementById("mobiliada_sim").disabled = false;
                document.getElementById("mobiliada_sim").focus();
                
                document.getElementById("mobiliada_nao").disabled = false;
                document.getElementById("mobiliada_nao").focus();
                
                document.getElementById("outros").disabled = false;
                document.getElementById("outros").focus();
                
                document.getElementById("preco_aluguel").disabled = false;
                document.getElementById("preco_aluguel").focus();
                
                document.getElementById("preco_venda").disabled = false;
                document.getElementById("preco_venda").focus();
                
                document.getElementById("tipo").disabled = false;
                document.getElementById("tipo").focus();
                
                document.getElementById("url_foto").disabled = false;
                document.getElementById("url_foto").focus();
                
                document.getElementById("cidade").disabled = false;
                document.getElementById("cidade").focus();
                
                document.getElementById("rua").disabled = false;
                document.getElementById("rua").focus();
                
                document.getElementById("bairro").disabled = false;
                document.getElementById("bairro").focus();
                
                document.getElementById("proprietario").disabled = false;
                document.getElementById("proprietario").focus();
                
                document.getElementById("rua").focus();
            }
            
            var geocoder;
            var map;

            function codeAddress(address) {
              geocoder.geocode( { 'address': address}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                  map.setCenter(results[0].geometry.location);
                  var marker = new google.maps.Marker({
                      map: map,
                      position: results[0].geometry.location

                  });
                }
                else {
                  alert("Desculpe, o mapa não pode ser carregado pela seguinte razão: " + status);
                }
              });
            }

            function initialize() {
                geocoder = new google.maps.Geocoder();
                var latlng = new google.maps.LatLng(-34.397, 150.644);
                var myOptions = {
                  zoom: 15,
                  center: latlng,
                  mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                codeAddress("Londrina - Parana");
            }
            
            function exibir_mapa(){
                codeAddress(document.getElementById("rua").value + " " + document.getElementById("numero").value + " " + document.getElementById("cidade").value);
            }
        </script>
    </head>
    <body onload="initialize()">
        <%@ page import="SQL.Imovel" %>
        <%@ page import="SQL.ListaImovel" %>
        <%
        Login login;
        Imovel imovel = null;

        login = (Login) session.getAttribute("login");
        
        if(login == null){
            response.sendRedirect("../index.jsp?loginExpirado=yes");
        }
        else if(login.getCargo() == -1){
            response.sendRedirect("../index.jsp?semPermissao=yes");
        }

        if(request.getParameter("edited") != null){
            imovel = (Imovel) session.getAttribute("imovel");
            %>
        
            <script type="text/javascript">
                alert("Imóvel <%=imovel.getCep()%> | <%=imovel.getNumero()%> salvo com sucesso!");
            </script>
        
            <%
        }
        else if(request.getParameter("erro") != null){
            imovel = (Imovel) session.getAttribute("imovel");
            %>
            
            <script type="text/javascript">
                alert("Desculpe, alteração não foi realizada com sucesso :/");
            </script>
        
            <%
        }
        else{
            imovel = new Imovel();
            String cep_numero = request.getParameter("cep_numero");
            
            int cep = Integer.valueOf(cep_numero.substring(0, cep_numero.lastIndexOf(":")));
            int numero = Integer.valueOf(cep_numero.substring(cep_numero.lastIndexOf(":") + 1));
            
            imovel.getImovel(cep, numero);
            session.setAttribute("imovel", imovel);
        }
        
        session.setAttribute("cep_antigo", imovel.getCep());
        session.setAttribute("numero_antigo", imovel.getNumero());
        %>
        
        <div style="width: 100%; background-color: #880000; color: #ffffff;">
            &nbsp;Olá, <%=login.getNome()%> | <a STYLE="text-decoration:none; color: #cccccc;" href="../index.jsp?logout=yes">Logout</a>
        </div>
        
        <img src="../Images/logo.png"/>

        <br/>
        <br/>
        
        <form action="VerificaCadastro.jsp?editar=yes" method="POST">
            <table class="tabela">
                <thead>
                    <tr>
                        <td class="titleForm">
                            Visualizar / Editar Imóveis
                        </td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="form">
                            Rua (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="rua" value="<%=imovel.getRua()%>" disabled="true" id="rua" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Número (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="numero" value="<%=imovel.getNumero()%>" disabled="true" id="numero" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Bairro (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="bairro" value="<%=imovel.getBairro()%>" disabled="true" id="bairro" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            CEP (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cep" value="<%=imovel.getCep()%>" disabled="true" id="cep" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Cidade e Estado (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cidade" value="<%=imovel.getCidade()%>" disabled="true" id="cidade" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Tipo (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="tipo" value="<%=imovel.getTipo()%>" disabled="true" id="tipo" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Mapa | <input type="button" value="Carregar..." onclick="javascript: exibir_mapa();" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <div id="map_canvas" style="width: 400px; height:400px" style="visibility: hidden;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Preço para Locação (só se estiver para locação)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="preco_aluguel" value="<%=imovel.getPreco_aluguel()%>" disabled="true" id="preco_aluguel" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Preço para Venda (só se estiver para venda)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="preco_venda" value="<%=imovel.getPreco_venda()%>" disabled="true" id="preco_venda" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Mobiliada?
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <%
                            if(imovel.getMobiliada() == true){
                                %> <input type="radio" name="mobiliada" value="true" checked="checked"  disabled="true" id="mobiliada_sim" /> Sim <input type="radio" name="mobiliada" value="false" disabled="true" id="mobiliada_nao" /> Não <%
                            }
                            else{
                                %> <input type="radio" name="mobiliada" value="true" disabled="true" id="mobiliada_sim" /> Sim <input type="radio" name="mobiliada" value="false" checked="checked" disabled="true" id="mobiliada_nao" /> Não <%
                            }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Quartos
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="quartos" value="<%=imovel.getQuartos()%>" disabled="true" id="quartos" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Suítes
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="suites" value="<%=imovel.getSuites()%>" disabled="true" id="suites" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Cozinhas
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="cozinhas" value="<%=imovel.getCozinhas()%>" disabled="true" id="cozinhas" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Banheiros
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="banheiros" value="<%=imovel.getBanheiros()%>" disabled="true" id="banheiros" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Garagens
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="garagens" value="<%=imovel.getGaragens()%>" disabled="true" id="garagens" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Metros Quadrados
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="m2" value="<%=imovel.getM2()%>" disabled="true" id="m2" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Outros
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <input type="text" name="outros" value="<%=imovel.getOutros()%>" disabled="true" id="outros" class="input" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            URL Foto
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <img src="<%=imovel.getUrl_foto()%>" style="width: 400px; height: 400px;"/>
                            <br/>
                            <input type="text" name="url_foto" value="<%=imovel.getUrl_foto()%>" disabled="true" id="url_foto" class="input"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            Proprietário (Obrigatório)
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <select name="proprietario_cpf" disabled="true" id="proprietario" class="input">
                                <%
                                    ListaCliente lista = new ListaCliente();
                                    ArrayList clientes;

                                    lista.loadList();
                                    clientes = lista.getList();

                                    Iterator it = clientes.iterator();

                                    while(it.hasNext()){
                                        Cliente c = (Cliente) it.next();
                                        
                                        if(c.getCpf() == imovel.getProprietario_cpf()){
                                            %>
                                            
                                            <option value="<%=c.getCpf()%>" selected="true"><%=c.getNome()%></option>

                                            <%
                                        }
                                        else{
                                            %>

                                            <option value="<%=c.getCpf()%>"><%=c.getNome()%></option>

                                            <%
                                        }
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form">
                            <div id="EditarCadastrar"><input type="button" value="Editar" name="EditarImovel" onclick="javascript: Editar();" class="input" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="tabela">
                                <tbody>
                                    <tr>
                                        <td><input type="button" value="Sobre" name="Sobre" class="botoes" onclick="javascript: alert('Trabalho de Banco de Dados\nCiência da Computação, UEL\nAutores: Leonardo e Cawe Coy\nProf. Daniel Kaster');" /></td>
                                        <td><input type="button" value="Ajuda" name="Ajuda" class="botoes" onclick="javascript: alert('Para qualquer dúvida entre em contato:\ncawecoy@gmail.com\ntonzarlf@gmail.com');" /></td>
                                        <td><a href="PesquisarImovel.jsp"><input type="button" value="Voltar" name="Voltar" class="botoes" /></a></td>
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

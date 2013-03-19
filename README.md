ImobiliariaFacil
================

Autor: Cawe Coy e Leonzardo Tonzar

Descrição: Aplicativo web para gerentes e corretores de imobiliarias. Permite que o usuário gerencie clientes, imóveis, corretores (neste caso apenas para gerentes), pagamentos e realize venda/aluguel de imóveis.

Trabalho de Banco de Dados feito em 2011 (3a. série da graduação em Ciência da Computação - Universidade Estadual de Londrina).

Este é um aplicativo web desenvolvido em Java / JSP / HTML / CSS / JS que roda sob um servidor Tomcat e utiliza o banco de dados PostgreSQL. O desenvolvimento foi feito com o NetBeans IDE.

O banco precisa ter as seguintes configurações:

host: localhost / port: 5433 / database name: imobiliaria / user: postgres / password: marega

(o banco deve ser criado na sua máquina local, seguindo os dados acima. Para rodar em um banco remoto e/ou com alguma configuração diferente, será preciso alterar o código java, mais especificamente o parametro de todas as chamadas da função "getConnection")

Para criar e inicializar as tabelas, execute o aqruivo Script.sql no banco de dados especificado acima.

PS: Confesso que o código da aplicação está bastante sujos, pois as prioridades eram:
1) Banco de dados;
2) Aplicativo funcionando.

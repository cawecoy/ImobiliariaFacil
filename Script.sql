CREATE TABLE gerente (
	cpf int NOT NULL,
	rg varchar(10) NOT NULL,
	nome varchar(50) NOT NULL,
	endereco varchar(100) default NULL,
	telefone varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	PRIMARY KEY (cpf)
);

CREATE TABLE corretor (
	cpf int NOT NULL,
	rg varchar(10) NOT NULL,
	nome varchar(50) NOT NULL,
	endereco varchar(100) default NULL,
	telefone varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	PRIMARY KEY (cpf),
	CONSTRAINT email_vazio CHECK (email NOT LIKE ''),
	CONSTRAINT nome_corretor_vazio CHECK (nome NOT LIKE ''),
	CONSTRAINT telefone_corretor_vazio CHECK (telefone NOT LIKE '')
);

CREATE TABLE cliente (
	cpf int NOT NULL,
	rg varchar(10) default NULL,
	nome varchar(50) NOT NULL,
	endereco varchar(100) default NULL,
	telefone varchar(20) NOT NULL,
	email varchar(50) default NULL,
	corretor_cpf int NOT NULL,
	PRIMARY KEY (cpf),
	CONSTRAINT fk_corretor FOREIGN KEY (corretor_cpf) 
			REFERENCES corretor (cpf) 
			ON DELETE CASCADE 
			ON UPDATE CASCADE,
	CONSTRAINT telefone_vazio CHECK (telefone NOT LIKE ''),
	CONSTRAINT nome_vazio CHECK (nome NOT LIKE '')
);

CREATE TABLE imovel (
	cep int NOT NULL,
	numero int NOT NULL,
	suites int default 0,
	cozinhas int default 0,
	quartos int default 0,
	garagens int default 0,
	banheiros int default 0,
	m2 int default 0,
	mobiliada boolean default false,
	outros varchar(100) default NULL,
	preco_aluguel float default NULL,
	preco_venda float default NULL,
	tipo varchar(50) NOT NULL,
	url_foto varchar(100) default NULL,
	cidade varchar(50) default NULL,
	rua varchar(50) default NULL,
	bairro varchar(50) default NULL,
	proprietario_cpf int NOT NULL,
	PRIMARY KEY (cep, numero),
	CONSTRAINT fk_proprietario FOREIGN KEY (proprietario_cpf) 
			REFERENCES cliente (cpf) 
			ON DELETE CASCADE 
			ON UPDATE CASCADE,
	CONSTRAINT tipo_vazio CHECK (tipo NOT LIKE '')
);



CREATE TABLE pagamento(
	id_contrato serial NOT NULL,
	data timestamp NOT NULL,
	valor float NOT NULL,
	cliente_cpf int NOT NULL,
	imovel_cep int NOT NULL,
	imovel_numero int NOT NULL,
	PRIMARY KEY (id_contrato),
	CONSTRAINT fk_cliente FOREIGN KEY (cliente_cpf) 
		REFERENCES cliente (cpf) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
	CONSTRAINT fk_imovel FOREIGN KEY (imovel_cep, imovel_numero) 
		REFERENCES imovel (cep, numero) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE
);

CREATE TABLE compra(
	data timestamp NOT NULL default CURRENT_TIMESTAMP,
	cliente_cpf int NOT NULL,
	imovel_cep int NOT NULL,
	imovel_numero int NOT NULL,
	CONSTRAINT fk_cliente2 FOREIGN KEY (cliente_cpf) 
		REFERENCES cliente (cpf) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
	CONSTRAINT fk_imovel2 FOREIGN KEY (imovel_cep, imovel_numero) 
		REFERENCES imovel (cep, numero) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE
);

CREATE TABLE aluga(
	dia_pagamento int NOT NULL,
	data_inicio timestamp NOT NULL,
	data_fim timestamp NOT NULL,
	cliente_cpf int NOT NULL,
	imovel_cep int NOT NULL,
	imovel_numero int NOT NULL,
	CONSTRAINT fk_cliente3 FOREIGN KEY (cliente_cpf) 
		REFERENCES cliente (cpf) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
	CONSTRAINT fk_imovel3 FOREIGN KEY (imovel_cep, imovel_numero) 
		REFERENCES imovel (cep, numero) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE
);

INSERT INTO gerente VALUES (1234, 09010203, 'seu zé', 'rua nenhuma 2934', '(43) 9988 7766', 'seuze@gmail.com');
INSERT INTO gerente VALUES (0000, 7861226, 'mario', 'rua nenhuma 2934', '(43) 9988 7766', 'mario@gmail.com');
INSERT INTO gerente VALUES (1, 1, 'Gerente Fagunds', '1', '1', '1');

INSERT INTO corretor VALUES (1230094, 0239010203, 'seu louco', 'rua nenhuma 2934', '(43) 9988 7766', 'seulouco@gmail.com');
INSERT INTO corretor VALUES (0000999, 782361226, 'luigi', 'rua nenhuma 2934', '(43) 9988 7766', 'luigi@gmail.com');
INSERT INTO corretor VALUES (1, 1, 'Fagunds', '1', '1', '1');

INSERT INTO cliente VALUES (69, 11, 'oi', 'rua nenhuma 2934', '(43) 9988 7766', NULL, 0000999);
INSERT INTO cliente VALUES (24, 22, 'ok', 'rua da pqtp 99', '(17) 190', NULL, 0000999);
INSERT INTO cliente VALUES (007, 33, 'nice', 'nowhere', '(11) 0', 'nice@its.ok', 1230094);
INSERT INTO cliente VALUES (8, 44, 'all right', 'sei la', '(43) 11', 'a@loka.xxx', 1230094);

INSERT INTO imovel VALUES (1111, 4444, 1, 1, 1, 1, 1, 100, false, NULL, 500, 100000, 'apartamento', 'http://www.guiageografico.com/imagens/canada-foto.jpg', 'londrina', 'rua nada a ve', 'jd quebec', 69);

INSERT INTO imovel VALUES (1111, 666, 1, 1, 1, 1, 1, 200, true, 'bonus: há fogo por toda a casa', 999, 999999999, 'casa', 'http://www.guiageografico.com/imagens/canada-foto.jpg', 'hellcity', 'rua das bromélias nazistas', 'jd satanas', 007);

INSERT INTO aluga VALUES (5, '2011-10-08 00:00:00', '2012-09-08 09:30:44', 8, 1111, 4444);
INSERT INTO pagamento(data, valor, cliente_cpf, imovel_cep, imovel_numero) VALUES ('2011-10-08 00:00:00', 500, 8, 1111, 4444);

INSERT INTO compra (cliente_cpf, imovel_cep, imovel_numero) VALUES (24, 1111, 666);
INSERT INTO pagamento (data, valor, cliente_cpf, imovel_cep, imovel_numero) VALUES ('2011-10-08 00:00:00', 999999999, 24, 1111, 666);

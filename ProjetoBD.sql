drop database if EXISTS projetobd;
CREATE DATABASE projetobd
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;
USE projetobd;



CREATE TABLE IF NOT EXISTS Candidato(
	cpf_candidato VARCHAR (11) UNIQUE NOT NULL,
	nome_candidato VARCHAR (50),
	identidade_candidato INTEGER,
	`comprovante_de_residência_candidato` BLOB,
    certificado_de_legalidade_candidato BLOB,
    `número_de_inscrição_título_de_eleitor` INTEGER NOT NULL,
	CONSTRAINT PK_CPF_CANDIDATO PRIMARY KEY (cpf_candidato),
	CONSTRAINT FK_NUM_INS_T_E FOREIGN KEY (`número_de_inscrição_título_de_eleitor`) REFERENCES `Título_de_eleitor`(`número_de_inscrição_título_de_eleitor`)
);

CREATE TABLE IF NOT EXISTS `Título_de_eleitor`(
	`número_de_inscrição_título_de_eleitor` INTEGER NOT NULL,
	`zona_de_inscrição_titulo_de_eleitor` INTEGER,
	`região_titulo_de_eleitor` VARCHAR (50),
	CONSTRAINT PK_NUM_INSC_T_E PRIMARY KEY (`número_de_inscrição_título_de_eleitor`)
);

CREATE TABLE IF NOT EXISTS Candidatura(
	`código_da_candidatura` INTEGER NOT NULL AUTO_INCREMENT,
	ano_da_candidatura INTEGER,
	`número_do_partido_ficha_de_filiação` INTEGER NOT NULL,
    cpf_candidato VARCHAR (11) NOT NULL,
    CONSTRAINT UN_ANO_NUMPART UNIQUE(ano_da_candidatura, `número_do_partido_ficha_de_filiação`),
	CONSTRAINT PK_COD_CAND PRIMARY KEY (`código_da_candidatura`),
    CONSTRAINT FK_NUM_PART_FCH_FIL FOREIGN KEY (`número_do_partido_ficha_de_filiação`) REFERENCES `Ficha_de_filiação`(`número_do_partido_ficha_de_filiação`),
    CONSTRAINT FK_CPF_CANDIDATO FOREIGN KEY (`cpf_candidato`) REFERENCES Candidato(`cpf_candidato`)
);


CREATE TABLE IF NOT EXISTS Mandato(
	`código_do_mandato` INTEGER NOT NULL AUTO_INCREMENT,
	`código_da_candidatura` INTEGER NOT NULL UNIQUE,
	CONSTRAINT PK_COD_MAND PRIMARY KEY (`código_do_mandato`),
    CONSTRAINT FK_COD_CAND FOREIGN KEY (`código_da_candidatura`) REFERENCES Candidatura(`código_da_candidatura`)
);

CREATE TABLE IF NOT EXISTS `Ficha_de_filiação`(
	`número_do_partido_ficha_de_filiação` INTEGER NOT NULL,
	`nome_do_partido_ficha_de_filiação` VARCHAR (50),
	CONSTRAINT PK_NUM_PART_FCH_FIL PRIMARY KEY (`número_do_partido_ficha_de_filiação`)
);

CREATE TABLE IF NOT EXISTS `Declaração_de_bens`(
	`código_da_declaração` INTEGER NOT NULL AUTO_INCREMENT,
	`código_da_candidatura` INTEGER NOT NULL,
	CONSTRAINT PK_COD_DCL PRIMARY KEY (`código_da_declaração`),
    CONSTRAINT FK_COD_CAND FOREIGN KEY (`código_da_candidatura`) REFERENCES Candidatura(`código_da_candidatura`)
);

CREATE TABLE IF NOT EXISTS Bem(
	id_do_bem INTEGER NOT NULL AUTO_INCREMENT,
	tipo_do_bem VARCHAR (50),
	`descrição_do_bem` VARCHAR (800),
    valor_de_mercado_do_bem DOUBLE PRECISION,
    `código_da_declaração_de_bens` INTEGER NOT NULL,
	CONSTRAINT PK_ID_BEM PRIMARY KEY (`id_do_bem`),
	CONSTRAINT FK_COD_DCL_BENS FOREIGN KEY (`código_da_declaração_de_bens`) REFERENCES `Declaração_de_bens`(`código_da_declaração`)
);

CREATE TABLE IF NOT EXISTS `Votação`(
	`código_da_votação` INTEGER NOT NULL AUTO_INCREMENT,
	`resultado_da_votação` enum('eleito', 'eleito por média', 'eleito por quociente partidário', 'indeferido com recurso', 'não eleito', 'suplente', 'substituído', 'renúncia ou falecimento', 'registro negado antes da eleição', 'registro negado depois da eleição'),
	`situação_de_registro_de_candidatura_da_votação` enum('apto','inapto','cadastrado'),
    `código_da_candidatura` INTEGER NOT NULL UNIQUE,
	CONSTRAINT PK_COD_VOT PRIMARY KEY (`código_da_votação`),
	CONSTRAINT FK_COD_CAND FOREIGN KEY (`código_da_candidatura`) REFERENCES Candidatura(`código_da_candidatura`)
);

CREATE TABLE IF NOT EXISTS `Votação_possui_urna`(
	`código_da_votação` INTEGER NOT NULL,
	`código_da_urna` INTEGER NOT NULL,
	turno VARCHAR (8),
    ano INTEGER,
    
    CONSTRAINT FK_COD_VOT FOREIGN KEY (`código_da_votação`) REFERENCES `Votação`(`código_da_votação`),
    CONSTRAINT FK_COD_URNA FOREIGN KEY (`código_da_urna`) REFERENCES `Urna`(`código_da_urna`),
    CONSTRAINT PK_COD_VOT PRIMARY KEY (`código_da_votação`, `código_da_urna`)
	
);

CREATE TABLE IF NOT EXISTS Urna(
	`código_da_urna` INTEGER NOT NULL AUTO_INCREMENT,
	`quantidade_de_votos_da_urna` INTEGER,
	zona_da_urna INTEGER,
    `região_da_urna` VARCHAR (50),
    `município_da_urna` VARCHAR (50),
    estado_da_urna VARCHAR (50),
    CONSTRAINT PK_COD_URNA PRIMARY KEY (`código_da_urna`)
);

CREATE TABLE IF NOT EXISTS Gasto(
	`código_do_gasto` INTEGER NOT NULL AUTO_INCREMENT,
	data_gasto DATE,
	`descrição_do_gasto` VARCHAR (800),
    fornecedor_do_gasto VARCHAR (200),
    valor_total_do_gasto DOUBLE PRECISION,
    categoria_do_gasto  VARCHAR (100),
    valor_liquido_gasto DOUBLE PRECISION,
    `código_do_mandato` INTEGER NOT NULL,
    CONSTRAINT PK_COD_GAST PRIMARY KEY (`código_do_gasto`),
	CONSTRAINT FK_COD_MDT FOREIGN KEY (`código_do_mandato`) REFERENCES `Mandato`(`código_do_mandato`)
);

CREATE TABLE IF NOT EXISTS `Doação_de_campanha`(
	`num_de_identificação_doação` INTEGER NOT NULL AUTO_INCREMENT,
	`valor_doado_doação` DOUBLE PRECISION,
	`descrição_doação` VARCHAR (800),
    `data_doação`DATE,
    `hora_doação`VARCHAR (14),
    `código_da_candidatura`  INTEGER NOT NULL,
    CONSTRAINT PK_NUM_IDT_DOA PRIMARY KEY (`num_de_identificação_doação`),
	CONSTRAINT FK_COD_CAND FOREIGN KEY (`código_da_candidatura`) REFERENCES `Candidatura`(`código_da_candidatura`)
);

CREATE TABLE IF NOT EXISTS Doador(
	`código_doador` INTEGER NOT NULL AUTO_INCREMENT,
	`num_de_identificação_doação` INTEGER NOT NULL,
	CONSTRAINT PK_COD_DOA PRIMARY KEY (`código_doador`),
	CONSTRAINT FK_NUM_IDT_DOA FOREIGN KEY (`num_de_identificação_doação`) REFERENCES Doação_de_campanha(`num_de_identificação_doação`)
);

CREATE TABLE IF NOT EXISTS `Pessoa_física`(
	`código_doador` INTEGER NOT NULL,
	`cpf_pessoa_física` VARCHAR (11) UNIQUE,
	`nome_pessoa_física` VARCHAR (50),
	`cep_pessoa_física` INTEGER,
    `número_residência_pessoa_física` INTEGER,
    `telefone_pessoa_física` VARCHAR (15),
    
    CONSTRAINT PK_COD_DOA PRIMARY KEY (`código_doador`),
	CONSTRAINT FK_COD_DOA FOREIGN KEY (`código_doador`) REFERENCES Doador(`código_doador`)
);

CREATE TABLE IF NOT EXISTS `Verba_pública`(
	`código_doador` INTEGER NOT NULL,
	`rúbrica_verba_pública` INTEGER,
	`tipo_verba_pública` VARCHAR (50),
	`descrição_verba_pública` VARCHAR (800),
    CONSTRAINT PK_COD_DOA PRIMARY KEY (`código_doador`),
	CONSTRAINT FK_COD_DOA FOREIGN KEY (`código_doador`) REFERENCES Doador(`código_doador`)
);

-- BAIRRO
CREATE TABLE t_sip_bairro (
	cd_bairro NUMBER(4) NOT NULL,
	cd_cidade NUMBER(3) NOT NULL,
	nm_bairro VARCHAR2(50) NOT NULL
);
	
ALTER TABLE t_sip_bairro ADD CONSTRAINT pk_sip_bairro PRIMARY KEY ( cd_bairro );

-- CIDADE
CREATE TABLE t_sip_cidade (
	cd_cidade NUMBER(3) NOT NULL,
	cd_estado NUMBER(2) NOT NULL,
	nm_cidade VARCHAR2(50) NOT NULL
);

ALTER TABLE t_sip_cidade ADD CONSTRAINT pk_sip_cidade PRIMARY KEY (cd_cidade);

-- ESTADO
CREATE TABLE t_sip_estado (
	cd_estado NUMBER(2),
	nm_estado VARCHAR2(20),
	sg_estado CHAR(2)
);

ALTER TABLE t_sip_estado ADD CONSTRAINT pk_sip_estado PRIMARY KEY (cd_estado);

ALTER TABLE t_sip_estado MODIFY cd_estado NOT NULL;
ALTER TABLE t_sip_estado MODIFY nm_estado NOT NULL;
ALTER TABLE t_sip_estado MODIFY sg_estado NOT NULL;

--ENDEREÇO
CREATE TABLE t_sip_endereco (
	cd_end_correio NUMBER,
	cd_bairro NUMBER(4),
	nr_cep NUMBER(10),
	ds_logradouro VARCHAR2(10)
);

ALTER TABLE t_sip_endereco ADD CONSTRAINT pk_sip_endereco PRIMARY KEY (cd_end_correio);

ALTER TABLE t_sip_endereco MODIFY cd_end_correio NOT NULL;
ALTER TABLE t_sip_endereco MODIFY cd_bairro NOT NULL;
ALTER TABLE t_sip_endereco MODIFY nr_cep NOT NULL;
ALTER TABLE t_sip_endereco MODIFY ds_logradouro NOT NULL;

-- TIPO ENDEREÇO
CREATE TABLE t_sip_tipo_endereco(
	cd_tipo_endereco NUMBER(4) NOT NULL,
	nm_tipo_endereco VARCHAR2(20) NOT NULL
);

ALTER TABLE t_sip_tipo_endereco ADD CONSTRAINT pk_sip_tipo_endereco PRIMARY KEY (cd_tipo_endereco);

-- FUNCIONARIO ENDEREÇO
CREATE TABLE t_sip_funcionario_endereco(
	cd_end_func NUMBER(8) NOT NULL, 
	nr_matricula NUMBER(5) NOT NULL,
	cd_end_correio NUMBER NOT NULL,
	cd_tipo_endereco NUMBER(4) NOT NULL, 
	ds_complemento VARCHAR2(10) NOT NULL,
	nr_logradouro NUMBER(5) NOT NULL,
	ds_ponto_referencia VARCHAR2(200)
);

ALTER TABLE t_sip_funcionario_endereco ADD CONSTRAINT pk_sip_funcionario_endereco PRIMARY KEY ( cd_end_func );

-- FUNCIONARIO
CREATE TABLE t_sip_funcionario (
	nr_matricula NUMBER(5),
	cd_depto NUMBER(2),
	dt_nascimento Date,
	dt_admissao Date,
	vl_salario NUMBER(2, 7)
);

ALTER TABLE t_sip_funcionario ADD CONSTRAINT pk_sip_funcionario PRIMARY KEY ( nr_matricula );
ALTER TABLE t_sip_funcionario ADD nm_funcionario VARCHAR2(30) NOT NULL;
ALTER TABLE t_sip_funcionario MODIFY vl_salario NUMBER(7,2);
ALTER TABLE t_sip_funcionario MODIFY nr_matricula NOT NULL;
ALTER TABLE t_sip_funcionario MODIFY cd_depto NOT NULL;
ALTER TABLE t_sip_funcionario MODIFY dt_admissao NOT NULL;
ALTER TABLE t_sip_funcionario MODIFY dt_nascimento NOT NULL;
ALTER TABLE t_sip_funcionario MODIFY vl_salario NOT NULL;

--DEPARTAMENTO 
CREATE TABLE t_sip_depto(
	cd_depto NUMBER(2),
	nm_depto VARCHAR2(30),
	sg_depto CHAR(3)
);

ALTER TABLE t_sip_depto ADD CONSTRAINT pk_sip_departamento PRIMARY KEY ( cd_depto );
ALTER TABLE t_sip_depto ADD CONSTRAINT un_sip_depto UNIQUE ( nm_depto );
ALTER TABLE t_sip_depto MODIFY cd_depto NOT NULL;
ALTER TABLE t_sip_depto MODIFY nm_depto NOT NULL;
ALTER TABLE t_sip_depto MODIFY sg_depto NOT NULL;

-- DEPENDENTE
CREATE TABLE t_sip_dependente(
	nr_matricula NUMBER(5) NOT NULL,
	cd_dependente NUMBER(3) NOT NULL,
	nm_dependente VARCHAR2(60) NOT NULL,
	dt_nascimento DATE NOT NULL
);

ALTER TABLE t_sip_dependente ADD CONSTRAINT pk_sip_dependente PRIMARY KEY ( cd_dependente, nr_matricula );

--PROJETO
CREATE TABLE t_sip_projeto(
	cd_projeto NUMBER(5) NOT NULL,
	nm_projeto VARCHAR2(40) NOT NULL,
	dt_inicio DATE NOT NULL,
	dt_termino DATE
);

ALTER TABLE t_sip_projeto ADD CONSTRAINT pk_sip_projeto PRIMARY KEY ( cd_projeto );
ALTER TABLE t_sip_projeto ADD CONSTRAINT un_sip_projeto_nome UNIQUE ( nm_projeto );

--IMPLATAÇÃO
CREATE TABLE t_sip_implantacao(
	cd_projeto NUMBER(5) NOT NULL,
	cd_implantacao NUMBER(3) NOT NULL,
	nr_matricula NUMBER(5) NOT NULL,
	dt_entrada DATE NOT NULL,
	dt_saida DATE
);

ALTER TABLE t_sip_implantacao ADD CONSTRAINT pk_sip_implantacao PRIMARY KEY ( cd_projeto, cd_implantacao );

-- FOREIGN KEYS 

ALTER TABLE t_sip_implantacao 
	ADD CONSTRAINT fk_sip_implantacao_func FOREIGN KEY ( nr_matricula )
		REFERENCES t_sip_funcionario ( nr_matricula );
		
ALTER TABLE t_sip_implantacao 
	ADD CONSTRAINT fk_sip_implantacao_projeto FOREIGN KEY ( cd_projeto )
		REFERENCES t_sip_projeto ( cd_projeto );

ALTER TABLE t_sip_dependente 
	ADD CONSTRAINT fk_sip_dependente_func FOREIGN KEY ( nr_matricula ) 
		REFERENCES t_sip_funcionario ( nr_matricula );

ALTER TABLE t_sip_funcionario 
	ADD CONSTRAINT fk_sip_func_depto FOREIGN KEY ( cd_depto )
		REFERENCES t_sip_depto ( cd_depto );
		
ALTER TABLE t_sip_funcionario_endereco
	ADD CONSTRAINT fk_sip_end_correio_func FOREIGN KEY ( cd_end_correio )
		REFERENCES t_sip_endereco ( cd_end_correio );
		
ALTER TABLE t_sip_funcionario_endereco 
	ADD CONSTRAINT fk_sip_funcionario_end FOREIGN KEY ( nr_matricula )
		REFERENCES t_sip_funcionario ( nr_matricula );
		
ALTER TABLE t_sip_funcionario_endereco 
	ADD CONSTRAINT fk_sip_tipo_endereco FOREIGN KEY ( cd_tipo_endereco )
		REFERENCES t_sip_tipo_endereco ( cd_tipo_endereco );

ALTER TABLE t_sip_cidade
    ADD CONSTRAINT fk_sip_estado_cidade FOREIGN KEY ( cd_estado )
        REFERENCES t_sip_estado ( cd_estado );
		
ALTER TABLE t_sip_bairro 
	ADD CONSTRAINT fk_cidade_bairro  FOREIGN KEY ( cd_cidade )
		REFERENCES t_sip_cidade ( cd_cidade );
		
ALTER TABLE t_sip_endereco 
	ADD CONSTRAINT fk_sip_bairro_endereco FOREIGN KEY ( cd_bairro )
		REFERENCES t_sip_bairro ( cd_bairro );
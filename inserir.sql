-- INSERIR UMA LINHA/REGISTRO NA TABELA
INSERT INTO t_sip_depto (cd_depto, nm_depto, ds_sigla) -- nomes das colunas/campo da tabela
	VALUES (1, 'FINANCEIRO', 'FIN'); -- valores que serão armazenados nas colunas / campos
	
COMMIT;

SELECT * FROM t_sip_depto;

INSERT INTO t_sip_depto (2, 'MARKETING', 'MKT');
SELECT * FROM t_sip_depto;

COMMIT;

INSERT INTO t_sip_projeto (cd_projeto, nm_projeto, dt_inicio, dt_termino)
	VALUES (1, 'PROJETO VL CHAVO', TO_DATE('19/04/1994', 'DD/MM/YYYY'), TO_DATE('01/06/1996', 'DD/MM/YYYY'));
	
COMMIT;

INSERT INTO t_sip_funcionario (nr_matricula, cd_depto, nm_funcionario, dt_nascimento, dt_admissao, vl_salario)
	VALUES (12345, 1, 'VITOR SILVA', TO_DATE('08/08/1995', 'DD/MM/YYYY'), TO_DATE('03/01/2019', 'DD/MM/YYYY'), 5900.14);
	
INSERT INTO t_sip_funcionario VALUES (12346, 2, TO_DATE('01/06/1994', 'DD/MM/YYYY'), TO_DATE('10/12/2021', 'DD/MM/YYYY'), 15000.25, 'Thais Gomes');
	
SELECT * FROM t_sip_funcionario;

COMMIT;

INSERT INTO t_sip_projeto (cd_projeto, nm_projeto, dt_inicio)
	VALUES (2, 'PROJETO 2', TO_DATE('14/09/1993', 'DD/MM/YYYY'));

INSERT INTO t_sip_projeto VALUES (3, 'PROJETO 3', TO_DATE('12/12/1994', 'DD/MM/YYYY'), NULL);

--Update 
UPDATE t_sip_funcionario 
	SET nm_funcionario = 'VITOR OLIVEIRA',	
		dt_nascimento = TO_DATE('01/06/1996', 'DD/MM/YYYY')
	WHERE nr_matricula = 12345;

UPDATE t_sip_funcionario 
	SET vl_salario = vl_salario * 1.05;
	
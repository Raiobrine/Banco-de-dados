SELECT c.nome_candidato as 'Nome', c.cpf_candidato as 'CPF'
from gasto as g, candidato as c,mandato as m,candidatura as ctra, votação as v, urna as u, votação_possui_urna as vu
where u.município_da_urna = 'Campina Grande' and u.código_da_urna = vu.código_da_urna 
and vu.código_da_votação = v.código_da_votação and v.código_da_candidatura = m.código_da_candidatura 
and m.código_do_mandato = g.código_do_mandato and g.valor_total_do_gasto and 
ctra.código_da_candidatura = v.código_da_candidatura and ctra.cpf_candidato = c.cpf_candidato
group by  c.nome_candidato;

-- Atributos definidos na cláusula Group BY diferente do grupo de atributos definidos na cláusula SELECT
-- Faltou aplicar o filtro no gasto de campanha

B)
-- Liste os candidatos pelo nome e CPF e código do partido, total declarado, total recebido em doação e total gasto em campanha que possuíram mais de 500 votos na eleição de 2018 na cidade de Campina Grande;

SELECT 
	TEMP.cpf_candidato,
	TEMP.nome_candidato,
	TEMP.código_da_candidatura,
	TEMP.TOTAL AS TOTAL_DECLARADO,
	TEMP.QTD_VOTOS,
	SUM(DC.valor_doado_doação) AS VALOR_TOTAL_DOACAO,
	SUM(G.valor_total_do_gasto) AS VALOR_TOTAL_DO_GASTO
FROM (
	SELECT
	-- *
		TEMP1.cpf_candidato,
		TEMP1.nome_candidato,
		TEMP1.código_da_candidatura,
		SUM(TEMP1.QTD_VOTOS) AS QTD_VOTOS,
		SUM(TEMP1.SOMA) AS TOTAL
	FROM (
		SELECT
				C.cpf_candidato,
				C.nome_candidato,
				CD.código_da_candidatura,
				SUM(U.quantidade_de_votos_da_urna) AS QTD_VOTOS,
				SUM(B.valor_de_mercado_do_bem) / COUNT(C.cpf_candidato) AS SOMA
			FROM `Candidato` C
			INNER JOIN `Candidatura` CD ON CD.cpf_candidato = C.cpf_candidato
			INNER JOIN `Votação` V ON V.`código_da_candidatura` = CD.código_da_candidatura
			INNER JOIN `Votação_possui_urna` VPU ON VPU.código_da_votação = V.código_da_votação
			INNER JOIN `Urna` U ON U.código_da_urna = VPU.código_da_urna
			INNER JOIN `Declaração_de_bens` DB ON DB.código_da_candidatura = CD.código_da_candidatura
			INNER JOIN `Bem` B ON B.código_da_declaração_de_bens = DB.código_da_declaração
			WHERE 
			V.situação_de_registro_de_candidatura_da_votação = 'apto' AND
			VPU.ano = 2018 AND
			U.município_da_urna = 'Campina Grande'
		GROUP BY C.cpf_candidato, 
					C.nome_candidato, 
					B.valor_de_mercado_do_bem,
					CD.código_da_candidatura,
					U.quantidade_de_votos_da_urna
	) TEMP1
	GROUP BY TEMP1.cpf_candidato,
		TEMP1.nome_candidato,
		TEMP1.código_da_candidatura
	-- WHERE QTD_VOTOS > 500
) AS TEMP
	INNER JOIN `Doação_de_campanha` DC ON DC.código_da_candidatura = TEMP.código_da_candidatura
	INNER JOIN `Mandato` M ON M.código_da_candidatura = TEMP.código_da_candidatura
	INNER JOIN `Gasto` G ON G.código_do_mandato = M.código_do_mandato
WHERE TEMP.QTD_VOTOS > 500
GROUP BY TEMP.cpf_candidato,
	TEMP.nome_candidato,
	TEMP.código_da_candidatura,
	TEMP.TOTAL;

	-- A consulta ficou desnecessariamente longa porque o esquema lógico não ajudou e poque a consulta foi montada com base em consultas aninhadas, mas responde a contento o resultado pedido.

	-- Liste o nome de todas as cidades e o respectivo total de votos no pleito de 2018 para o candidato "João". 

	select u.município_da_urna as 'Cidades', SUM(u.quantidade_de_votos_da_urna) as 'Total de votos'
	from urna as u, votação_possui_urna as vpu, votação as v, candidatura as ctra, candidato as c
	where c.nome_candidato = 'João' and c.cpf_candidato = ctra.cpf_candidato and ctra.código_da_candidatura = v.código_da_candidatura
	and v.código_da_votação = vpu.código_da_votação and vpu.código_da_urna = u.código_da_urna
	and vpu.ano = '2018'
	group by u.município_da_urna;
	
	-- OK

	--  Selecione o total de doação partidária recebido pelos candidatos do partido ‘CDU’.

	select f.nome_do_partido_ficha_de_filiação as 'Partido', SUM(d.valor_doado_doação) as 'Total doado'
	from Ficha_de_filiação as f, candidatura as ctra, Doação_de_campanha as d, Candidato as c 
	where f.nome_do_partido_ficha_de_filiação = 'CDU' and f.número_do_partido_ficha_de_filiação = ctra.número_do_partido_ficha_de_filiação
	and ctra.código_da_candidatura = d.código_da_candidatura and ctra.cpf_candidato = c.cpf_candidato;

	--  Comentário: OK

	-- E)
	-- Apresente uma relação dos 3 partidos que receberam maior número de verbas partidárias

	SELECT f.nome_do_partido_ficha_de_filiação as 'Partido', f.número_do_partido_ficha_de_filiação as 'Número do partido' , SUM(d.`valor_doado_doação`) as "Verbas"
	FROM `Doação_de_campanha` as d, `Ficha_de_filiação` as f, Candidatura as ctra
	WHERE d.`código_da_candidatura` = ctra.`código_da_candidatura` and ctra.número_do_partido_ficha_de_filiação = f.número_do_partido_ficha_de_filiação
	GROUP BY f.nome_do_partido_ficha_de_filiação
	ORDER BY SUM(d.`valor_doado_doação`) DESC
	LIMIT 3; 

	-- Comentário: Erro na diferença entre atributos declarados no select e no group by 


	-- F)
	-- Relacione os 5 partidos mais bem votados na eleição de 2018 na Paraíba (considere apenas candidatos cujo registros esteja apto).

	SELECT f.nome_do_partido_ficha_de_filiação as 'Partido', f.número_do_partido_ficha_de_filiação as 'Número do partido' 
	FROM `Ficha_de_filiação` as f, Candidatura as ctra, `Votação` as v, `Votação_possui_urna` as vu, Urna as u
	WHERE v.`código_da_votação` = vu.`código_da_votação` and ctra.`código_da_candidatura` = v.`código_da_candidatura`
	and u.`código_da_urna` = vu.`código_da_urna` and vu.ano = 2018 and u.estado_da_urna = 'Paraíba' and v.`situação_de_registro_de_candidatura_da_votação` = 'apto'
	GROUP BY f.nome_do_partido_ficha_de_filiação
	ORDER BY SUM(u.`quantidade_de_votos_da_urna`) DESC
	LIMIT 5;

	-- Comentário: Erro na diferença entre atributos declarados no select e no group by 


	-- G)
	-- Relacione os 10 candidatos mais ricos que foram eleitos na Paraíba em 2018 (considere apenas candidatos cujo registros esteja apto)

	SELECT
	    TEMP.cpf_candidato AS CPF_CANDIDATO,
	    TEMP.nome_candidato AS NOME_CANDIDATO,
	    SUM(TEMP.SOMA) TOTAL
	FROM (
	    SELECT
	        C.cpf_candidato,
	        C.nome_candidato,
	        -- B.valor_de_mercado_do_bem,
	        SUM(B.valor_de_mercado_do_bem) / COUNT(C.cpf_candidato) AS SOMA
	    FROM `Candidato` C
	    INNER JOIN `Candidatura` CD ON CD.cpf_candidato = C.cpf_candidato
	    INNER JOIN `Votação` V ON V.`código_da_candidatura` = CD.código_da_candidatura
	    INNER JOIN `Votação_possui_urna` VPU ON VPU.código_da_votação = V.código_da_votação
	    INNER JOIN `Urna` U ON U.código_da_urna = VPU.código_da_urna
	    INNER JOIN `Declaração_de_bens` DB ON DB.código_da_candidatura = CD.código_da_candidatura
	    INNER JOIN `Bem` B ON B.código_da_declaração_de_bens = DB.código_da_declaração
	    WHERE 
	    V.resultado_da_votação = 'eleito' AND
	    V.situação_de_registro_de_candidatura_da_votação = 'apto' AND
	    VPU.ano = 2018 AND
	    U.estado_da_urna = 'Paraíba'
	    GROUP BY C.cpf_candidato, C.nome_candidato, B.valor_de_mercado_do_bem
	) AS TEMP
	GROUP BY TEMP.cpf_candidato, TEMP.nome_candidato order by SUM(TEMP.SOMA) desc
	LIMIT 10;

	-- Comentário: OK

	-- H)
	-- Apresente uma lista de todas as cidades e seus respectivos quantitativos de votos nos candidatos do partido ‘CDU’. Ordene pela quantidade de votos válidos.

	select f.nome_do_partido_ficha_de_filiação as 'Nome', sum(u.quantidade_de_votos_da_urna) as 'Votos', u.município_da_urna as 'Cidade'
	from urna as u, ficha_de_filiação as f, candidatura as ctra, votação as v, votação_possui_urna as vpu, candidato as c
	where f.nome_do_partido_ficha_de_filiação = 'CDU' and ctra.número_do_partido_ficha_de_filiação = f.número_do_partido_ficha_de_filiação
	and v.código_da_candidatura = ctra.código_da_candidatura and v.código_da_votação = vpu.código_da_votação
	and vpu.código_da_urna = u.código_da_urna AND ctra.cpf_candidato = c.cpf_candidato
	group by u.município_da_urna order by sum(u.quantidade_de_votos_da_urna) desc;

	-- Comentário: OK

	


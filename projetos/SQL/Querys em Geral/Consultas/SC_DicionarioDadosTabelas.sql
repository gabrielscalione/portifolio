

-- CONSULTA VIEWS DO BANCO

SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name
FROM 
	sys.views as v
ORDER BY  v.name


-- CONSULTA AS TABELAS DO BANCO
SELECT 
	* 
FROM information_schema.tables
WHERE TABLE_NAME LIKE 'S%'
order by TABLE_NAME


-- CONSULTA A ESTRUTURA DA TABELA
SELECT
 	  S.name as 'Schema',
	  
	  T.name as Tabela,
	  C.name as Coluna,
	  CASE WHEN C.name = 'Codigo' THEN 'PK'
		ELSE ''
		END as Chave,
	  '' AS Chave_estrangeira,
	  TY.name as Tipo,
	  C.max_length as 'Tamanho Máximo', -- Tamanho em bytes, para nvarchar normalmente se divide este valor por 2
	  C.precision as 'Precisão',		-- Para tipos numeric e decimal (tamanho)
	  C.scale as 'Escala' -- Para tipos numeric e decimal (números após a virgula)
FROM sys.columns C
	INNER JOIN sys.tables T
	  ON T.object_id = C.object_id
	INNER JOIN sys.types TY
	  ON TY.user_type_id = C.user_type_id
	LEFT JOIN sys.schemas S
	  ON T.schema_id = S.schema_id
where  T.name like 'S17_SEQUENCIA_PROPOSTA'
order by t.name

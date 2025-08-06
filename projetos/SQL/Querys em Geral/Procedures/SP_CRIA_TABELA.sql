CREATE PROC SP_CRIA_TABELA
(
	@NOMETB VARCHAR(40),
	@COLUNAS VARCHAR(MAX),
	@INSERTSELECT VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SQL1 VARCHAR(MAX),@SQL2 VARCHAR(MAX),@SQL3 VARCHAR(MAX), @OBJID int

	SET @OBJID = OBJECT_ID(@NOMETB)
	SET @SQL1 = 'DROP TABLE ' + @NOMETB
	SET @SQL2 = ('CREATE TABLE ' + @NOMETB + ' (' + @COLUNAS + ') ')
	SET @SQL3 = ('INSERT INTO ' + @NOMETB + ' ' + @INSERTSELECT )

	IF @OBJID IS NOT NULL
	BEGIN
		EXEC (@SQL1)
	END

	EXEC (@SQL2)

	IF @INSERTSELECT <> ''
	BEGIN
		EXEC (@SQL3)
	END

END

---------------------------------------------------------------------------------------------------

-- EXEMPLO DE EXECUTAÇÃO

EXEC SP_CRIA_TABELA 
/*NOME DA TABELA*/'E031_REQUERIMENTO'
/*NOME DAS COLUNAS*/, '	Codigo int NOT NULL CONSTRAINT PK_E031_Requerimento PRIMARY KEY (Codigo)
,	E031_IdE030 int NOT NULL
,	E031_IdE031 int
,	E031_CodigoSolicitante int NOT NULL
,	E031_TipoSolicitante varchar (10) NOT NULL
,	E031_Data datetime
,	E031_Observacao varchar (2000)
,	E031_Situacao varchar (50)
,	E031_Anexo varbinary (max)
,	E031_DataCriacao datetime
,	E031_DataAlteracao datetime
,	E031_IdE900 int NOT NULL
,	E031_Origem varchar (50)'
/*INSERTSELECT*/, ''

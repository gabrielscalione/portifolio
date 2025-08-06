-- ************************************************
-- JOB_MONIT_REPROCES
--
-- Script para monitorar o reprocessamento feito
-- automaticamente pelo SISTEMA.
--
-- Ele estar� dentro de uma Job que estar� rodando 
-- de 1 em 1 minuto das 20h at� as 22h, assim 
-- pegar� com certeza o in�cio e termino da rotina
--
-- ************************************************

DECLARE @STATUS		CHAR (1)
DECLARE @ITEM		VARCHAR (6)
DECLARE @MENSAGEM	VARCHAR (2000)
DECLARE @ASSUNTO	VARCHAR (200)

SET @STATUS		= ''
SET @ITEM		= ''
SET @MENSAGEM	= ''
SET @ASSUNTO	= ''

	SELECT @STATUS  = TSK_STATUS,
		   @ITEM	= TSK_ITEM
	FROM   SCHDTSK
	WHERE  D_E_L_E_T_ = ''
	   AND TSK_ROTINA = 'CTBA190'
	   AND (SUBSTRING(TSK_DIA,1,4)+'-'+SUBSTRING(TSK_DIA,5,2)+'-'+SUBSTRING(TSK_DIA,7,2)) = CAST(GETDATE() AS DATE)


IF @STATUS IN ('1','2','3') AND NOT EXISTS (SELECT 1 FROM TB_CONFERE_REPROCES WHERE STATUS = @STATUS AND ITEM = @ITEM)
	BEGIN

	SELECT
		@ASSUNTO  = CASE @STATUS 
						WHEN '1' THEN 'Status Reprocessamento - INICIADO'
						WHEN '2' THEN 'Status Reprocessamento - FINALIZADO'
						WHEN '3' THEN 'Status Reprocessamento - COM FALHA!'
						END,
		@MENSAGEM = CASE @STATUS
						WHEN '1' THEN 'O reprocessamento cont�bil est� em excecu��o e foi inciado �s '+ CONVERT(VARCHAR,GETDATE(),113 )
						WHEN '2' THEN 'O reprocessamento cont�bil foi finalizado com �xito �s '+ CONVERT(VARCHAR,GETDATE(),113 )
						WHEN '3' THEN 'O reprocessamento cont�bil <b>FALHOU</b> e n�o finalizou'
						END

		EXEC MSDB.dbo.SP_SEND_DBMAIL      
	   @PROFILE_NAME = PROFILENAME, -- PROFILE DA BASE       
	   @RECIPIENTS = 'email@email.com',    
	   @SUBJECT		= @ASSUNTO,      
	   @BODY		= @MENSAGEM,
	   @BODY_FORMAT = HTML;      
       
	INSERT INTO TB_CONFERE_REPROCES
	VALUES (@STATUS, @ITEM,'CTBA190')

	SELECT  @STATUS		= '',
			@MENSAGEM	= '',
			@ASSUNTO	= ''
	
	END
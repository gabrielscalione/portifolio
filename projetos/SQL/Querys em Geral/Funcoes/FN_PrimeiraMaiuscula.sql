/*
	FUNÇÃO FN_PrimeiraMaiuscula
	Finalidade: Retornar o texto com a primeira letra da palavra maiusculo
*/


CREATE OR ALTER FUNCTION FN_PrimeiraMaiuscula(@Texto VARCHAR(255))  
  
RETURNS Varchar(255)  
  
AS BEGIN  
  
DECLARE @TextoTemp VARCHAR(255)  
DECLARE @i INT  
SET @TextoTemp = LOWER(@Texto)  
SET @TextoTemp = UPPER(LEFT(@TextoTemp,1)) + SUBSTRING(@TextoTemp,2,LEN(@TextoTemp))  
  
WHILE CHARINDEX(' ',@TextoTemp,1) > 0  
BEGIN  
SET @i = CHARINDEX(' ',@TextoTemp,1)  
SET @TextoTemp = LEFT(@TextoTemp,@i-1) + '~*' + UPPER(SUBSTRING(@TextoTemp,@i + 1,1)) + SUBSTRING(@TextoTemp,@i+2,LEN(@TextoTemp))  
END  
  
SET @TextoTemp = REPLACE(@TextoTemp,'~*',' ')  
  
IF (PATINDEX('% da %', @TextoTemp) > 0)  
BEGIN  
SET @TextoTemp = STUFF(@TextoTemp, PATINDEX('% da %', @TextoTemp), 4, ' da ')  
END  
IF (PATINDEX('% das %', @TextoTemp) > 0)  
BEGIN  
SET @TextoTemp = STUFF(@TextoTemp, PATINDEX('% das %', @TextoTemp), 5, ' das ')  
END  
IF (PATINDEX('% de %', @TextoTemp) > 0)  
BEGIN  
SET @TextoTemp = STUFF(@TextoTemp, PATINDEX('% de %', @TextoTemp), 4, ' de ')  
END  
IF (PATINDEX('% do %', @TextoTemp) > 0)  
BEGIN  
SET @TextoTemp = STUFF(@TextoTemp, PATINDEX('% do %', @TextoTemp), 4, ' do ')  
END  
IF (PATINDEX('% dos %', @TextoTemp) > 0)  
BEGIN  
SET @TextoTemp = STUFF(@TextoTemp, PATINDEX('% dos %', @TextoTemp), 5, ' dos ')  
END  
SET @Texto = @TextoTemp  
RETURN @Texto  
END  
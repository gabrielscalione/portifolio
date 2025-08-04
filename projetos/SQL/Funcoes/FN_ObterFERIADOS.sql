CREATE FUNCTION FN_ObterFeriado(@ano INT)
    RETURNS SMALLDATETIME
AS
BEGIN
    DECLARE @seculo INT, @G INT, @K INT, @I INT, @H INT, @J INT, @L INT, @MesDePascoa INT, @DiaDePascoa INT, @pascoa SMALLDATETIME;
  
    SET @seculo = @ano / 100
    SET @G = @ano % 19
    SET @K = ( @seculo - 17 ) / 25
    SET @I = ( @seculo - CAST(@seculo / 4 AS INT) - CAST(( @seculo - @K ) / 3 AS INT) + 19 * @G + 15 ) % 30
    SET @H = @I - CAST(@I / 28 AS INT) * ( 1 * -CAST(@I / 28 AS INT) * CAST(29 / ( @I + 1 ) AS INT) ) * CAST(( ( 21 - @G ) / 11 ) AS INT)
    SET @J = ( @ano + CAST(@ano / 4 AS INT) + @H + 2 - @seculo + CAST(@seculo / 4 AS INT) ) % 7
    SET @L = @H - @J
    SET @MesDePascoa = 3 + CAST(( @L + 40 ) / 44 AS INT)
    SET @DiaDePascoa = @L + 28 - 31 * CAST(( @MesDePascoa / 4 ) AS INT)
    SET @pascoa = CAST(@MesDePascoa AS VARCHAR(2)) + '-' + CAST(@DiaDePascoa AS VARCHAR(2)) + '-' + CAST(@ano AS VARCHAR(4))
     
    RETURN @pascoa;
END
GO


CREATE FUNCTION ObterFeriados(@ano INT = NULL)
    RETURNS @feriado TABLE (dia DATE, feriado VARCHAR(100))
AS
BEGIN
     DECLARE @pascoa SMALLDATETIME;
     DECLARE @dia INT;
     DECLARE @mes INT;
     DECLARE @anoPascoa INT;
  
     IF(@ano IS NULL)
     BEGIN
         SET @ano = DATEPART(YEAR, GETDATE());
     END
  
     SET @pascoa = dbo.ObterDataPascoa(@ano);
     SET @dia = DATEPART(DAY, @pascoa);
     SET @mes = DATEPART(MONTH, @pascoa);
     SET @anoPascoa = DATEPART(YEAR, @pascoa);
  
     INSERT INTO @feriado (dia, feriado) VALUES(@pascoa, 'Pascoa');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST('1-1-' + CAST(@anoPascoa AS VARCHAR) AS DATE), 'Confraternização Universal');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST(CAST(@anoPascoa AS VARCHAR) + '-4-21' AS DATE), 'Tiradentes');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST(CAST(@anoPascoa AS VARCHAR) + '-5-1' AS DATE), 'Dia do Trabalhador');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST(CAST(@anoPascoa AS VARCHAR) + '-9-7' AS DATE), 'Dia da Independência');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST(CAST(@anoPascoa AS VARCHAR) + '-10-12' AS DATE), 'N. S. Aparecida');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST(CAST(@anoPascoa AS VARCHAR) + '-11-2' AS DATE), 'Todos os santos');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST(CAST(@anoPascoa AS VARCHAR) + '-11-15' AS DATE), 'Proclamação da republica');
     INSERT INTO @feriado (dia, feriado) VALUES(CAST(CAST(@anoPascoa AS VARCHAR) + '-12-25' AS DATE), 'Natal');
     INSERT INTO @feriado (dia, feriado) VALUES(DATEADD(DAY, 60, @pascoa), 'Corpus Christi');
     INSERT INTO @feriado (dia, feriado) VALUES(DATEADD(DAY, -2, @pascoa), '6º feira Santa');
     INSERT INTO @feriado (dia, feriado) VALUES(DATEADD(DAY, -47, @pascoa), '3º feria Carnaval');
     INSERT INTO @feriado (dia, feriado) VALUES(DATEADD(DAY, -48, @pascoa), '2º feria Carnaval');
  
     RETURN;
END




SELECT dia,
feriado
FROM dbo.ObterFeriados(2023)
ORDER BY dia;

SELECT DISTINCT TURNO FROM LY_FERIADO

INSERT INTO LY_FERIADO (TURNO, DATA, TIPO)
SELECT 'VESPERTINO',dia,'Feriado'
FROM dbo.ObterFeriados(2023)
ORDER BY dia;


select * from LY_FERIADO order by DATA
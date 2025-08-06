USE PlataformaCursos
GO

CREATE FUNCTION fn_MediaAvaliacao(@ID_Curso INT)
RETURNS DECIMAL(4,2)
AS
BEGIN
    DECLARE @Media DECIMAL(4,2);
    SELECT @Media = AVG(CAST(Nota AS DECIMAL(4,2))) FROM Avaliacao WHERE ID_Curso = @ID_Curso;
    RETURN ISNULL(@Media, 0);
END;

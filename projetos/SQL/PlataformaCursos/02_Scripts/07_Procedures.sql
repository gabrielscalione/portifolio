USE PlataformaCursos
GO


CREATE PROCEDURE sp_InserirMatriculaPagamento
    @ID_Aluno INT,
    @ID_Curso INT,
    @Valor DECIMAL(10,2),
    @FormaPagamento VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ID_Matricula INT;

    INSERT INTO Matricula (ID_Aluno, ID_Curso, Status)
    VALUES (@ID_Aluno, @ID_Curso, 'Ativa');

    SET @ID_Matricula = SCOPE_IDENTITY();

    INSERT INTO Pagamento (ID_Matricula, Valor, FormaPagamento)
    VALUES (@ID_Matricula, @Valor, @FormaPagamento);
END;

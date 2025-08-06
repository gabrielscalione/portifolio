USE PlataformaCursos
GO

CREATE TRIGGER trg_CancelamentoMatricula
ON Matricula
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status)
    BEGIN
        PRINT 'Status da matr�cula foi alterado.';
    END
END;

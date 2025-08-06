USE PlataformaCursos
GO

CREATE VIEW vw_FaturamentoPorCurso AS
SELECT C.Nome AS Curso, SUM(P.Valor) AS TotalFaturado
FROM Curso C
JOIN Matricula M ON C.ID_Curso = M.ID_Curso
JOIN Pagamento P ON M.ID_Matricula = P.ID_Matricula
GROUP BY C.Nome;

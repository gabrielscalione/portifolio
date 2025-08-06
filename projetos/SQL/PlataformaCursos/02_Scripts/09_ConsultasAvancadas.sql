USE PlataformaCursos
GO

-- Ranking dos cursos mais vendidos
SELECT TOP 5 C.Nome, COUNT(M.ID_Matricula) AS TotalMatriculas
FROM Curso C
JOIN Matricula M ON C.ID_Curso = M.ID_Curso
GROUP BY C.Nome
ORDER BY TotalMatriculas DESC;

-- Faturamento mensal
SELECT FORMAT(P.DataPagamento, 'yyyy-MM') AS Mes, SUM(P.Valor) AS Total
FROM Pagamento P
GROUP BY FORMAT(P.DataPagamento, 'yyyy-MM')
ORDER BY Mes;

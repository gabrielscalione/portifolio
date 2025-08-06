USE PlataformaCursos
GO


CREATE LOGIN usuario_curso WITH PASSWORD = 'SenhaForte123!';
CREATE USER usuario_curso FOR LOGIN usuario_curso;
GRANT SELECT, INSERT, UPDATE ON Aluno TO usuario_curso;

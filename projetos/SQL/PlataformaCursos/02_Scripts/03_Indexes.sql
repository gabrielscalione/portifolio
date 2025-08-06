USE PlataformaCursos
GO

CREATE INDEX IDX_Aluno_Email ON Aluno(Email);
CREATE INDEX IDX_Curso_Nome ON Curso(Nome);
CREATE INDEX IDX_Matricula_Status ON Matricula(Status);
CREATE INDEX IDX_Pagamento_Data ON Pagamento(DataPagamento);

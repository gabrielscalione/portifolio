USE PlataformaCursos
GO


INSERT INTO Instrutor (Nome, Especialidade) VALUES
('Carlos Silva', 'Banco de Dados'),
('Ana Souza', 'Programação');

INSERT INTO Aluno (Nome, Email) VALUES
('João Pereira', 'joao@email.com'),
('Maria Oliveira', 'maria@email.com');

INSERT INTO Curso (Nome, Descricao, Valor, ID_Instrutor) VALUES
('SQL Server Avançado', 'Curso completo de SQL Server', 499.90, 1),
('Python para Data Science', 'Introdução à análise de dados', 399.90, 2);

INSERT INTO Matricula (ID_Aluno, ID_Curso, Status) VALUES
(1, 1, 'Ativa'),
(2, 2, 'Ativa');

INSERT INTO Pagamento (ID_Matricula, Valor, FormaPagamento) VALUES
(1, 499.90, 'Cartão de Crédito'),
(2, 399.90, 'PIX');

USE PlataformaCursos
GO


INSERT INTO Instrutor (Nome, Especialidade) VALUES
('Carlos Silva', 'Banco de Dados'),
('Ana Souza', 'Programa��o');

INSERT INTO Aluno (Nome, Email) VALUES
('Jo�o Pereira', 'joao@email.com'),
('Maria Oliveira', 'maria@email.com');

INSERT INTO Curso (Nome, Descricao, Valor, ID_Instrutor) VALUES
('SQL Server Avan�ado', 'Curso completo de SQL Server', 499.90, 1),
('Python para Data Science', 'Introdu��o � an�lise de dados', 399.90, 2);

INSERT INTO Matricula (ID_Aluno, ID_Curso, Status) VALUES
(1, 1, 'Ativa'),
(2, 2, 'Ativa');

INSERT INTO Pagamento (ID_Matricula, Valor, FormaPagamento) VALUES
(1, 499.90, 'Cart�o de Cr�dito'),
(2, 399.90, 'PIX');

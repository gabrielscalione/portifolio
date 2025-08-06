USE PlataformaCursos
GO

CREATE TABLE Aluno (
    ID_Aluno INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DataCadastro DATETIME DEFAULT GETDATE()
);

CREATE TABLE Instrutor (
    ID_Instrutor INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Especialidade VARCHAR(100)
);

CREATE TABLE Curso (
    ID_Curso INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255),
    Valor DECIMAL(10,2) CHECK (Valor >= 0),
    ID_Instrutor INT NOT NULL,
    FOREIGN KEY (ID_Instrutor) REFERENCES Instrutor(ID_Instrutor)
);

CREATE TABLE Matricula (
    ID_Matricula INT IDENTITY(1,1) PRIMARY KEY,
    ID_Aluno INT NOT NULL,
    ID_Curso INT NOT NULL,
    DataMatricula DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) CHECK (Status IN ('Ativa', 'Cancelada', 'Concluída')),
    FOREIGN KEY (ID_Aluno) REFERENCES Aluno(ID_Aluno),
    FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso)
);

CREATE TABLE Pagamento (
    ID_Pagamento INT IDENTITY(1,1) PRIMARY KEY,
    ID_Matricula INT NOT NULL,
    Valor DECIMAL(10,2) CHECK (Valor > 0),
    DataPagamento DATETIME DEFAULT GETDATE(),
    FormaPagamento VARCHAR(50),
    FOREIGN KEY (ID_Matricula) REFERENCES Matricula(ID_Matricula)
);

CREATE TABLE Avaliacao (
    ID_Avaliacao INT IDENTITY(1,1) PRIMARY KEY,
    ID_Curso INT NOT NULL,
    ID_Aluno INT NOT NULL,
    Nota INT CHECK (Nota BETWEEN 1 AND 5),
    Comentario VARCHAR(255),
    DataAvaliacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso),
    FOREIGN KEY (ID_Aluno) REFERENCES Aluno(ID_Aluno)
);

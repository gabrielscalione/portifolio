# Modelo Lógico do Sistema Plataforma de Cursos

## Entidades e Relacionamentos

- **Aluno**
  - ID_Aluno (PK)
  - Nome
  - Email
  - DataCadastro

- **Instrutor**
  - ID_Instrutor (PK)
  - Nome
  - Especialidade

- **Curso**
  - ID_Curso (PK)
  - Nome
  - Descricao
  - Valor
  - ID_Instrutor (FK)

- **Matricula**
  - ID_Matricula (PK)
  - ID_Aluno (FK)
  - ID_Curso (FK)
  - DataMatricula
  - Status

- **Pagamento**
  - ID_Pagamento (PK)
  - ID_Matricula (FK)
  - Valor
  - DataPagamento
  - FormaPagamento

- **Avaliacao**
  - ID_Avaliacao (PK)
  - ID_Curso (FK)
  - ID_Aluno (FK)
  - Nota
  - Comentario
  - DataAvaliacao
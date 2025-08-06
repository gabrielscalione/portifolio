USE PlataformaCursos
GO

CREATE TABLE UsuarioSistema (
    ID INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(100) UNIQUE NOT NULL,
    SenhaHash VARBINARY(64) NOT NULL,
    DataCadastro DATETIME DEFAULT GETDATE()
);

INSERT INTO UsuarioSistema (Nome, SenhaHash)
VALUES ('admin', HASHBYTES('SHA2_256', 'SenhaForte123!'));

DECLARE @LoginNome VARCHAR(100) = 'admin';
DECLARE @LoginSenha VARCHAR(100) = 'SenhaForte123!';

SELECT CASE WHEN COUNT(*) > 0 THEN 'Login OK' ELSE 'Login Falhou' END AS Resultado
FROM UsuarioSistema
WHERE Nome = @LoginNome
AND SenhaHash = HASHBYTES('SHA2_256', @LoginSenha);

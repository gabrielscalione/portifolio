# Projeto: Exportação de Planilhas Google Sheets para Excel (.xlsx)

## 📄 Objetivo
Permitir que o usuário acesse diretamente planilhas armazenadas no Google Drive, selecione uma delas com base em parte do nome, e exporte como um arquivo `.xlsx`, autentificando via OAuth 2.0.

---

## 🔐 Autenticação

1. Acesse [Google Cloud Console](https://console.cloud.google.com)
2. Crie um novo projeto ou selecione um existente
3. Ative a **Google Drive API**
4. Em **APIs e serviços > Tela de consentimento OAuth**:
   - Tipo: **Interno** (uso pessoal) ou **Externo** (teste com outros)
   - Adicione o email de teste (ex: seu próprio email)
5. Em **APIs e serviços > Credenciais > Criar credenciais**:
   - Escolha **ID do cliente OAuth**
   - Tipo de aplicativo: **Aplicativo de área de trabalho**
   - Baixe o arquivo `credentials.json`

Coloque `credentials.json` na mesma pasta do script Python.

---

## 📁 Funcionalidades

### 1. Autenticar com o Google Drive
Utiliza `google-auth-oauthlib` e `google-api-python-client` para login seguro.

```python
flow = InstalledAppFlow.from_client_secrets_file('credentials.json', SCOPES)
creds = flow.run_local_server(port=0)
```

### 2. Buscar arquivos por nome
Procura planilhas por parte do nome:

```python
q = f"name contains '{parte_do_nome}' and mimeType='application/vnd.google-apps.spreadsheet'"
```

### 3. (Opcional) Filtrar por pasta
Pode-se limitar a busca a uma pasta específica:

```python
q = f"name contains '{parte}' and '{pasta_id}' in parents and mimeType='application/vnd.google-apps.spreadsheet'"
```

### 4. Selecionar e exportar planilha
Lista os arquivos encontrados e permite seleção interativa. Em seguida, exporta o Google Sheet como `.xlsx`:

```python
service.files().export(fileId=file_id,
                       mimeType='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
```

---

## 💾 Exemplo de uso

```python
parte_do_nome = "horas"
# pasta_id = "1a2b3c4d..."  # opcional
arquivos = buscar_arquivos_por_nome(service, parte_do_nome)
file_id = escolher_arquivo(arquivos)
exportar_para_excel(service, file_id, destino="C:/temp/planilha.xlsx")
```

---

## 🗓 Requisitos

- Python 3.10+
- Bibliotecas:
  ```bash
  pip install --upgrade google-api-python-client google-auth google-auth-oauthlib
  ```

---

## 🚫 Observações
- O script acessa apenas arquivos aos quais o usuário autenticado tem permissão de leitura.
- Certifique-se de que o e-mail usado está listado como "usuário de teste" se o app estiver em modo de testes.
- O arquivo `.gsheet` do Google Drive instalado localmente é apenas um atalho e **não pode ser lido diretamente**.

---

## 🚀 Expansões futuras
- Automatizar exportação de múltiplos arquivos
- Agendamento com `cron` ou `task scheduler`
- Interface gráfica com Tkinter ou WebApp com Streamlit

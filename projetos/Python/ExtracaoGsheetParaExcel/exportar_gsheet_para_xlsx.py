import os
import io
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload

# Escopo para leitura de arquivos do Drive
SCOPES = ['https://www.googleapis.com/auth/drive.readonly']

def autenticar():
    """Autentica o usuário via OAuth2"""
    creds = None
    if os.path.exists('token.json'):
        creds = Credentials.from_authorized_user_file('token.json', SCOPES)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            print("🔐 Autenticando...")
            flow = InstalledAppFlow.from_client_secrets_file('credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open('token.json', 'w') as token:
            token.write(creds.to_json())
    return creds

def buscar_arquivos_por_nome(service, nome_parcial, pasta_id=None):
    """Busca arquivos que contenham o nome parcial e sejam do tipo planilha"""
    q = f"name contains '{nome_parcial}' and mimeType='application/vnd.google-apps.spreadsheet'"
    if pasta_id:
        q += f" and '{pasta_id}' in parents"
    resultados = service.files().list(q=q,
                                      spaces='drive',
                                      fields='files(id, name)',
                                      pageSize=10).execute()
    arquivos = resultados.get('files', [])
    return arquivos

def escolher_arquivo(arquivos):
    """Exibe lista de arquivos encontrados e permite escolher um"""
    if not arquivos:
        print("❌ Nenhum arquivo encontrado.")
        return None
    print("\n📋 Arquivos encontrados:")
    for idx, arq in enumerate(arquivos):
        print(f"{idx + 1}: {arq['name']}")
    escolha = int(input("Digite o número do arquivo desejado: ")) - 1
    return arquivos[escolha]['id'] if 0 <= escolha < len(arquivos) else None

def exportar_para_excel(service, file_id, destino):
    """Exporta o arquivo Google Sheets para .xlsx"""
    request = service.files().export(fileId=file_id,
                                     mimeType='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    fh = io.FileIO(destino, 'wb')
    downloader = MediaIoBaseDownload(fh, request)
    done = False
    while not done:
        status, done = downloader.next_chunk()
        print(f"⬇️ Download {int(status.progress() * 100)}%")
    print(f"✅ Planilha exportada para: {destino}")

# -------------------------------
# EXECUÇÃO PRINCIPAL
# -------------------------------

if __name__ == '__main__':
    parte_do_nome = input("🔍 Parte do nome da planilha: ")
    destino = input("💾 Caminho de destino para salvar o .xlsx (ex: C:/temp/arquivo.xlsx): ")

    creds = autenticar()
    service = build('drive', 'v3', credentials=creds)

    arquivos = buscar_arquivos_por_nome(service, parte_do_nome)
    file_id = escolher_arquivo(arquivos)
    if file_id:
        exportar_para_excel(service, file_id, destino)

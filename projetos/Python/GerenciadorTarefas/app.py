from flask import Flask, render_template, request, jsonify, send_file
import sqlite3
import pandas as pd
import datetime
from flask_mail import Mail
from flask_mail import Message


app = Flask(__name__)
DATABASE = 'atividades.db'

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USERNAME'] = 'email@email.com'
app.config['MAIL_PASSWORD'] = '123412341234'
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False

mail = Mail(app)

def criar_tabela():
    with sqlite3.connect(DATABASE) as connection:
        cursor = connection.cursor()
        cursor.execute('''CREATE TABLE IF NOT EXISTS atividades (
                            id INTEGER PRIMARY KEY,
                            data DATE,
                            hora_inicial TIME,
                            hora_final TIME,
                            horas_gastas TEXT,
                            tipo_atividade TEXT,
                            solicitante TEXT,
                            descricao TEXT
                          )''')

def adicionar_atividade(data, hora_inicial, hora_final, tipo_atividade, solicitante, descricao):
    # Calcular horas gastas
    hora_inicial_obj = datetime.datetime.strptime(hora_inicial, '%H:%M')
    hora_final_obj = datetime.datetime.strptime(hora_final, '%H:%M')
    horas_gastas = str(hora_final_obj - hora_inicial_obj)
    with sqlite3.connect(DATABASE) as connection:
        cursor = connection.cursor()
        cursor.execute('''INSERT INTO atividades (data, hora_inicial, hora_final, horas_gastas, tipo_atividade, solicitante, descricao)
                          VALUES (?, ?, ?, ?, ?, ?, ?)''', (data, hora_inicial, hora_final, horas_gastas, tipo_atividade, solicitante, descricao))
        connection.commit()

def obter_atividades():
    with sqlite3.connect(DATABASE) as connection:
        cursor = connection.cursor()
        cursor.execute('''SELECT * FROM atividades''')
        atividades = cursor.fetchall()
        
        # Formatando os dados das atividades
        atividades_formatadas = []
        for atividade in atividades:
            atividade_formatada = {
                'id': atividade[0],
                'data': atividade[1],
                'hora_inicial': atividade[2],
                'hora_final': atividade[3],
                'horas_gastas': atividade[4],
                'tipo_atividade': atividade[5],
                'solicitante': atividade[6],
                'descricao': atividade[7]
            }
            atividades_formatadas.append(atividade_formatada)
        
        return atividades_formatadas


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/atividades', methods=['GET'])
def get_atividades():
    atividades = obter_atividades()
    return jsonify({'atividades': atividades})

@app.route('/atividades', methods=['POST'])
def add_atividade():
    data = request.json['data']
    hora_inicial = request.json['hora_inicial']
    hora_final = request.json['hora_final']
    tipo_atividade = request.json['tipo_atividade']
    solicitante = request.json['solicitante']
    descricao = request.json['descricao']
    adicionar_atividade(data, hora_inicial, hora_final, tipo_atividade, solicitante, descricao)
    return jsonify({'message': 'Atividade criada com sucesso!'})

@app.route('/exportar-excel', methods=['GET'])
def exportar_excel():
    # Obter os dados do banco de dados
    df = pd.read_sql_query("SELECT * FROM atividades", sqlite3.connect(DATABASE))
    
    # Salvar os dados em um arquivo Excel
    nome_arquivo = 'atividades.xlsx'
    df.to_excel(nome_arquivo, index=False)
    
    # Enviar o arquivo Excel como uma resposta
    return send_file(nome_arquivo, as_attachment=True)

@app.route('/limpar-tabela', methods=['POST'])
def limpar_tabela():
    with sqlite3.connect(DATABASE) as connection:
        cursor = connection.cursor()
        cursor.execute("DELETE FROM atividades")
        connection.commit()
    return jsonify({'message': 'Tabela limpa com sucesso!'})

@app.route('/enviar-email')
def enviar_email():
    # Gerar o arquivo Excel com os dados mais recentes
    df = pd.read_sql_query("SELECT * FROM atividades", sqlite3.connect(DATABASE))
    nome_arquivo = 'atividades.xlsx'
    df.to_excel(nome_arquivo, index=False)
    
    # Configurar e enviar o e-mail com o arquivo anexado
    msg = Message('Relatório de Atividades', sender='scalione@gmail.com', recipients=['scalione@gmail.com'])
    msg.body = 'Anexo de relatório de atividades em formato Excel.'
    with app.open_resource(nome_arquivo) as fp:
        msg.attach(nome_arquivo, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fp.read())
    mail.send(msg)
    
    # Retornar uma resposta em formato JSON para ser manipulada pelo JavaScript no cliente
    return jsonify({'message': 'E-mail enviado com sucesso!'})



if __name__ == '__main__':
    criar_tabela()
    app.run(debug=True)

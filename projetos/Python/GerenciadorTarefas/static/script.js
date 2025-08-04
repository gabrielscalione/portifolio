document.getElementById('atividade-form').addEventListener('submit', function(event) {
    event.preventDefault();
    var data = document.getElementById('data').value;
    var horaInicial = document.getElementById('hora-inicial').value;
    var horaFinal = document.getElementById('hora-final').value;
    var tipoAtividade = document.getElementById('tipo-atividade').value;
    var solicitante = document.getElementById('solicitante').value;
    var descricao = document.getElementById('descricao').value;

    var formData = {
        'data': data,
        'hora_inicial': horaInicial,
        'hora_final': horaFinal,
        'tipo_atividade': tipoAtividade,
        'solicitante': solicitante,
        'descricao': descricao
    };

    fetch('/atividades', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('message').innerText = data.message;
        document.getElementById('atividade-form').reset();
        fetchAndDisplayAtividades();
    });
});

function fetchAndDisplayAtividades() {
    fetch('/atividades')
    .then(response => response.json())
    .then(data => {
        var atividadesList = document.getElementById('atividades-list');
        atividadesList.innerHTML = '';
        data.atividades.forEach(atividade => {
            var row = `<tr>
                            <td>${atividade.data}</td>
                            <td>${atividade.hora_inicial}</td>
                            <td>${atividade.hora_final}</td>
                            <td>${atividade.horas_gastas}</td>
                            <td>${atividade.tipo_atividade}</td>
                            <td>${atividade.solicitante}</td>
                            <td>${atividade.descricao}</td>
                       </tr>`;
            atividadesList.innerHTML += row;
        });
    });
}

// Carrega as atividades ao carregar a página
fetchAndDisplayAtividades();


document.getElementById('limpar-tabela').addEventListener('click', function() {
    fetch('/limpar-tabela', {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('message').innerText = data.message;
        fetchAndDisplayAtividades();
    });
});

document.getElementById('enviar-email-btn').addEventListener('click', function() {
    fetch('/enviar-email')
    .then(response => response.json())
    .then(data => {
        alert(data.message);
    });
});
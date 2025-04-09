document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('consultoriaForm');
    const generateReportBtn = document.getElementById('generateReportBtn');
    const reportSection = document.getElementById('reportSection');
    const reportContent = document.getElementById('reportContent');

    // Envio do formulário para salvar os dados
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(form);

        fetch('/admin/consultoria/saveClient', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.success);
                form.reset();
            } else {
                alert(data.error || 'Erro ao salvar os dados.');
            }
        })
        .catch(error => {
            console.error('Erro ao salvar os dados:', error);
            alert('Erro ao salvar os dados.');
        });
    });

    // Geração do relatório
    generateReportBtn.addEventListener('click', function() {
        const formData = new FormData(form);

        fetch('/admin/consultoria/generateReport', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                reportSection.style.display = 'block';
                reportContent.textContent = data.recomendacoes;
            } else {
                alert(data.error || 'Erro ao gerar o relatório.');
            }
        })
        .catch(error => {
            console.error('Erro ao gerar o relatório:', error);
            alert('Erro ao gerar o relatório.');
        });
    });
});
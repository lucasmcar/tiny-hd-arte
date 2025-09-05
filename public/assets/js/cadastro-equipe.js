(function () {
    // Função para executar quando o DOM estiver pronto
    function ready(fn) {
        if (document.readyState === 'complete' || document.readyState === 'interactive') {
            setTimeout(fn, 0); // Garante execução assíncrona
        } else {
            document.addEventListener('DOMContentLoaded', fn);
        }
    }

    ready(function () {

        const pessoaForm = document.getElementById('pessoaForm');
        const successMessage = document.getElementById('successMessage');
        const cardHeaders = document.querySelectorAll('.card-header');

        cardHeaders.forEach(header => {
            const targetId = header.getAttribute('data-target');
            const cardContent = document.getElementById(targetId);
            const toggleButton = header.querySelector('.toggle-button');
            const chevronDown = toggleButton.querySelector('.bi-chevron-down');
            const chevronUp = toggleButton.querySelector('.bi-chevron-up');

            if (!cardContent) {
                console.error(`Conteúdo do card #${targetId} não encontrado em`, new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' }));
                return;
            }

            header.addEventListener('click', function (e) {
                e.stopPropagation();
                e.stopImmediatePropagation();
                const isOpen = cardContent.style.display === 'block';

                document.querySelectorAll('.card-content').forEach(otherContent => {
                    if (otherContent !== cardContent && otherContent.style.display === 'block') {
                        otherContent.style.display = 'none';
                        const otherHeader = otherContent.previousElementSibling;
                        otherHeader.querySelector('.bi-chevron-up').style.display = 'none';
                        otherHeader.querySelector('.bi-chevron-down').style.display = 'inline';
                        otherHeader.setAttribute('data-expanded', 'false');
                    }
                });

                if (isOpen) {
                    cardContent.style.display = 'none';
                    chevronUp.style.display = 'none';
                    chevronDown.style.display = 'inline';
                    header.setAttribute('data-expanded', 'false');
                    
                } else {
                    cardContent.style.display = 'block';
                    chevronDown.style.display = 'none';
                    chevronUp.style.display = 'inline';
                    header.setAttribute('data-expanded', 'true');
                }
            });
        });

        if (pessoaForm) {
            pessoaForm.addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new FormData(pessoaForm);
                const csrfToken = document.querySelector('input[name="_csrf_token"]').value;

                fetch('/admin/equipe/salvar', {
                    method: 'POST',
                    body: formData,
                    headers: {
                        'X-CSRF-Token': csrfToken
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        successMessage.textContent = data.success;
                        successMessage.style.display = 'block';
                        pessoaForm.reset();
                        setTimeout(() => {
                            successMessage.style.display = 'none';
                        }, 3000);
                    } else {
                        alert(data.error || 'Erro ao cadastrar pessoa.');
                    }
                })
                .catch(error => {
                    console.error('Erro:', error);
                    alert('Erro ao cadastrar pessoa.');
                });
            });
        } else {
            console.error('Formulário pessoaForm não encontrado em', new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' }));
        }
    });
})();
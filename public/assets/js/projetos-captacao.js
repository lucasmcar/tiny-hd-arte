$(document).ready(function () {
    

    const $projectForm = $('#projectForm');
    const $successMessage = $('#successMessage');
    const $cardHeaders = $('.card-header');

    if ($cardHeaders.length === 0) {
        console.error('Nenhum .card-header encontrado');
    } else {
        
    }

    $cardHeaders.each(function () {
        const $header = $(this);
        const targetId = $header.data('target');
        const $cardContent = $('#' + targetId);
        const $dashboardCard = $header.closest('.dashboard-card'); // Isolamos o card pai
        const $toggleButton = $header.find('.toggle-button');
        const $chevronDown = $toggleButton.find('.bi-chevron-down');
        const $chevronUp = $toggleButton.find('.bi-chevron-up');

        if (!$cardContent.length) {
            console.error(`Conteúdo do card #${targetId} não encontrado`);
            return;
        }

   

        $header.on('click', function (e) {
            e.stopPropagation();
            e.stopImmediatePropagation(); // Garante que o evento não afete outros elementos
           

            // Verifica se o conteúdo está visível apenas neste card
            const isOpen = $cardContent.is(':visible');
            $('.card-content').not($cardContent).slideUp(300); // Fecha outros cards
            $cardContent.slideToggle(300, function () {
                $chevronDown.toggle();
                $chevronUp.toggle();
            });

            // Impede que outros cards sejam afetados
            return false;
        });
    });

    if ($projectForm.length) {
        $projectForm.on('submit', function (e) {
            e.preventDefault();
            const formData = new FormData($projectForm[0]);
            const csrfToken = $('input[name="_csrf_token"]').val();

            $.ajax({
                url: '/admin/projetos-captacao/salvar',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                headers: {
                    'X-CSRF-Token': csrfToken
                },
                success: function (data) {
                    if (data.success) {
                        $successMessage.text(data.success).show();
                        $projectForm[0].reset();
                        setTimeout(() => {
                            $successMessage.hide();
                        }, 3000);
                    } else {
                        alert(data.error || 'Erro ao cadastrar projeto.');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Erro:', error);
                    alert('Erro ao cadastrar projeto.');
                }
            });
        });
    } else {
        console.error('Formulário projectForm não encontrado');
    }
});
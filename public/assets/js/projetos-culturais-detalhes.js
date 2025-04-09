document.addEventListener('DOMContentLoaded', function() {
    // Formulário de Status
    const statusForm = document.getElementById('statusForm');
    const statusMessage = document.getElementById('statusMessage');

    if (statusForm) {
        statusForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(statusForm);

            fetch('/admin/projetos-culturais/updateProjectStatus', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    statusMessage.textContent = data.success;
                    statusMessage.style.display = 'block';
                    setTimeout(() => {
                        statusMessage.style.display = 'none';
                        location.reload(); // Recarrega a página para atualizar o status
                    }, 2000);
                } else {
                    statusMessage.textContent = data.error || 'Erro ao atualizar o status.';
                    statusMessage.style.display = 'block';
                    setTimeout(() => {
                        statusMessage.style.display = 'none';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Erro ao atualizar o status:', error);
                statusMessage.textContent = 'Erro ao atualizar o status.';
                statusMessage.style.display = 'block';
                setTimeout(() => {
                    statusMessage.style.display = 'none';
                }, 2000);
            });
        });
    }

    // Formulário de Planejamento
    const planningForm = document.getElementById('planningForm');
    const planningEntries = document.getElementById('planningEntries');
    const addPlanningEntry = document.getElementById('addPlanningEntry');
    const planningMessage = document.getElementById('planningMessage');

    if (addPlanningEntry) {
        addPlanningEntry.addEventListener('click', function() {
            const entry = document.createElement('div');
            entry.classList.add('planning-entry');
            entry.innerHTML = `
                <div class="form-group">
                    <label>Etapa</label>
                    <input type="text" name="etapas[]" class="form-input" required>
                </div>
                <div class="form-group">
                    <label>Responsável</label>
                    <input type="text" name="responsaveis[]" class="form-input" required>
                </div>
                <div class="form-group">
                    <label>Prazo</label>
                    <input type="date" name="prazos[]" class="form-input" required>
                </div>
            `;
            planningEntries.appendChild(entry);
        });
    }

    if (planningForm) {
        planningForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(planningForm);

            fetch('/admin/projetos-culturais/savePlanejamento', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    planningMessage.textContent = data.success;
                    planningMessage.style.display = 'block';
                    setTimeout(() => {
                        planningMessage.style.display = 'none';
                        location.reload();
                    }, 2000);
                } else {
                    planningMessage.textContent = data.error || 'Erro ao salvar o planejamento.';
                    planningMessage.style.display = 'block';
                    setTimeout(() => {
                        planningMessage.style.display = 'none';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar o planejamento:', error);
                planningMessage.textContent = 'Erro ao salvar o planejamento.';
                planningMessage.style.display = 'block';
                setTimeout(() => {
                    planningMessage.style.display = 'none';
                }, 2000);
            });
        });
    }

    // Formulário de Incentivo
    const incentivoForm = document.getElementById('incentivoForm');
    const incentivoMessage = document.getElementById('incentivoMessage');

    if (incentivoForm) {
        incentivoForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(incentivoForm);

            fetch('/admin/projetos-culturais/saveIncentivo', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    incentivoMessage.textContent = data.success;
                    incentivoMessage.style.display = 'block';
                    setTimeout(() => {
                        incentivoMessage.style.display = 'none';
                        location.reload();
                    }, 2000);
                } else {
                    incentivoMessage.textContent = data.error || 'Erro ao salvar os dados de incentivo.';
                    incentivoMessage.style.display = 'block';
                    setTimeout(() => {
                        incentivoMessage.style.display = 'none';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar os dados de incentivo:', error);
                incentivoMessage.textContent = 'Erro ao salvar os dados de incentivo.';
                incentivoMessage.style.display = 'block';
                setTimeout(() => {
                    incentivoMessage.style.display = 'none';
                }, 2000);
            });
        });
    }

    // Formulário de Resultados
    const resultadosForm = document.getElementById('resultadosForm');
    const resultadosMessage = document.getElementById('resultadosMessage');

    if (resultadosForm) {
        resultadosForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(resultadosForm);

            fetch('/admin/projetos-culturais/saveResultados', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resultadosMessage.textContent = data.success;
                    resultadosMessage.style.display = 'block';
                    setTimeout(() => {
                        resultadosMessage.style.display = 'none';
                        location.reload();
                    }, 2000);
                } else {
                    resultadosMessage.textContent = data.error || 'Erro ao salvar os resultados.';
                    resultadosMessage.style.display = 'block';
                    setTimeout(() => {
                        resultadosMessage.style.display = 'none';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar os resultados:', error);
                resultadosMessage.textContent = 'Erro ao salvar os resultados.';
                resultadosMessage.style.display = 'block';
                setTimeout(() => {
                    resultadosMessage.style.display = 'none';
                }, 2000);
            });
        });
    }
});
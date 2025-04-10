document.addEventListener('DOMContentLoaded', function() {
    // Formulário de Tarefas
    const taskForm = document.getElementById('taskForm');
    const taskMessage = document.getElementById('taskMessage');

    if (taskForm) {
        taskForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(taskForm);

            fetch('/admin/eventos-culturais/saveTarefa', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    taskMessage.textContent = data.success;
                    taskMessage.style.display = 'block';
                    setTimeout(() => {
                        taskMessage.style.display = 'none';
                        location.reload();
                    }, 2000);
                } else {
                    taskMessage.textContent = data.error || 'Erro ao salvar a tarefa.';
                    taskMessage.style.display = 'block';
                    setTimeout(() => {
                        taskMessage.style.display = 'none';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar a tarefa:', error);
                taskMessage.textContent = 'Erro ao salvar a tarefa.';
                taskMessage.style.display = 'block';
                setTimeout(() => {
                    taskMessage.style.display = 'none';
                }, 2000);
            });
        });
    }

    // Formulário de Checklist
    const checklistForm = document.getElementById('checklistForm');
    const checklistEntries = document.getElementById('checklistEntries');
    const addChecklistEntry = document.getElementById('addChecklistEntry');
    const checklistMessage = document.getElementById('checklistMessage');

    if (addChecklistEntry) {
        addChecklistEntry.addEventListener('click', function() {
            const entryCount = checklistEntries.children.length;
            const entry = document.createElement('div');
            entry.classList.add('checklist-entry');
            entry.innerHTML = `
                <input type="text" name="itens[]" class="form-input" placeholder="Item do checklist" required>
                <label class="checkbox-label">
                    <input type="checkbox" name="status[${entryCount}]">
                    Concluído
                </label>
            `;
            checklistEntries.appendChild(entry);
        });
    }

    if (checklistForm) {
        checklistForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(checklistForm);

            fetch('/admin/eventos-culturais/saveChecklist', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    checklistMessage.textContent = data.success;
                    checklistMessage.style.display = 'block';
                    setTimeout(() => {
                        checklistMessage.style.display = 'none';
                        location.reload();
                    }, 2000);
                } else {
                    checklistMessage.textContent = data.error || 'Erro ao salvar o checklist.';
                    checklistMessage.style.display = 'block';
                    setTimeout(() => {
                        checklistMessage.style.display = 'none';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar o checklist:', error);
                checklistMessage.textContent = 'Erro ao salvar o checklist.';
                checklistMessage.style.display = 'block';
                setTimeout(() => {
                    checklistMessage.style.display = 'none';
                }, 2000);
            });
        });
    }

    // Formulário de Finanças
    const financasForm = document.getElementById('financasForm');
    const financasMessage = document.getElementById('financasMessage');

    if (financasForm) {
        financasForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(financasForm);

            fetch('/admin/eventos-culturais/saveFinancas', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    financasMessage.textContent = data.success;
                    financasMessage.style.display = 'block';
                    setTimeout(() => {
                        financasMessage.style.display = 'none';
                        location.reload();
                    }, 2000);
                } else {
                    financasMessage.textContent = data.error || 'Erro ao salvar as finanças.';
                    financasMessage.style.display = 'block';
                    setTimeout(() => {
                        financasMessage.style.display = 'none';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar as finanças:', error);
                financasMessage.textContent = 'Erro ao salvar as finanças.';
                financasMessage.style.display = 'block';
                setTimeout(() => {
                    financasMessage.style.display = 'none';
                }, 2000);
            });
        });
    }
});
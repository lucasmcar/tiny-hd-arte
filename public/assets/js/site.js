console.log('Script site.min.js carregado com sucesso!');

function initializeSiteConfig() {
    const highlightImages = document.getElementById('highlightImages');
    const testimonialsList = document.getElementById('testimonialsList');
    const addHighlightImage = document.getElementById('addHighlightImage');
    const saveSiteConfig = document.getElementById('saveSiteConfig');
    const showTestimonials = document.querySelectorAll('input[name="showTestimonials"]');
    const testimonialsSection = document.getElementById('testimonialsSection');

    // Limites máximos
    const MAX_HIGHLIGHTS = 5;
    const MAX_TESTIMONIALS = 3;

    // Captura o token CSRF
    const csrfToken = document.querySelector('input[name="_csrf_token"]')?.value;
    if (!csrfToken) {
        console.error('Token CSRF não encontrado. Verifique o HTML.');
    }

    // Carregar Imagens Existentes (Thumbnails)
    fetch('/admin/site/getHighlights', {
        method: 'GET',
        headers: {
            'X-CSRF-TOKEN': csrfToken,
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success && data.highlights) {
            highlightImages.innerHTML = '';
            data.highlights.forEach(highlight => {
                const imageItem = document.createElement('div');
                imageItem.className = 'thumbnail-container col-md-3';
                imageItem.dataset.id = highlight.id;
                imageItem.innerHTML = `
                    <img src="/assets/imgs/uploads/${highlight.image_url}" class="thumbnail-img" alt="Thumbnail">
                    <div class="thumbnail-details">
                        <input type="text" class="form-control thumbnail-input" placeholder="Texto do Overlay" value="${highlight.overlay_text}" data-type="overlay">
                        <input type="number" class="form-control thumbnail-input" placeholder="Ordem (1-5)" value="${highlight.display_order}" min="1" max="5" data-type="order">
                        <button class="remove-btn btn btn-danger">Remover</button>
                    </div>
                `;
                highlightImages.appendChild(imageItem);
            });
        }
    })
    .catch(error => console.error('Erro ao carregar highlights:', error));

    // Adicionar Imagem de Destaque
    addHighlightImage.addEventListener('click', () => {
        const currentHighlights = highlightImages.querySelectorAll('.thumbnail-container').length;
        if (currentHighlights >= MAX_HIGHLIGHTS) {
            alert(`Você atingiu o limite máximo de ${MAX_HIGHLIGHTS} imagens de destaque.`);
            return;
        }

        const id = Date.now();
        const imageItem = document.createElement('div');
        imageItem.className = 'thumbnail-container col-md-3';
        imageItem.dataset.id = id;
        imageItem.innerHTML = `
            <input type="file" class="form-control thumbnail-input" data-type="image">
            <div class="thumbnail-details">
                <input type="text" class="form-control thumbnail-input" placeholder="Texto do Overlay" data-type="overlay">
                <input type="number" class="form-control thumbnail-input" placeholder="Ordem (1-5)" min="1" max="5" data-type="order">
                <button class="remove-btn btn btn-danger">Remover</button>
            </div>
        `;
        highlightImages.appendChild(imageItem);
    });

    // Mostrar/Ocultar Seção de Depoimentos
    showTestimonials.forEach(input => {
        input.addEventListener('change', () => {
            testimonialsSection.style.display = input.value === 'yes' ? 'block' : 'none';
        });
    });

    // Carregar Depoimentos Aprovados
    fetch('/admin/site/getApprovedTestimonials', {
        method: 'GET',
        headers: {
            'X-CSRF-TOKEN': csrfToken,
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success && data.testimonials) {
            testimonialsList.innerHTML = '';
            data.testimonials.forEach(testimonial => {
                const testimonialItem = document.createElement('div');
                testimonialItem.className = 'testimonial-item';
                testimonialItem.innerHTML = `
                    <input type="checkbox" class="testimonial-checkbox" data-id="${testimonial.id}">
                    <label>${testimonial.titulo}: ${testimonial.depoimento}</label>
                `;
                testimonialsList.appendChild(testimonialItem);
            });

            testimonialsList.addEventListener('change', (e) => {
                if (e.target.classList.contains('testimonial-checkbox')) {
                    const selectedTestimonials = testimonialsList.querySelectorAll('.testimonial-checkbox:checked').length;
                    if (selectedTestimonials > MAX_TESTIMONIALS) {
                        alert(`Você pode selecionar no máximo ${MAX_TESTIMONIALS} depoimentos.`);
                        e.target.checked = false;
                    }
                }
            });
        } else {
            testimonialsList.innerHTML = '<p>Nenhum depoimento aprovado disponível.</p>';
        }
    })
    .catch(error => {
        console.error('Erro ao carregar depoimentos:', error);
        testimonialsList.innerHTML = '<p>Erro ao carregar depoimentos.</p>';
    });

    // Remover Imagens de Destaque
    highlightImages.addEventListener('click', (e) => {
        if (e.target.classList.contains('remove-btn')) {
            e.target.parentElement.parentElement.remove();
        }
    });

    // Salvar Configurações
    saveSiteConfig.addEventListener('click', () => {
        const configData = new FormData();
        configData.append('highlightTitle', document.getElementById('highlightTitle').value);
        configData.append('overlayColor', document.getElementById('overlayColor').value);
        configData.append('showTestimonials', document.querySelector('input[name="showTestimonials"]:checked').value === 'yes');

        const highlights = Array.from(highlightImages.children).map(item => {
            const inputs = item.querySelectorAll('.thumbnail-input');
            const fileInput = item.querySelector('input[type="file"]');
            const file = fileInput ? fileInput.files[0] : null;
            return {
                id: item.dataset.id,
                image: file,
                overlayText: inputs[1].value, // Ajustado para pegar o input correto
                order: parseInt(inputs[2].value) || 1 // Ajustado para pegar o input correto
            };
        }).filter(item => item.overlayText);

        highlights.forEach((highlight, index) => {
            if (highlight.image) {
                configData.append(`highlights[${index}][image]`, highlight.image);
            }
            configData.append(`highlights[${index}][id]`, highlight.id);
            configData.append(`highlights[${index}][overlayText]`, highlight.overlayText);
            configData.append(`highlights[${index}][order]`, highlight.order);
        });

        const testimonials = Array.from(testimonialsList.querySelectorAll('.testimonial-checkbox:checked')).map(checkbox => ({
            id: checkbox.dataset.id
        }));
        configData.append('testimonials', JSON.stringify(testimonials));

        // Validação dos limites antes de enviar
        if (highlights.length > MAX_HIGHLIGHTS) {
            alert(`Você excedeu o limite de ${MAX_HIGHLIGHTS} imagens de destaque. Remova algumas antes de salvar.`);
            return;
        }
        if (testimonials.length > MAX_TESTIMONIALS) {
            alert(`Você excedeu o limite de ${MAX_TESTIMONIALS} depoimentos. Desmarque alguns antes de salvar.`);
            return;
        }

        configData.append('_csrf_token', csrfToken);

        fetch('/admin/configuracoes/site/updateSite', {
            method: 'POST',
            headers: {
                'X-CSRF-TOKEN': csrfToken,
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: configData
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    throw new Error(`Erro HTTP ${response.status}: ${text}`);
                });
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                alert(data.message || 'Configurações salvas com sucesso!');
                location.reload();
            } else {
                alert(data.message || 'Erro ao salvar configurações.');
            }
        })
        .catch(error => {
            console.error('Erro detalhado:', error);
            alert('Erro na requisição. Verifique o console.');
        });

        console.log('Configurações salvas:', Object.fromEntries(configData));
    });
}

initializeSiteConfig();
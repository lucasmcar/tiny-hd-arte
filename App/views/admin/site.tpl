@csrf
<div class="container-fluid mt-4 site-config-section" aria-label="Seção de Configuração do Site">
    <div class="header-info" role="banner">
        <h1 class="hda-title">{{ $title }}</h1>
    </div>

    <div class="config-grid" role="main">
        <!-- Seção de Destaque -->
        <div class="config-section highlight-section" role="region" aria-labelledby="highlight-title">
            <h3 class="section-title" id="highlight-title">Imagens de Destaque</h3>
            <div class="form-group">
                <label for="highlightTitle" class="form-label">Título da Seção</label>
                <input type="text" class="form-control" id="highlightTitle" placeholder="Ex.: Em Alta" aria-required="true">
            </div>
            <div id="highlightImages" class="mt-3 row thumbnail-container" role="list" aria-live="polite">
                <!-- Imagens serão adicionadas dinamicamente -->
            </div>
            <button id="addHighlightImage" class="action-btn" aria-label="Adicionar nova imagem de destaque">Adicionar Imagem</button>
            <div class="form-group mt-3">
                <label for="overlayColor" class="form-label">Cor do Overlay</label>
                <input type="color" class="form-control" id="overlayColor" value="#ffffff" aria-label="Selecionar cor do overlay">
            </div>
        </div>

        <!-- Seção de Depoimentos -->
        <div class="config-section testimonials-section" role="region" aria-labelledby="testimonials-title">
            <h3 class="section-title" id="testimonials-title">Depoimentos</h3>
            <div class="form-group">
                <label class="form-label">Mostrar Depoimentos?</label>
                <div>
                    <input type="radio" name="showTestimonials" value="yes" id="showYes" aria-label="Sim"> <label for="showYes" class="radio-label">Sim</label>
                    <input type="radio" name="showTestimonials" value="no" id="showNo" checked aria-label="Não"> <label for="showNo" class="radio-label">Não</label>
                </div>
            </div>
            <div id="testimonialsSection" style="display: none;" role="region" aria-labelledby="testimonials-list-title">
                <h4 class="subsection-title" id="testimonials-list-title">Lista de Depoimentos</h4>
                <div id="testimonialsList" class="mt-3 list-container" role="list" aria-live="polite">
                    <!-- Depoimentos aprovados serão carregados dinamicamente -->
                </div>
            </div>
        </div>
    </div>

    <!-- Botão de Salvar -->
    <button id="saveSiteConfig" class="action-btn save-btn" aria-label="Salvar configurações do site">Salvar Configurações</button>
</div>
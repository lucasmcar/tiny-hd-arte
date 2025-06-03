@csrf
<div class="container-fluid mt-4">
    <h1 class="text-white">{{ $title }}</h1>

    <!-- Seção de Destaque -->
    <div class="card bg-dark text-white mb-4">
        <div class="card-header">Imagens de Destaque</div>
        <div class="card-body">
            <div class="form-group">
                <label for="highlightTitle">Título da Seção</label>
                <input type="text" class="form-control bg-dark text-white" id="highlightTitle" placeholder="Ex.: Em Alta">
            </div>
            <div id="highlightImages" class="mt-3 row">
                <!-- Imagens serão adicionadas dinamicamente ou carregadas como thumbnails -->
            </div>
            <button id="addHighlightImage" class="btn btn-primary mt-2">Adicionar Imagem</button>
            <div class="form-group mt-3">
                <label for="overlayColor">Cor do Overlay</label>
                <input type="color" class="form-control" id="overlayColor" value="#ffffff">
            </div>
        </div>
    </div>

    <!-- Seção de Depoimentos -->
    <div class="card bg-dark text-white">
        <div class="card-header">Depoimentos</div>
        <div class="card-body">
            <div class="form-group">
                <label>Mostrar Depoimentos?</label>
                <div>
                    <input type="radio" name="showTestimonials" value="yes" id="showYes"> <label for="showYes">Sim</label>
                    <input type="radio" name="showTestimonials" value="no" id="showNo" checked> <label for="showNo">Não</label>
                </div>
            </div>
            <div id="testimonialsSection" style="display: none;">
                <div id="testimonialsList" class="mt-3">
                    <!-- Depoimentos aprovados serão carregados dinamicamente -->
                </div>
            </div>
        </div>
    </div>

    <!-- Botão de Salvar -->
    <button id="saveSiteConfig" class="btn btn-success mt-4">Salvar Configurações</button>
</div>
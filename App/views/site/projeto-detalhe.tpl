@csrf
<div class="container-fluid mt-4 project-details-section" aria-label="Detalhes do Projeto">
    <div class="header-info" role="banner">
        <h1 class="hda-title">Detalhes do Projeto</h1>
    </div>

    <div class="config-grid" role="main">
        <!-- Informações Gerais -->
        <div class="config-section general-info-section" role="region" aria-labelledby="general-info-title">
            <h3 class="section-title" id="general-info-title">Informações Gerais</h3>
            <div class="form-group">
                <label class="form-label">PRONAC:</label>
                <span class="detail-text" id="pronac">{{ $project['pronac'] }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Nome do Projeto:</label>
                <span class="detail-text" id="project-name">{{ $project['title'] }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Proponente:</label>
                <span class="detail-text" id="proponente">{{ $project['proponente'] }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">UF:</label>
                <span class="detail-text" id="uf">{{ ($project['uf'] != null) ?  $project['uf'] : 'Não disponível' }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Mecanismo:</label>
                <span class="detail-text" id="mecanismo">Mecenato (Simulado)</span>
            </div>
            <div class="form-group">
                <label class="form-label">Área Cultural:</label>
                <span class="detail-text" id="area_cultural">{{ $project['description'] == 'Música' ? 'Música' : ($project['description'] == 'Hip Hop' ? 'Artes Cênicas' : 'Multicultural') }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Segmento:</label>
                <span class="detail-text" id="segmento">{{ $project['description'] == 'Hip Hop' ? 'Ações Educativo-Culturais' : ($project['description'] == 'Música' ? 'Apresentação Musical' : 'Eventos Culturais') }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Tipologia:</label>
                <span class="detail-text" id="tipologia">{{ $project['description'] == 'Festival' ? 'Festival' : 'Projeto Normal' }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Tipicidade:</label>
                <span class="detail-text" id="tipicidade">Não disponível</span>
            </div>
            <div class="form-group">
                <label class="form-label">Processo:</label>
                <span class="detail-text" id="processo">Não disponível</span>
            </div>
            <div class="form-group">
                <label class="form-label">Portaria de Autorização:</label>
                <span class="detail-text" id="portaria">{{ $project['post_date'] ? 'Nº  ~'. date('Y/m/d', strtotime($project['post_date'])) : 'Não disponível' }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Valor Autorizado para Captação:</label>
                <span class="detail-text" id="valor_captacao">Não disponível</span>
            </div>
            <div class="form-group">
                <label class="form-label">Período de Captação:</label>
                <span class="detail-text" id="periodo_captacao">{{ $project['periodo_captacao']. '~'.' ' .' ~' .$project['periodo_captacao'].' ~ '. ' a '. ' '. ' ~ ' . date('d/m/Y', strtotime($project['post_date'] . " +1 year")) }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Período de Execução:</label>
                <span class="detail-text" id="periodo_execucao">{{ $project['periodo_execucao'] }}</span>
            </div>
            <div class="form-group">
                <label class="form-label">Situação Atual:</label>
                <span class="detail-text" id="situacao">{{ $project['status'] == 'ongoing' ? 'Captação em andamento' : 'Captação autorizada' }}</span>
            </div>
        </div>

        <!-- Resumo e Detalhes Adicionais -->
        <div class="config-section summary-section" role="region" aria-labelledby="summary-title">
            <h3 class="section-title" id="summary-title">Resumo e Detalhes</h3>
            <div class="form-group">
                <label class="form-label">Resumo do Projeto:</label>
                <p class="detail-text" id="resumo">{{ $project['content'] }}</p>
            </div>
            <div class="form-group">
                <label class="form-label">Imagens Relacionadas:</label>
                <div class="image-gallery">
                    <img src="{{ $project['image'] }}" alt="{{ $project['title'] }} - Imagem Principal" class="thumbnail-img">
                    {% if $project['extra_image'] %}
                        <img src="{{ $project['extra_image'] }}" alt="{{ $project['title'] }} - Imagem Adicional" class="thumbnail-img">
                    {% endif; %}
                </div>
            </div>
            {% if isset($project['shows']) %}
                <div class="form-group">
                    <label class="form-label">Shows Confirmados:</label>
                    <div class="list-container">
                        {% foreach $project['shows'] as $index => $show %}
                            <div class="show-item">
                                <span>{{ $show['participants'] }}</span>
                                <img src="{{ $show }}" alt="{{ $show['title'] }}" class="thumbnail-img-small">
                            </div>
                        {% endforeach; %}
                    </div>
                </div>
            {% endif; %}
            {% if isset($project['attractions']) %}
                <div class="form-group">
                    <label class="form-label">Atrações e Artistas:</label>
                    <div class="list-container">
                        {% foreach $project['attractions'] as $index  => $attraction %}
                            <div class="attraction-item">
                                <h4>{{ $attraction['title'] }}</h4>
                                <p>{{ $attraction['description'] }}</p>
                                <img src="{{ $attraction['image'] }}" alt="{{ $attraction['title'] }}" class="thumbnail-img-small">
                            </div>
                        {% endforeach; %}
                    </div>
                </div>
            {% endif; %}
        </div>
    </div>

    <button class="action-btn save-btn" id="backBtn" aria-label="Voltar para a lista de projetos">Voltar</button>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const backBtn = document.getElementById('backBtn');
            backBtn.addEventListener('click', () => {
                window.location.href = '/em-captacao';
            });
        });
    </script>
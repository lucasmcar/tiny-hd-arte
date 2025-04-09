<div class="container mt-5 text-center hda-section">
    <h2 class="mb-4 hda-title">Nossos Serviços</h2>

     <p class="hda-text">Na HD Arte Produções e Eventos, oferecemos e realizamos uma ampla gama de serviços para transformar o seu evento em uma experiência única. Nossa expertise abrange:</p>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        
        {% foreach $servicos as $index => $servico %}
            <div class="col">
                <div class="card service-card p-3 text-center d-flex flex-column align-items-center">
                    <i class="bi {{ $servico['icone'] }} service-icon"></i>
                    <h5 class="mt-3">{{ $servico['titulo'] }}</h5>
                    <p class="text-muted flex-grow-1">{{ $servico['descricao'] }}</p>
                    <button class="btn btn-hda mt-auto" data-bs-toggle="modal" data-bs-target="#modal{{ $index }}">Saiba Mais</button>
                </div>
            </div>

            <!-- Modal de detalhes -->
            <div class="modal fade" id="modal{{ $index; }}" tabindex="-1" aria-labelledby="modalLabel{{ $index }}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalLabel{{ $index }}">{{ $servico['titulo'] }}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>{{ isset($servico['mais']) ? $servico['mais'] : $servico['descricao'] }}</p>
                        </div>
                    </div>
                </div>
            </div>
        {% endforeach; %}
    </div>
</div>
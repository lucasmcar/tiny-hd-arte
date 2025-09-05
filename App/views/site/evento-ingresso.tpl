<div class="event-details-wrapper">
    <div class="header-info" role="banner">
        <h1 class="event-title">Detalhes do Ingresso</h1>
    </div>

    <div class="event-details-grid" role="main">
        <div class="event-detail-section" data-event-id="{{ $evento['id'] }}">
            <h2 class="section-title">{{ $evento['title'] }}</h2>
            <p class="event-description">{{ $evento['resumo'] }}</p>

            <div class="detail-group">
                <h3 class="detail-subtitle">Informações Gerais</h3>
                <p><strong>Data:</strong> {{ date('d/m/Y (l)', strtotime($evento['periodo_execucao'])) }}</p>
                <p><strong>Horário:</strong> 22h - 4h</p>
                <p><strong>Local:</strong> Espaço Cultural 512 – Rua João Alfredo, Cidade Baixa, Porto Alegre</p>
                <p><strong>Produtor:</strong> {{ $evento['produtor_cultural'] }}</p>
                <p><strong>UF:</strong> {{ $evento['uf'] }}</p>
            </div>

            <div class="detail-group">
                <h3 class="detail-subtitle">Line-up</h3>
                <ul class="lineup-list">
                    {% foreach $evento['lineup'] as $index => $dj %}
                        <li>🎧 {{ $dj }}</li>
                    {% endforeach; %}
                </ul>
            </div>

            <!-- <div class="detail-group">
                <h3 class="detail-subtitle">Produção</h3>
                <p><strong>Cultural:</strong> {{ $evento['produtor_cultural'] }}</p>
                <p><strong>Produção:</strong> {{ $evento['producao'] }}</p>
            </div> -->

            <div class="detail-group">
                <h3 class="detail-subtitle">Ingressos</h3>
                <p>🎟 Ingressos já à venda! Valor estimado: R$ 15,00 +taxas </p>
                <button class="btn-buy-large" onclick="openBuyModal()">Comprar Ingresso</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Compra de Ingresso -->
<div class="modal" id="buyModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Compra de Ingressos</h3>
            <button class="modal-close" onclick="closeBuyModal()">×</button>
        </div>
        <div class="modal-body">
            <p class="lote-info">{{ $lote['nome_lote'] }}: R$ <span id="unitPrice">{{ number_format($lote['preco'], 2, ',', '.') }} </span> + taxa</p>
            <div class="quantity-selector">
                <label for="cliente_nome">Nome:</label>
                <input class="form-control" type="text" name="cliente_nome">
                <label for="cliente_email">Email:</label>
                <input class="form-control" type="email" name="cliente_email">
                <label for="cliente_cpf">CPF</label>
                <input class="form-control" type="text" name="cliente_cpf">
                <label for="quantity">Quantidade:</label>
                <div class="quantity-controls">
                    <button type="button" class="quantity-btn" onclick="decreaseQuantity()" aria-label="Diminuir quantidade">-</button>
                    <input type="number" id="quantity" value="1" min="1" max="15" readonly>
                    <button type="button" class="quantity-btn" onclick="increaseQuantity()" aria-label="Aumentar quantidade">+</button>
                </div>
            </div>
            <p class="total-info">Total: R$ <span id="totalPrice">15.00</span></p>
            <div id="spinner" style="display:none; text-align:center;">
                <div class="loader"></div>
            </div>
            <form id="paymentForm" method="POST" action="/comprar-ingresso">
                <input type="hidden" name="quantity" id="hiddenQuantity">
                <input type="hidden" name="total_amount" id="hiddenTotal">
                <input type="hidden" name="event_id" value="{{ $evento['id'] }}">
                <input type="hidden" name="event_title" value="{{ $evento['title'] }}">
                <button type="submit" class="btn-buy-large" id="payButton">Pagar</button>
            </form>
            
        </div>
    </div>
</div>
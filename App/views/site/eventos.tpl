<div class="events-wrapper">
    <h2 class="hda-title">{{ $title }}</h2>

    <div class="events-grid">
        {% foreach $eventos as $index => $evento %}
            <div class="event-card" data-event-id="{{ $evento['id'] }}">
                <div class="card-content">
                    <h3 class="card-title"><a href="/evento/{{ $evento['slug'] }}" class="card-link">{{ $evento['title'] }}</a></h3>
                    <p class="card-description">{{ $evento['short_description'] }}</p>
                    <p class="card-date"> Quando: {{ $evento['periodo_execucao'] }}</p>
                    <p class="card-location"> {{ $evento['uf'] }}, {{ $evento['short_description'] }}</p>
                    <a class="btn-buy" href="/evento/ingresso/compra/{{ $evento['slug'] }}">Comprar Ingresso</a>
            </div>
        {% endforeach; %}
    </div>
</div>



    <h2>{{ $title }}</h2>
    <div class="carousel-container">

        {% foreach $posts as $index => $item %}
            <div class="carousel-item">
                <img src="https://via.placeholder.com/250x150" alt="Imagem">
                <h5>{{ $item['titulo']}} </h5>
                <p>{{ $item['conteudo']}} </p>
            </div>
            

        {% endforeach; %}
    </div>

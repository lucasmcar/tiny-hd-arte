<style>
/* Tema Netflix */
.equipe-section {
    background-color: #141414;
    padding: 60px 0;
}

.hda-title {
    color: #fff;
    font-size: 2.5rem;
    margin-bottom: 20px;
}

.text-muted {
    color: #999 !important;
    font-size: 1.1rem;
}

/* Grid e Cards */
.team-card {
    overflow: hidden;
    border: none;
    background-color: #222;
    border-radius: 8px;
    transition: transform 0.3s ease;
}

.team-card img {
    width: 100%;
    height: 300px;
    object-fit: cover;
    transition: opacity 0.3s ease;
}

/* Efeito Hover */
.team-card .overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.8);
    opacity: 0;
    transition: opacity 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.team-card:hover .overlay {
    opacity: 1;
}

.team-card:hover img {
    opacity: 0.5;
}

.overlay-content {
    text-align: center;
    color: #fff;
    padding: 20px;
}

.overlay-title {
    font-size: 1.5rem;
    margin-bottom: 10px;
    color: #e50914; /* Vermelho Netflix */
}

.overlay-text {
    font-size: 1.1rem;
    margin-bottom: 10px;
}

.overlay-summary {
    font-size: 0.9rem;
    color: #ccc;
    margin-bottom: 15px;
}

/* Ícones Sociais */
.social-icons a {
    color: #fff;
    font-size: 1.2rem;
    margin: 0 10px;
    transition: color 0.3s ease;
}

.social-icons a:hover {
    color: #e50914; /* Vermelho Netflix */
}

/* Destaque para Fundadoras */
.highlight-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: #e50914;
    color: #fff;
    padding: 5px 10px;
    border-radius: 4px;
    font-size: 0.9rem;
    font-weight: bold;
}

/* Responsividade */
@media (max-width: 768px) {
    .team-card img {
        height: 250px;
    }
    .overlay-title {
        font-size: 1.3rem;
    }
    .overlay-text {
        font-size: 1rem;
    }
}
</style>
<section class="hda-section equipe-section">
    <div class="container text-center">
        <h2 class="hda-title fw-bold">Nossa Equipe</h2>
        <p class="text-muted mb-4">Conheça os profissionais por trás da HD Arte Produções</p>

        <div class="row g-4">
            {% foreach $equipe as $index => $membro %}
                <div class="{% if $membro['destaque'] == true %}col-md-6 col-lg-6{% elseif $membro['destaque'] == false %}col-md-6 col-lg-4{% endif; %}">
                    <div class="team-card position-relative">
                        <img src="{{ $membro['foto'] }}" class="img-fluid" alt="{{ $membro['nome'] }}">
                        <div class="overlay">
                            <div class="overlay-content">
                                <h5 class="overlay-title">{{ $membro['nome'] }}</h5>
                                <p class="overlay-text">{{ $membro['cargo'] }}</p>
                                <p class="overlay-summary">{{ $membro['resumo'] }}</p>
                                <div class="social-icons">
                                    <a href="{{ $membro['redes']['instagram'] }}" target="_blank"><i class="fab fa-instagram"></i></a>
                                    <a href="{{ $membro['redes']['facebook'] }}" target="_blank"><i class="fab fa-facebook-f"></i></a>
                                    <a href="{{ $membro['redes']['linkedin'] }}" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                        </div>
                        {% if $membro['destaque'] == true && $membro['nome'] == 'Heloisa Peres' %}
                            <span class="highlight-badge">Fundadora</span>
                        {% elseif $membro['destaque'] == true && $membro['nome'] == 'Michelle Rodrigues'  %}
                            <span class="highlight-badge">Sócia</span>
                        {% endif; %}
                    </div>
                </div>
            {% endforeach; %}
        </div>
    </div>
</section>
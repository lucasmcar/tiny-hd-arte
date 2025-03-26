<style>

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
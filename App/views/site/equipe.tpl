<style>
body {
    background: #141414; /* Fundo escuro hda */
    color: #fff;
    font-family: 'Montserrat', sans-serif;
    margin: 0;
    padding-top: 80px; /* Espaço para navbar fixo, ajuste conforme necessário */
    /* Scrollbar personalizada */
    scrollbar-width: thin; /* Firefox */
    scrollbar-color: #333 #141414; /* Firefox: thumb e track */
}

/* WebKit Scrollbar (Chrome, Safari, Edge) */
body::-webkit-scrollbar {
    width: 8px;
}

body::-webkit-scrollbar-track {
    background: #141414;
}

body::-webkit-scrollbar-thumb {
    background: #333;
    border-radius: 4px;
}

body::-webkit-scrollbar-thumb:hover {
    background: #555;
}

.hda-section {
    padding: 40px 0; /* Substitui my-5 e pt-5 */
}

.hda-title {
    font-size: 2.5rem;
    font-weight: 600;
    margin-bottom: 20px;
    text-align: center;
    color: #fff;
}

.text-muted {
    color: #aaa !important; /* Cinza claro no estilo hda */
    font-size: 1.1rem;
    text-align: center;
    margin-bottom: 30px;
}

.team-card {
    background: #222; /* Cinza escuro hda */
    border: none;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5); /* Sombra escura */
    transition: transform 0.3s ease;
    height: 100%;
    display: flex;
    flex-direction: column;
    border-radius: 8px; /* Bordas arredondadas */
    overflow: hidden;
}

.team-card:hover {
    transform: scale(1.05); /* Efeito de hover mantido */
}

.team-card img {
    height: 250px; /* Tamanho fixo mantido */
    object-fit: cover;
    width: 100%;
}

.team-card .card-body {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    text-align: center;
    padding: 20px;
}

.team-card .card-title {
    color: #fff;
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 10px;
}

.team-card .card-text {
    color: #e0e0e0; /* Cinza claro para texto */
    font-size: 1rem;
    flex-grow: 1;
}

.card-footer {
    background: #333; /* Cinza mais claro para o footer */
    padding: 15px;
    text-align: center;
}

.social-icons a {
    color: #e50914; /* Vermelho hda */
    font-size: 20px;
    margin: 0 8px;
    transition: color 0.3s;
}

.social-icons a:hover {
    color: #f40612; /* Tom mais claro no hover */
}
</style>

<!-- Seção Equipe -->
<section class="container hda-section text-center">
    <h2 class="hda-title fw-bold">Nossa Equipe</h2>
    <p class="text-muted">Conheça os profissionais por trás da HD Arte Produções</p>

    <div class="row mt-4">
        <!-- Card 1 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="lucas.jpg" class="card-img-top" alt="Lucas Carvalho">
                <div class="card-body">
                    <h5 class="card-title">Lucas Carvalho</h5>
                    <p class="card-text">CEO da Code Experts, Desenvolvimento de sites e aplicações, consultoria e gestão de redes.</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="https://instagram.com/hej.lucasmcar" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="https://www.facebook.com/lmcarvalho90" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="https://linkedin.com/in/lucas-m-carvalho" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="carla.jpg" class="card-img-top" alt="Carla Castro">
                <div class="card-body">
                    <h5 class="card-title">Carla Castro</h5>
                    <p class="card-text">Assessoria de Imprensa.</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="eduardo.jpg" class="card-img-top" alt="Eduardo Raupp">
                <div class="card-body">
                    <h5 class="card-title">Eduardo Raupp</h5>
                    <p class="card-text">Comercial e Consultoria SC.</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 4 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="/assets/imgs/heloisa.jpg" class="card-img-top" alt="Heloisa Peres">
                <div class="card-body">
                    <h5 class="card-title">Heloisa Peres</h5>
                    <p class="card-text">Direção Artística e Produção Executiva.</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 5 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="/assets/imgs/michelle.jpg" class="card-img-top" alt="Michelle Rodrigues">
                <div class="card-body">
                    <h5 class="card-title">Michelle Rodrigues</h5>
                    <p class="card-text">Produção Cultural, Elaboração de Projetos.</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 6 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="regina.jpg" class="card-img-top" alt="Regina Retzel">
                <div class="card-body">
                    <h5 class="card-title">Regina Retzel</h5>
                    <p class="card-text">Assessoria e Produção Cultural para o 3º Setor.</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 7 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="thais.jpg" class="card-img-top" alt="Thais Krug">
                <div class="card-body">
                    <h5 class="card-title">Thais Krug</h5>
                    <p class="card-text">Gestão de Mídias (Instagram).</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 8 -->
        <div class="col-md-4 col-lg-3 mb-4">
            <div class="card team-card">
                <img src="designer.jpg" class="card-img-top" alt="Gezi Vigil">
                <div class="card-body">
                    <h5 class="card-title">Gezi Vigil</h5>
                    <p class="card-text">Designer</p>
                </div>
                <div class="card-footer">
                    <div class="social-icons">
                        <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
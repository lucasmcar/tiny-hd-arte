<style>

.team-card {
    border: none;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
    height: 100%; /* Faz com que todos os cards tenham a mesma altura */
    display: flex;
    flex-direction: column;
}

.team-card:hover {
    transform: scale(1.05);
}

.team-card img {
    height: 250px; /* Tamanho fixo da imagem */
    object-fit: cover;
}

.team-card .card-body {
    flex-grow: 1; /* Faz o conteúdo interno ocupar todo o espaço disponível */
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    text-align: center;
}


 .social-icons a {
            color: #0d6efd;
            font-size: 20px;
            margin: 0 8px;
            transition: 0.3s;
        }

        .social-icons a:hover {
            color: #0056b3;
        }

        .card-footer{
            background-color: #222;
        }
</style>


<!-- Seção Equipe -->
<section class="container text-center my-5 pt-5">
    <h2 class="fw-bold">Nossa Equipe</h2>
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
                <div class="card-footer text-center">
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
                <div class="card-footer text-center">
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
                <div class="card-footer text-center">
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
                <div class="card-footer text-center">
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
                <div class="card-footer text-center">
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
                <div class="card-footer text-center">
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
                <div class="card-footer text-center">
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
                <img src="designer.jpg" class="card-img-top" alt="Designer">
                <div class="card-body">
                    <h5 class="card-title">Gezi Vigil</h5>
                    <p class="card-text">Designer</p>
                </div>
                <div class="card-footer text-center">
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


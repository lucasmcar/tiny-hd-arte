<!-- CSS no estilo hda com carrossel ajustado -->
<style>
body {
    background: #141414;
    color: #fff;
    font-family: 'Montserrat', sans-serif;
    margin: 0;
    padding-top: 80px; /* Espaço para navbar fixo */
    scrollbar-width: thin; /* Firefox */
    scrollbar-color: #333 #141414; /* Firefox: thumb e track */
}

/* WebKit Scrollbar */
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
    padding: 40px 0;
}

.hda-title {
    font-size: 2.5rem;
    font-weight: 600;
    margin-bottom: 20px;
    text-align: center;
    color: #fff;
}

.hda-subtitle {
    font-size: 1.5rem;
    font-weight: 500;
    margin-bottom: 15px;
    color: #fff;
    text-align: center;
}

.hda-text {
    color: #e0e0e0;
    font-size: 1.1rem;
    text-align: center;
    margin-bottom: 30px;
}

.about-card {
    background: #222;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
    transition: transform 0.3s ease;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.about-card:hover {
    transform: scale(1.05);
}

.about-card ul {
    list-style: none;
    padding: 0;
    color: #e0e0e0;
    font-size: 1rem;
    text-align: left;
}

.about-card ul li {
    margin-bottom: 10px;
}

.artist-card {
    background: #222;
    border-radius: 8px;
    padding: 15px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
    transition: transform 0.3s ease;
    width: 250px; /* Largura fixa para consistência */
    flex: 0 0 auto; /* Impede que o card se estique */
    text-align: center;
}

.artist-card:hover {
    transform: scale(1.05);
}

.artist-card h5 {
    font-size: 1.2rem;
    font-weight: 600;
    color: #fff;
    margin-bottom: 10px;
}

.artist-card p {
    color: #e0e0e0;
    font-size: 0.9rem;
}

/* Carrossel horizontal */
.artists-carousel {
    display: flex;
    overflow-x: auto;
    gap: 24px; /* Espaçamento reduzido entre os cards */
    padding: 10px 0;
    scroll-behavior: smooth; /* Rolagem suave */
    justify-content: flex-start; /* Alinhamento inicial, mas centraliza com JS se desejado */
}

.artists-carousel::-webkit-scrollbar {
    height: 8px;
}

.artists-carousel::-webkit-scrollbar-track {
    background: #141414;
}

.artists-carousel::-webkit-scrollbar-thumb {
    background: #333;
    border-radius: 4px;
}

.artists-carousel::-webkit-scrollbar-thumb:hover {
    background: #555;
}

.btn-hda {
    background-color: #e50914;
    border: none;
    padding: 10px 20px;
    font-size: 1.2rem;
    color: #fff;
    transition: background-color 0.3s;
    border-radius: 5px;
    text-align: center;
    display: inline-block;
}

.btn-hda:hover {
    background-color: #f40612;
    color: #fff;
    text-decoration: none;
}
</style>

<!-- Página Sobre -->
<section class="container hda-section">
    <!-- Introdução -->
    <h2 class="hda-title">Sobre a HD’ARTE Eventos</h2>
    <p class="hda-text">Uma empresa dedicada a transformar cultura e arte em experiências inesquecíveis.</p>

    <!-- O que fazemos -->
    <div class="row mt-4">
        <div class="col-md-6 mb-4">
            <div class="about-card">
                <h3 class="hda-subtitle">O que fazemos</h3>
                <ul>
                    <li>Assessoria e Consultoria Cultural</li>
                    <li>Gestão de Projetos Culturais</li>
                    <li>Produção de Eventos Artísticos e Culturais</li>
                    <li>Agenciamento de Artistas, Shows e Espetáculos</li>
                </ul>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="about-card">
                <h3 class="hda-subtitle">Nossos serviços</h3>
                <ul>
                    <li>Planejamento estratégico e metodologia própria</li>
                    <li>Orientação sobre incentivos fiscais</li>
                    <li>Elaboração de projetos para leis de incentivo, fundos e editais</li>
                    <li>Acompanhamento, gestão e avaliação de resultados</li>
                    <li>Prestação de contas aos patrocinadores</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Quem atendemos -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="about-card">
                <p class="hda-text">Oferecemos assessoria cultural para a iniciativa privada, poder público e pessoas físicas, utilizando ferramentas que revitalizam marcas, agregam valor e fortalecem a imagem pública de empresas, instituições e artistas.</p>
                <a href="/contato" class="btn btn-hda mt-3">Entre em Contato</a>
            </div>
        </div>
    </div>

    <!-- Agenciamento de Artistas (Carrossel Horizontal) -->
    <div class="row mt-5">
        <div class="col-12">
            <h3 class="hda-subtitle">Agenciamento de Artistas</h3>
            <div class="artists-carousel" id="artistsCarousel">
                <div class="artist-card">
                    <h5>Gelson Oliveira</h5>
                    <p>Cantor, Compositor (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Grupo Batida de Rua</h5>
                    <p>Dança (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Tom Martins</h5>
                    <p>Cantor (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Zé Caradípia</h5>
                    <p>Cantor (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Mágico Kronnus</h5>
                    <p>(RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Cia Henrique Thalman</h5>
                    <p>Dança (RJ)</p>
                </div>
                <div class="artist-card">
                    <h5>Cia de Dança Rubens Barbot</h5>
                    <p>Dança (RJ)</p>
                </div>
                <div class="artist-card">
                    <h5>Marcus Maestro</h5>
                    <p>Cantor (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Paulo Dionisio</h5>
                    <p>Cantor (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Grupo Interferência Sul</h5>
                    <p>Música (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Camaleão</h5>
                    <p>Teatro de Bonecos (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Banda Feizer</h5>
                    <p>Música (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Laco</h5>
                    <p>Cantor (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Giba Giba</h5>
                    <p>Músico (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Luciah Helena</h5>
                    <p>Cantora (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Zilah Machado</h5>
                    <p>Cantora (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Grupo Althy</h5>
                    <p>Dança (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Carlos Nunes</h5>
                    <p>Professor e Coreógrafo (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Robson Duarte</h5>
                    <p>Bailarino e Coreógrafo (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Mr. Funck Samba</h5>
                    <p>Música (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Mickael Coelho</h5>
                    <p>Bailarino (RS)</p>
                </div>
                <div class="artist-card">
                    <h5>Rosa Franco</h5>
                    <p>Músico, Compositor, Cantor (RS)</p>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const carousel = document.querySelector('#artistsCarousel');
    let scrollAmount = 0;
    const cardWidth = 265; // 250px (card) + 15px (gap)
    const visibleCards = 3;
    const totalCards = carousel.children.length;

    function scrollCarousel() {
        scrollAmount += cardWidth;
        if (scrollAmount >= cardWidth * (totalCards - visibleCards)) {
            scrollAmount = 0; // Volta ao início
        }
        carousel.scrollTo({
            left: scrollAmount,
            behavior: 'smooth'
        });
    }

    setInterval(scrollCarousel, 3000); // Rola a cada 3 segundos
});
</script>
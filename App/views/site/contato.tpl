<!-- CSS no estilo hda -->
<style>
body {
    background: #141414; /* Fundo escuro hda */
    color: #fff;
    font-family: 'Montserrat', sans-serif;
    margin: 0;
    padding-top: 80px; /* Espaço para navbar fixo, ajuste conforme necessário */
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

.contact-container {
    max-width: 800px;
    margin: 100px auto 50px auto;
    padding: 50px 20px;
    background: #222; /* Cinza escuro mais sólido que rgba */
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.8); /* Sombra escura mais sutil */
}

.hda-title {
    font-size: 2.5rem;
    font-weight: 600;
    margin-bottom: 20px;
    text-align: center;
    color: #fff;
}

.hda-text {
    color: #e0e0e0; /* Cinza claro */
    font-size: 1.1rem;
    text-align: center;
    margin-bottom: 30px;
}

.form-control {
    background: #ffffff; /* Cinza escuro para inputs */
    
    border: 2px solid transparent;
    padding: 12px;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
    border-radius: 5px;
    font-size: 1rem;
   
}

.form-control:focus {
    border-color: #e50914; /* Vermelho hda ao focar */
    box-shadow: 0 0 5px rgba(229, 9, 20, 0.5); /* Brilho sutil */
    outline: none;
}

.btn-custom {
    background-color: #e50914; /* Vermelho hda */
    color: #fff;
    border: none;
    padding: 12px;
    font-size: 1rem;
    font-weight: 600;
    transition: background-color 0.3s ease;
    border-radius: 5px;
    width: 100%;
}

.btn-custom:hover {
    background-color: #f40612; /* Vermelho mais claro no hover */
}

.social-icons {
    margin-top: 20px;
    text-align: center;
}

.social-icons a {
    color: #fff;
    font-size: 30px;
    margin: 0 15px;
    transition: color 0.3s ease;
}

.social-icons a:hover {
    color: #e50914; /* Vermelho hda no hover */
}
</style>

<!-- Página de Contato -->
<div class="container contact-container text-center">
    <h2 class="hda-title mb-4">Entre em Contato</h2>
    <p class="hda-text">Entre em contato conosco para mais informações sobre nossos serviços.</p>

    <!-- Formulário -->
    <form action="/contato/email" method="POST">
        <div class="mb-3">
            <input type="text" class="form-control" name="nome" placeholder="Seu Nome" required>
        </div>
        <div class="mb-3">
            <input type="email" class="form-control" name="email" placeholder="Seu E-mail" required>
        </div>
        <div class="mb-3">
            <select class="form-control" name="assunto" required>
                <option value="">Selecione um Assunto</option>
                <option value="Consultoria e Impulsionamento">Consultoria e Impulsionamento</option>
                <option value="Assessoria de Imprensa">Assessoria de Imprensa</option>
                <option value="Comercial e Consultoria">Comercial e Consultoria</option>
                <option value="Direção Artística e Produção Executiva">Direção Artística e Produção Executiva</option>
                <option value="Produção Cultural e Captação de Recursos">Produção Cultural e Captação de Recursos</option>
                <option value="Assessoria para o 3º Setor">Assessoria para o 3º Setor</option>
                <option value="Gestão de Mídias">Gestão de Mídias</option>
                <option value="Outro">Outro</option>
            </select>
        </div>
        <div class="mb-3">
            <textarea class="form-control" name="mensagem" rows="4" placeholder="Sua Mensagem" required></textarea>
        </div>
        <button type="submit" class="btn btn-custom">Enviar</button>
    </form>

    <!-- Redes Sociais -->
    <div class="social-icons mt-4">
        <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
        <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
        <a href="https://linkedin.com" target="_blank"><i class="fab fa-linkedin"></i></a>
    </div>
</div>
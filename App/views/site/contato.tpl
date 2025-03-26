
<!-- Página de Contato -->
<div class="container contact-container text-center">
    <h2 class="hda-title mb-4">Entre em Contato</h2>
    <p class="hda-text">Entre em contato conosco para mais informações sobre nossos serviços.</p>

    <!-- Formulário -->
    <form action="/contato/email" method="POST" id="contactForm">
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
        <button type="submit" class="btn btn-custom" id="submitBtn">Enviar</button>
        <div id="loadingSpinner" class="netflix-spinner" style="display: none;">
            <div class="spinner-circle"></div>
        </div>
    </form>

    <!-- Redes Sociais -->
    <div class="social-icons mt-4">
        <a href="https://facebook.com/hd.arteproducao" target="_blank"><i class="fab fa-facebook"></i></a>
        <a href="https://instagram.com/hd.arteproducao" target="_blank"><i class="fab fa-instagram"></i></a>
        <a href="https://linkedin.com" target="_blank"><i class="fab fa-linkedin"></i></a>
    </div>

    <!-- Modal de Feedback no estilo Netflix -->
    <div class="netflix-modal" id="feedbackModal">
        <div class="netflix-modal-content">
            <div class="netflix-modal-header">
                <h5 class="netflix-modal-title" id="feedbackModalLabel">Status do Envio</h5>
                <button type="button" class="netflix-modal-close" aria-label="Close">&times;</button>
            </div>
            <div class="netflix-modal-body" id="modalMessage">
                <!-- Mensagem será inserida via JS -->
            </div>
            <div class="netflix-modal-footer">
                <button type="button" class="netflix-btn">Fechar</button>
            </div>
        </div>
    </div>
</div>
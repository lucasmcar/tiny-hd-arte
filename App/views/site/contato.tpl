<style>
        /* Fundo escuro estilo Netflix */
        body {
            background: #141414;
            color: white;
        }
        
        /* Estilização da seção de contato */
        .contact-container {
            max-width: 800px;
            margin: 100px auto 50px auto;
            padding: 50px 20px;
            background: rgba(0, 0, 0, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.6);
        }

        .form-control {
            background: #333;
            color: white;
            border: 2px solid transparent;
            padding: 12px;
            transition: 0.3s;
            border-radius: 5px;
        }

        /* Botões */
        .btn-custom {
            background-color: #e50914;
            color: white;
            border: none;
            transition: 0.3s;
            padding: 12px;
            font-size: 16px;
        }

        .btn-custom:hover {
            background-color: #b20710;
        }

        /* Redes Sociais */
        .social-icons a {
            color: white;
            font-size: 30px;
            margin: 10px;
            transition: 0.3s;
        }

        .social-icons a:hover {
            color: #e50914;
        }
    </style>
<div class="container contact-container  text-center">
        <h2 class="mb-4">Entre em Contato</h2>
        <p>Entre em contato conosco para mais informações sobre nossos serviços.</p>

        <!-- Formulário -->
        <form action="processa_contato.php" method="POST">
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
            <button type="submit" class="btn btn-custom w-100">Enviar</button>
        </form>

        <!-- Redes Sociais -->
        <div class="social-icons mt-4">
            <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
            <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
            <a href="https://linkedin.com" target="_blank"><i class="fab fa-linkedin"></i></a>
        </div>
    </div>
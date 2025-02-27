<style>
body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    padding-top: 80px;
    background: rgba(0, 0, 0, 0.8);
}
.testimonial-container {
            max-width: 800px;
            margin: 100px auto 50px auto;
            padding: 50px 20px;
            color: white;
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

        .form-control:focus {
            background: #222;
            border-color: #e50914;
            box-shadow: 0 0 8px rgba(229, 9, 20, 0.8);
        }

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
</style>

<div class="container testimonial-container text-center">
        <h2 class="mb-4">Deixe seu Depoimento</h2>
        <p>Compartilhe sua experiência conosco preenchendo o formulário abaixo.</p>

        <form action="/depoimentos/criar" method="POST">
            <div class="mb-3">
                <input type="text" class="form-control" name="nome" placeholder="Seu Nome" required>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="titulo" placeholder="Título do Depoimento" required>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="profissao" placeholder="Sua Profissão" required>
            </div>
            <div class="mb-3">
                <textarea class="form-control" name="depoimento" rows="4" placeholder="Seu Depoimento" required></textarea>
            </div>
            <button type="submit" class="btn btn-custom w-100">Enviar Depoimento</button>
        </form>
    </div>
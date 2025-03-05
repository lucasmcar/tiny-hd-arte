<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card w-75">
        <h2 class="text-center">Cadastro</h2>
        <div class="row">
            <!-- Coluna da Imagem -->
            <div class="col-md-4 text-center">
                <label for="foto" class="form-label">Foto de Perfil</label>
                <img id="imgPreview" class="img-preview" src="https://via.placeholder.com/150" alt="Preview da Imagem">
                <input type="file" class="form-control mt-2" id="foto" name="foto" accept="image/*" onchange="previewImage(event)">
            </div>
            
            <!-- Coluna do Formulário -->
            <div class="col-md-8">
                <form action="processa_cadastro.php" method="POST" enctype="multipart/form-data">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="nome" name="nome" placeholder="Nome" required>
                        <label for="nome">Nome</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                        <label for="email">Email</label>
                    </div>
                    @csrf
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="senha" name="senha" placeholder="Senha" required>
                        <label for="senha">Senha</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="tel" class="form-control" id="telefone" name="telefone" placeholder="Telefone">
                        <label for="telefone">Telefone</label>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Cadastrar</button>
                </form>
            </div>
        </div>
    </div>
</div>
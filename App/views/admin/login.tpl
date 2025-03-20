<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Montserrat', sans-serif; /* Substituí Arial por Montserrat para consistência */
        background: #141414; /* Fundo escuro Netflix */
        color: #fff;
    }

    .overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6); /* Overlay sutil */
    }

    .logo-container img {
        width: 200px; /* Mantive o tamanho fixo */
        margin-bottom: 20px;
        display: block; /* Corrigido de flex para block */
        margin-left: auto;
        margin-right: auto; /* Centraliza a imagem */
    }

    .login-container {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: #222; /* Cinza escuro Netflix */
        padding: 40px; /* Aumentei um pouco o padding */
        border-radius: 8px; /* Ajustei para bordas mais suaves */
        width: 300px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5); /* Sombra mais suave */
    }

    .login-container h2 {
        margin-bottom: 20px;
        text-align: center;
        font-size: 2rem; /* Maior para impacto */
        font-weight: 600; /* Peso consistente com Netflix */
    }

    .login-container input[type="email"],
    .login-container input[type="password"] {
        width: 100%;
        padding: 12px; /* Aumentei o padding */
        margin: 10px 0;
        border: 2px solid transparent; /* Borda invisível por padrão */
        border-radius: 5px;
        background: #333; /* Cinza escuro para inputs */
        color: #fff;
        font-size: 1rem; /* Tamanho de fonte consistente */
        transition: border-color 0.3s ease, box-shadow 0.3s ease; /* Transição suave */
    }

    .login-container input[type="email"]:focus,
    .login-container input[type="password"]:focus {
        border-color: #e50914; /* Vermelho Netflix no foco */
        box-shadow: 0 0 8px rgba(229, 9, 20, 0.8); /* Efeito de foco */
        outline: none;
    }

    .login-container input::placeholder {
        color: #999; /* Cinza claro para placeholders */
    }

    .login-container button {
        width: 100%;
        padding: 12px; /* Aumentei o padding */
        background: #e50914; /* Vermelho Netflix */
        border: none;
        border-radius: 5px;
        color: #fff;
        font-weight: 600; /* Mais negrito */
        font-size: 1rem;
        cursor: pointer;
        transition: background 0.3s ease;
        text-transform: uppercase; /* Estilo Netflix */
    }

    .login-container button:hover {
        background: #b20710; /* Vermelho mais escuro no hover */
    }

    .login-container .links {
        margin-top: 20px;
        text-align: center;
    }

    .login-container .links a {
        color: #b3b3b3;
        text-decoration: none;
        font-size: 0.9rem;
        display: block; /* Cada link em uma linha */
        margin: 5px 0; /* Espaçamento entre links */
        transition: color 0.3s ease;
    }

    .login-container .links a:hover {
        color: #e50914; /* Vermelho Netflix no hover */
    }

    /* Removi a classe .signup, já que os links foram movidos para .links */
</style>

<div class="overlay"></div>
<div class="login-container">
    <div class="logo-container">
        <img src="/assets/imgs/logo.png" alt="Logo HD Arte">
    </div>
    <h2>Entrar</h2>
    <form action="/authenticate">
        <input type="email" placeholder="E-mail" required>
        <input type="password" placeholder="Senha" required>
        @csrf
        <button type="submit">Entrar</button>
        <div class="links">
            <a href="#">Esqueceu a senha?</a>
            <a href="nova/conta">Criar uma conta</a>
        </div>
    </form>
</div>
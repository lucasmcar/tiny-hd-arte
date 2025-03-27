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
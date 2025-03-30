<div class="overlay"></div>
<div class="login-container">
    <div class="logo-container">
        <img src="/assets/imgs/logo.png" alt="Logo HD Arte">
    </div>
    <h2>Entrar</h2>
    <form action="/admin/signIn" method="post">
        <input type="email" autocomplete="username" placeholder="E-mail" name="email" required>
        <input type="password"  autocomplete="current-password" placeholder="Senha" name="senha" required>
        @csrf
        <button type="submit">Entrar</button>
        <div class="links">
            <a href="conta/esqueci-senha">Esqueceu a senha?</a>
        </div>
    </form>
</div>
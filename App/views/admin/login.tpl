<div class="overlay"></div>
<div class="login-container">
    <div class="logo-container">
        <img src="/assets/imgs/logo.png" alt="Logo HD Arte" class="logo">
    </div>
   
    <form action="/admin/signIn" method="post" class="login-form" aria-label="Formulário de Login">
        <div class="form-group">
            <label for="email" class="form-label">E-mail</label>
            <input type="email" id="email" name="email" autocomplete="username" required aria-required="true" placeholder="Digite seu e-mail">
        </div>
        <div class="form-group">
            <label for="senha" class="form-label">Senha</label>
            <input type="password" id="senha" name="senha" autocomplete="current-password" required aria-required="true" placeholder="Digite sua senha">
        </div>
        @csrf
        <button type="submit" class="login-btn">Entrar</button>
        <div class="links">
            <a href="/conta/esqueci-senha" class="forgot-password">Esqueceu a senha?</a>
        </div>
        <div class="feedback" id="loginFeedback"></div>
    </form>
</div>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background: url('https://cdn.wallpapersafari.com/21/96/uZmXgt.jpg') no-repeat center center fixed;
        background-size: cover;
        color: #fff;
    }


    .overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
    }

    .logo-container img {
        width: 100%;
        margin-bottom: 20px;
        display: flex;
        justify-content: center;
    }

    .login-container {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: rgba(0, 0, 0, 0.75);
        padding: 30px;
        border-radius: 10px;
        width: 300px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
    }

    .login-container h2 {
        margin-bottom: 20px;
        text-align: center;
    }

    .login-container input[type="email"],
    .login-container input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: none;
        border-radius: 5px;
        background: #333;
        color: #fff;
    }

    .login-container button {
        width: 100%;
        padding: 10px;
        background: #e50914;
        border: none;
        border-radius: 5px;
        color: white;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s;
    }

    .login-container button:hover {
        background: #f40612;
    }

    .login-container .links {
        margin-top: 20px;
        text-align: center;
    }

    .login-container .links a {
        color: #b3b3b3;
        text-decoration: none;
        font-size: 0.9em;
    }

    .login-container .links a:hover {
        text-decoration: underline;
    }

    .login-container .signup {
        margin-top: 20px;
        text-align: center;
        color: #b3b3b3;
    }

    .login-container .signup a {
        color: #fff;
        text-decoration: none;
        font-weight: bold;
    }

    .logo-container img {
        width: 150px;
        margin-bottom: 20px;
    }
</style>

<div class="overlay"></div>
<div class="login-container">
    <h2>Entrar</h2>
    <form action="/authenticate">
        <input type="email" placeholder="Email" required>
        <input type="password" placeholder="Senha" required>
        @csrf
        <button type="submit">Entrar</button>
        <a href="#">Esqueceu a senha?</a>
        <a href="nova/conta">Criar uma conta</a>
    </form>
</div>

<div class="content" id="main-content">
    <h2>Bem-vindo ao Dashboard</h2>
    <div class="dashboard-grid">
        <div class="dashboard-card">
            <h3>Depoimentos</h3>
            <p class="metric" data-value="{{ $totalDepoimentos }}">0</p>
            <span>Total de depoimentos cadastrados</span>
        </div>
        <div class="dashboard-card">
            <h3>Artigos</h3>
            <p class="metric" data-value="{{ $totalPosts }}">0</p>
            <span>Total de artigos escritos</span>
        </div>
        <div class="dashboard-card">
            <h3>Eventos</h3>
            <p class="metric" data-value="{{ $totalEventos }}">0</p>
            <span>Total de eventos realizados</span>
        </div>
        <div class="dashboard-card">
            <h3>Projetos</h3>
            <p class="metric" data-value="{{ $totalProjetos }}">0</p>
            <span>Total de projetos finalizados</span>
        </div>
        <div class="dashboard-card">
            <h3>Usuários</h3>
            <p class="metric" data-value="{{ $totalUsers }}">0</p>
            <span>Total de usuários registrados</span>
        </div>
        <div class="dashboard-card">
            <h3>Serviços</h3>
            <p class="metric" data-value="{{ $totalServicos }}">0</p>
            <span>Total de serviços ativos</span>
        </div>
    </div>
</div>

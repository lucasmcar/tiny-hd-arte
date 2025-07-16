<div class="content" id="main-content" aria-label="Dashboard Principal">
    <h2 class="dashboard-title">Bem-vindo ao Dashboard</h2>
    <div class="dashboard-grid" role="region" aria-live="polite">
        <div class="dashboard-card">
            <h3 class="card-title">Depoimentos</h3>
            <p class="metric" data-value="{{ $totalDepoimentos }}" aria-label="Total de depoimentos cadastrados">0</p>
            <span class="card-subtitle">Total de depoimentos cadastrados</span>
        </div>
        <div class="dashboard-card">
            <h3 class="card-title">Artigos</h3>
            <p class="metric" data-value="{{ $totalPosts }}" aria-label="Total de artigos escritos">0</p>
            <span class="card-subtitle">Total de artigos escritos</span>
        </div>
        <div class="dashboard-card">
            <h3 class="card-title">Eventos</h3>
            <p class="metric" data-value="{{ $totalEventos }}" aria-label="Total de eventos realizados">0</p>
            <span class="card-subtitle">Total de eventos realizados</span>
        </div>
        <div class="dashboard-card">
            <h3 class="card-title">Projetos</h3>
            <p class="metric" data-value="{{ $totalProjetos }}" aria-label="Total de projetos finalizados">0</p>
            <span class="card-subtitle">Total de projetos finalizados</span>
        </div>
        <div class="dashboard-card">
            <h3 class="card-title">Usuários</h3>
            <p class="metric" data-value="{{ $totalUsers }}" aria-label="Total de usuários registrados">0</p>
            <span class="card-subtitle">Total de usuários registrados</span>
        </div>
        <div class="dashboard-card">
            <h3 class="card-title">Serviços</h3>
            <p class="metric" data-value="{{ $totalServicos }}" aria-label="Total de serviços ativos">0</p>
            <span class="card-subtitle">Total de serviços ativos</span>
        </div>
    </div>
    <div id="loading" class="loading-overlay">
        <i class="fa fa-spinner" aria-label="Carregando dados do dashboard"></i>
    </div>
</div>
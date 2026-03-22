FROM php:8.3-apache

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libicu-dev \
    libpq-dev \
    libsqlite3-dev \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    nano \
    vim \
    iputils-ping \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Configurar extensões GD
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg

# Instalar extensões PHP mais comuns
RUN docker-php-ext-install -j$(nproc) \
    mysqli \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    zip \
    gd \
    intl \
    mbstring \
    exif \
    pcntl \
    bcmath \
    soap \
    sockets \
    opcache \
    curl

# Instalar Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Instalar Composer (oficial)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Ativar mod_rewrite
RUN a2enmod rewrite headers

# Configurar DocumentRoot (opcional)
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf \
    /etc/apache2/apache2.conf \
    /etc/apache2/conf-available/*.conf

# Copiar arquivos
COPY . /var/www/html/

# Permissões
RUN chown -R www-data:www-data /var/www/html

# Copiar configs personalizadas
COPY php.ini /usr/local/etc/php/
COPY xdebug.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html

EXPOSE 80

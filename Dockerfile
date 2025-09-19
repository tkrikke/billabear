FROM php:8.3-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libonig-dev libxml2-dev \
    libzip-dev zip curl \
    libpq-dev

# Install PHP extensions
RUN docker-php-ext-install gd pdo pdo_pgsql pcntl zip \
    && pecl install redis apcu \
    && docker-php-ext-enable redis apcu

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install Composer dependencies
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer install --optimize-autoloader --no-scripts

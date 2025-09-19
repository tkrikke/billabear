# Use PHP 8.2 CLI as base
FROM php:8.2-cli

# Install system dependencies for PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    zip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mbstring pdo pdo_pgsql zip opcache

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --optimize-autoloader --no-scripts

# Install Node.js (for frontend assets)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install \
    && npm run build

# Expose port for Railway
EXPOSE 8000

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]

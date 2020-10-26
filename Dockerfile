FROM php:7-apache

USER root

# Set working directory
WORKDIR /var/www/html/

# Arguments defined in docker-compose.yml
# Se los puse aquí para que pase GitHub Action
ARG user=islasgeci
ARG uid=1000

COPY ["composer.json", "composer.lock", "/var/www/html/"]

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY apache/vhost.conf /etc/apache2/sites-available/000-default.conf

# Get latest Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN chown -R www-data:www-data /var/www/html \
#     && a2enmod rewrite

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user \
    && a2enmod rewrite

RUN composer install --no-scripts --no-autoloader
#RUN composer install -d /var/www/ --no-scripts --no-autoloader

COPY . /var/www/html/

# USER $user

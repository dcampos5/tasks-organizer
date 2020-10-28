FROM php:7-apache

# Install system dependencies
RUN apt-get update && apt-get install --yes \
    curl \
    git \
    libonig-dev \
    libpng-dev \
    libxml2-dev \
    unzip \
    zip

# Clear cache
RUN apt-get clean && rm --force --recursive /var/lib/apt/lists/

# Install PHP extensions
RUN docker-php-ext-install \
    bcmath \
    exif \
    gd \
    mbstring \
    pcntl \
    pdo_mysql

COPY apache/vhost.conf /etc/apache2/sites-available/000-default.conf

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN chown -R www-data:www-data /var/www/html \
#     && a2enmod rewrite

# Arguments defined in docker-compose.yml
# Se los puse aquí para que pase GitHub Action
ARG user=islasgeci
ARG uid=1000

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user \
    && a2enmod rewrite

# Set working directory
WORKDIR /var/www/html/

# COPY ["composer.json", "composer.lock", "/var/www/html/"]
COPY . .

RUN composer install --no-scripts --no-autoloader
#RUN composer install -d /var/www/ --no-scripts --no-autoloader

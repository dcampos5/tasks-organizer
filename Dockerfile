FROM php:7.4-fpm

# Arguments defined in docker-compose.yml
# Se los puse aquí para que pase GitHub Action
ARG user=islasgeci
ARG uid=1000

#COPY ["composer.json", "composer.lock", "/var/www/"]

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

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
#WORKDIR /var/www/

#RUN composer install --no-scripts --no-autoloader
#RUN composer install -d /var/www/ --no-scripts --no-autoloader

#COPY . /var/www/

USER $user

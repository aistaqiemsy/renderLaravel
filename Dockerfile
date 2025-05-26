# Gunakan PHP dengan Apache
FROM php:8.1-apache

# Install ekstensi PHP yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git \
    && docker-php-ext-install pdo pdo_mysql zip

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy source code Laravel ke folder /var/www/html
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install dependencies composer
RUN composer install --no-dev --optimize-autoloader

# Set permission supaya storage dan cache bisa diakses
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Enable mod_rewrite untuk Laravel route
RUN a2enmod rewrite

# Copy file virtual host apache untuk Laravel (bisa custom, opsional)
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80

# Jalankan apache di foreground
CMD ["apache2-foreground"]

FROM php:8.3-apache

# Włącz moduł mod_rewrite (do pracy z Symfony)
RUN a2enmod rewrite

# Zainstaluj wymagane rozszerzenia PHP dla Symfony
RUN docker-php-ext-install pdo pdo_mysql

# Skopiuj konfigurację Apache (vhost)
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf

# Skopiuj pliki aplikacji Symfony
COPY . /var/www/symfony1/

# Ustaw katalog roboczy
WORKDIR /var/www/symfony1

# Ustaw odpowiednie uprawnienia do plików
RUN chown -R www-data:www-data /var/www/symfony1

# Zainstaluj zależności Symfony (jeśli masz composer w projekcie)
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install

# Ustaw port na 80 (domyślny port Apache)
EXPOSE 80


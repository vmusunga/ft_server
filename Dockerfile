FROM debian:buster

#install
RUN apt-get -y install \
	nginx \
	php-mysql \
	php-fpm \
	php-mbstring \
	mariadb-server \
	php-mbstring \
	wget

#PHP
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz && \
	tar -xzvf phpMyAdmin-5.0.2-english.tar.gz && \
	mv phpMyAdmin-5.0.2-english/ /var/www/html/phpmyadmin && \
	rm -rf phpMyAdmin-5.0.2-english.tar.gz

RUN wget https://wordpress.org/latest.tar.gz && 

EXPOSE 80 443

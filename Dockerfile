FROM debian:buster

RUN apt-get -y upgrade

#install
RUN apt-get update && apt-get install -y \
	tar \
	nginx \
	php-mysql \
	php-fpm \
	php-mbstring \
	mariadb-server \
	php-mbstring \
	wget

#NGINX
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \ 
	rm var/www/html/index.nginx-debian.html

#PHP
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz && \
	tar -xzvf phpMyAdmin-5.0.2-english.tar.gz && \
	mv phpMyAdmin-5.0.2-english/ /var/www/html/phpmyadmin && \
	rm -rf phpMyAdmin-5.0.2-english.tar.gz
COPY srcs/phpmyadmin/config.inc.php /var/www/html/phpmyadmin

#WORDPRESS
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	mv wordpress /var/www/html/
	#rm -rf latest.tar.gz
COPY srcs/wordpress/wp-config.php /var/www/html/wordpress

#SSL https://linuxize.com/post/creating-a-self-signed-ssl-certificate/
RUN openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=Belgium/L=Brussels/O=42network/OU=19brussels/CN=vmus" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;


EXPOSE 80 443

CMD bash init.sh
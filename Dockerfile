FROM ubuntu:20.04

# DNS Service

RUN apt-get update

RUN apt-get install -y bind9 dnsutils

COPY named.conf.options /etc/bind/named.conf.options

COPY named.conf.local /etc/bind/named.conf.local

RUN cp /etc/bind/db.local /etc/bind/tusuario.claselinux.com


# HTTP Service

COPY info.php /var/www/html/info.php

ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y software-properties-common

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update

RUN apt install -y apache2 libapache2-mod-php php-mysql mariadb-server curl

EXPOSE 80 80

CMD ["sh", "-c", "service apache2 start && echo 'Following logs' && LOAD: 'http://localhost/info.php/info.php' && tail -f /dev/null"]
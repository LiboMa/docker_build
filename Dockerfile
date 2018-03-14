FROM ubuntu:16.04

MAINTAINER Ma Libo<malibo8407@gmail.com>

RUN apt-get -y update
RUN apt-get install -y supervisor apache2 libapache2-mod-wsgi python-pip python-mysqldb && apt-get -y autoremove
RUN pip install --upgrade pip && pip install web.py
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN mkdir -p /opt/test/sourcemgt
ADD srcmgt_app/sourcemgt /opt/test/sourcemgt
RUN chown www-data -R /opt/test/sourcemgt

ADD srcmgt_app/sourcemgt.conf /etc/apache2/sites-enabled/sourcemgt.conf

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl","-DFOREGROUND"]




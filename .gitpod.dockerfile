# Gitpod docker image for WordPress | https://github.com/luizbills/.gitpod-conf
# License: MIT (c) 2020 Luiz Paulo "Bills"
# Version: 0.9

FROM gitpod/workspace-mysql

## General Settings ##
ENV PHP_VERSION="7.4"
ENV APACHE_DOCROOT="public_html"

## Get the settings files
USER gitpod
ENV TRIGGER_REBUILD=1
RUN git clone https://github.com/wp-mail-logging/wp-mail-logging-2-dev/ --branch main /home/gitpod/.gitpod-conf

## Install nvm and NodeJS (version: LTS)
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    bash -c ". .nvm/nvm.sh && nvm install --lts"

## Install Go
ENV GO_VERSION="1.19.1"
ENV GOPATH=$HOME/go-packages
ENV GOROOT=$HOME/go
ENV PATH=$GOROOT/bin:$GOPATH/bin:$PATH
RUN curl -fsSL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar xzs

#USER root
#RUN install-packages mysql-server \
# && mkdir -p /var/run/mysqld /var/log/mysql \
# && chown -R gitpod:gitpod /etc/mysql /var/run/mysqld /var/log/mysql /var/lib/mysql /var/lib/mysql-files /var/lib/mysql-keyring /var/lib/mysql-upgrade

# Install our own MySQL config
#COPY conf/mysql.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
# Install default-login for MySQL clients
#COPY conf/client.cnf /etc/mysql/mysql.conf.d/client.cnf
#COPY conf/mysql-bashrc-launch.sh /etc/mysql/mysql-bashrc-launch.sh
#USER gitpod
#RUN echo "/etc/mysql/mysql-bashrc-launch.sh" >> /home/gitpod/.bashrc.d/100-mysql-launch

#USER root
#RUN chown gitpod:gitpod /home/gitpod/.bashrc.d/100-mysql-launch && chmod +x /home/gitpod/.bashrc.d/100-mysql-launch

USER root
### Install Mailhog
RUN go install github.com/mailhog/MailHog@latest 
RUN    go install github.com/mailhog/mhsendmail@latest 
RUN    sudo cp $GOPATH/bin/MailHog /usr/local/bin/mailhog 
RUN    sudo cp $GOPATH/bin/mhsendmail /usr/local/bin/mhsendmail
RUN    sudo ln -s $GOPATH/bin/mhsendmail /usr/sbin/sendmail
RUN    sudo ln -s $GOPATH/bin/mhsendmail /usr/bin/mail

## Install WebServer
USER root
RUN rm -R /etc/apache2
ARG DEBIAN_FRONTEND=noninteractive
RUN add-apt-repository -y ppa:ondrej/php \
    && install-packages \
        # Install Apache
        apache2 \
        # Install PHP and modules
        php${PHP_VERSION} \
        php${PHP_VERSION}-dev \
        php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-ctype \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-tokenizer \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-zip

RUN update-alternatives --set php $(which php${PHP_VERSION})
### Setup WebServer
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load && \
    chown -R gitpod:gitpod /etc/apache2 /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    echo "include /home/gitpod/.gitpod-conf/conf/apache.conf" > /etc/apache2/apache2.conf && \
    echo ". /home/gitpod/.gitpod-conf/conf/apache.env.sh" > /etc/apache2/envvars && \
    #mkdir -p /var/run/mysqld /var/log/mysql && \
    #chown -R gitpod:gitpod /etc/mysql /var/run/mysqld /var/log/mysql /var/lib/mysql && \
    #cat /home/gitpod/.gitpod-conf/conf/mysql.cnf > /etc/mysql/mysql.conf.d/100-mysql-gitpod.cnf && \
    cat /home/gitpod/.gitpod-conf/conf/php.ini >> /etc/php/${PHP_VERSION}/apache2/php.ini

## Install WP-CLI
RUN wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /home/gitpod/wp-cli.phar && \
    chmod +x /home/gitpod/wp-cli.phar && \
    mv /home/gitpod/wp-cli.phar /usr/local/bin/wp && \
    chown gitpod:gitpod /usr/local/bin/wp

## Setup .bashrc
RUN cat /home/gitpod/.gitpod-conf/conf/.bashrc.sh >> /home/gitpod/.bashrc && \
    echo  >> /home/gitpod/.bashrc && \
    . /home/gitpod/.bashrc

USER gitpod

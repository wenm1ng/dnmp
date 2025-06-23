# Default Dockerfile
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

FROM hyperf/hyperf:8.1-alpine-v3.16-swoole
LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT" app.name="Hyperf"

##
# ---------- env settings ----------
##
# --build-arg timezone=Asia/Shanghai
ARG timezone

ENV TIMEZONE=${timezone:-"Asia/Shanghai"} \
    APP_ENV=prod \
    SCAN_CACHEABLE=(true)

# update
RUN set -ex \
    # show php version and extensions
    && php -v \
    && php -m \
    && php --ri swoole \
    #  ---------- some config ----------
    && cd /etc/php81 \
    # - config PHP
    && { \
        echo "upload_max_filesize=128M"; \
        echo "post_max_size=128M"; \
        echo "memory_limit=1G"; \
        echo "date.timezone=${TIMEZONE}"; \
    } | tee conf.d/99_overrides.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    # ---------- clear works ----------
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"

WORKDIR /data/www

# Composer Cache
#COPY ./composer.* /data/www/
#RUN ls -l
#RUN composer install --no-dev --no-scripts

COPY . /data/www

#如果前面没有安装zip扩展，这儿需要安装，安装了请忽略
#RUN apt-get install zlib1g-dev libzip-dev zip -y && docker-php-ext-install zip && docker-php-ext-enable zip

#RUN curl -fsSL https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer 

#composer安装
#RUN cd /data/www && composer create-project hyperf/hyperf-skeleton hyperf -n

#RUN cd /data/www/hyperf-skeleton
#RUN composer install --no-dev -o && php bin/hyperf.php

EXPOSE 9601

ENTRYPOINT ["tail", "-f", "/dev/null"]
#ENTRYPOINT ["php", "/data/www/bin/hyperf.php", "start"]
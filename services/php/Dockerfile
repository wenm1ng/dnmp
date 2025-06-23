ARG PHP_VERSION
FROM ${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG CONTAINER_PACKAGE_URL


RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ] ; then sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories ; fi

COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions
RUN chmod +x install.sh \
    && sh install.sh

ADD ./extensions/install-php-extensions  /usr/local/bin/

#更换官方源
#RUN if [ "mirrors.aliyun.com" != "" ] ; then sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories ; fi

# 更新包列表并安装git和其他必要的依赖
RUN apk --no-cache --allow-untrusted add git openssh-client curl bash
RUN apk add yasm && apk add ffmpeg

RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ] ; then sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories ; fi

RUN chmod uga+x /usr/local/bin/install-php-extensions

RUN apk add --update --no-cache autoconf g++ imagemagick-dev libtool make pcre-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make pcre-dev

RUN apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone

# 安装 Node.js
#RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
#RUN apt-get install -y nodejs

# 安装 npm 和 yarn
#RUN npm install --global npm@latest
#RUN npm install --global yarn@latest

# 安装 Chromium 和 Chromium Driver 的构建依赖项
#RUN apk update && apk add --no-cache \
#    chromium \
#    chromium-chromedriver

# 从构建阶段复制已安装好的 Chromium 和 Chromium Driver
#COPY --from=builder /usr/bin/chromium-browser /usr/bin/chromium-browser
#COPY --from=builder /usr/lib/chromium /usr/lib/chromium

# 更新 Alpine 的软件源，并安装运行 Chromium 所需的依赖项
#RUN apk update && apk add --no-cache \
#    libstdc++ \
#    harfbuzz \
#    nss \
#    freetype \
#    ttf-freefont

# 设置环境变量，指定 Chromium 可执行文件的位置
#ENV CHROME_BIN=/usr/bin/chromium-browser

# Fix: https://github.com/docker-library/php/issues/1121
RUN apk add --no-cache --repository http://${CONTAINER_PACKAGE_URL}/alpine/v3.13/community/ gnu-libiconv=1.15-r3
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php


# Install composer and change it's cache home
RUN chmod +x install-composer.sh \
    && sh install-composer.sh \
    && rm -rf /tmp/extensions
ENV COMPOSER_HOME=/tmp/composer

# php image's www-data user uid & gid are 82, change them to 1000 (primary user)
RUN apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data


# 设置Git全局配置
RUN git config --global user.email "wenming"
RUN git config --global user.name "Awenming001"

# 设置工作目录
WORKDIR /data/www

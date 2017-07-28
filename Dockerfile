FROM prashanthmadi/appservice-nginx-php-fpm:latest

ENV DOCKER_BUILD_HOME "/dockerbuild"
# magento ce
ENV MAGENTO_VERSION "2.1.5"
ENV MAGENTO_PACKAGE "Magento-CE-$MAGENTO_VERSION.tar.gz"
ENV MAGENTO_SOURCE "/usr/src/magento"
ENV MAGENTO_HOME "/var/www/html"
ENV PATH "$MAGENTO_HOME/bin":$PATH

COPY $MAGENTO_PACKAGE $DOCKER_BUILD_HOME/

RUN apt-get update \
    # ------------	
	# 1. magento ce
	# ------------
	&& mkdir -p $MAGENTO_SOURCE \
    && mkdir -p $MAGENTO_HOME \
	&& cd $DOCKER_BUILD_HOME \
	&& tar -xf $MAGENTO_PACKAGE -C $MAGENTO_SOURCE \
	&& rm $DOCKER_BUILD_HOME/$MAGENTO_PACKAGE \
    # -------
	# 2. cron
	# -------
	&& apt-get install cron -y -V --no-install-recommends \
	&& rm -r /var/lib/apt/lists/* 

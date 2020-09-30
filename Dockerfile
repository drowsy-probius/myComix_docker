FROM php:7.4-cli
LABEL version='1.0.0' 
MAINTAINER k123s456h@gmail.com 

# install dependencies
RUN apt update && apt install -y \
		libzip-dev zlib1g-dev \
		libpng-dev libjpeg62-turbo-dev \
		libfreetype6-dev git

RUN docker-php-ext-configure gd --with-jpeg --with-freetype && \
    docker-php-ext-install -j$(nproc) zip gd


# app directory
RUN mkdir /app 
RUN git clone https://github.com/imueRoid/myComix.git /app 
CMD chmod -R 777 /app

# make base_dir
RUN mkdir /myComix

# external setting
EXPOSE 8888
VOLUME ["/myComix", "/app"]

# environments
ENV MEMORY_LIMIT=256M
ENV POST_MAX_SIZE=100M
ENV UPLOAD_MAX_FILESIZE=100M
ENV MAX_EXECUTION_TIME=600

# execute
CMD php \
  -d memory_limit=$MEMORY_LIMIT \
  -d post_max_size=$POST_MAX_SIZE \
  -d upload_max_filesize=$UPLOAD_MAX_FILESIZE \
  -d max_execution_time=$MAX_EXECUTION_TIME \ 
  -S 0.0.0.0:8888 -t /app

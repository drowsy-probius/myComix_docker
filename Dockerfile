FROM php:7.4-cli
LABEL version='1.0.0' 
MAINTAINER k123s456h@gmail.com 

# install dependencies
RUN apt update && apt install -y \
		libzip-dev zlib1g-dev \
		libpng-dev libjpeg62-turbo-dev \
		libfreetype6-dev git 
RUN docker-php-ext-configure gd --with-jpeg --with-freetype
RUN docker-php-ext-install -j$(nproc) zip gd


# app directory
RUN mkdir /app 
RUN git clone https://github.com/imueRoid/myComix.git /app 
CMD chmod -R 777 /app

# make base_dir
RUN mkdir /myComix

# execute
EXPOSE 8888
CMD php -d display_errors=off \
  -d memory_limit=256M \
  -d post_max_size=100M \
  -d upload_max_filesize=100M \
  -d max_execution_time=600 \ 
  -S 0.0.0.0:8888 -t /app

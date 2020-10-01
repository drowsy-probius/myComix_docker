FROM php:7.4-cli
LABEL version='1.0.0' maintainer='k123s456h@gmail.com'

# environments
ENV MEMORY_LIMIT=256M
ENV POST_MAX_SIZE=100M
ENV UPLOAD_MAX_FILESIZE=100M
ENV MAX_EXECUTION_TIME=600
ENV TZ=Asia/Seoul

# install dependencies
RUN \
  apt update && apt install -y \
    libzip-dev zlib1g-dev \
	libpng-dev libjpeg62-turbo-dev \
	libfreetype6-dev git && \
  docker-php-ext-configure gd --with-jpeg --with-freetype && \
  docker-php-ext-install -j$(nproc) zip gd


# install core files 
RUN git clone https://github.com/imueRoid/myComix.git /app --depth=1 && \
    chmod -R 777 /app
	
WORKDIR /app

# external setting
EXPOSE 8888
VOLUME ['/app', '/myComix']

# execute
CMD php \
  -d memory_limit=$MEMORY_LIMIT \
  -d post_max_size=$POST_MAX_SIZE \
  -d upload_max_filesize=$UPLOAD_MAX_FILESIZE \
  -d max_execution_time=$MAX_EXECUTION_TIME \ 
  -S 0.0.0.0:8888 -t /app
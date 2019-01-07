FROM jheimbach/php-basic:latest

RUN rm -rf /var/lib/apt/lists/* && apt-get update
RUN apt-get install -y --no-install-recommends libbz2-dev zlib1g-dev libicu-dev g++ libmagickwand-dev libav-tools html2text ghostscript libreoffice pngcrush jpegoptim exiftool poppler-utils wget

RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install mcrypt exif bz2 intl

RUN pecl install imagick
RUN docker-php-ext-enable imagick

RUN pecl install apcu
RUN docker-php-ext-enable apcu

# Install Build Tools (getting removed later)
RUN apt-get -y --no-install-recommends install autoconf automake libtool nasm cmake make pkg-config libz-dev build-essential g++

RUN cd ~

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
       && tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
       && mv wkhtmltox/bin/wkhtmlto* /usr/bin/ \
       && rm -rf wkhtmltox

# Install Mozjpeg
RUN git clone https://github.com/mozilla/mozjpeg.git  \
        && cd mozjpeg \
        && cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_LIBDIR=/usr/local/lib64 . \
        && make install prefix=/usr/local libdir=/usr/local/lib64 \
        && cd .. \
        && rm -rf mozjpeg

# Install Zopflipng
RUN git clone https://github.com/google/zopfli.git \
        && cd zopfli \
        && make \
        && cp zopfli /usr/bin/zopflipng \
        && cd .. \
        && rm -rf zopfli

# Install Pngout
RUN wget http://static.jonof.id.au/dl/kenutils/pngout-20150319-linux.tar.gz \
        && tar -xf pngout-20150319-linux.tar.gz \
        && rm pngout-20150319-linux.tar.gz \
        && cp pngout-20150319-linux/x86_64/pngout /bin/pngout \
        && cd .. \
        && rm -rf pngout-20150319-linux

# Install advpng
RUN wget http://prdownloads.sourceforge.net/advancemame/advancecomp-1.17.tar.gz \
        && tar zxvf advancecomp-1.17.tar.gz \
        && cd advancecomp-1.17 \
        && ./configure \
        && make \
        && make install \
        && cd .. \
        && rm -rf advancecomp-1.17

# Cleanup
RUN apt-get remove -y autoconf automake libtool nasm cmake make pkg-config libz-dev build-essential g++ \
        && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*


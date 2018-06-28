FROM ubuntu:14.04
MAINTAINER xymostech <xymostech@gmail.com>

# Install things
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    --no-install-recommends --auto-remove \
    git \
    texlive \
    wget \
    fontforge \
    mftrace \
    fonttools \
    man-db \
    build-essential \
    python-fontforge \
    ruby \
    woff-tools \
    pkg-config \
    libharfbuzz-dev \
    libfreetype6-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && gem install ttfunk --version 1.1.1

# Download and compile ttfautohint
RUN wget "http://download.savannah.gnu.org/releases/freetype/ttfautohint-1.3.tar.gz" \
 && tar -xzf ttfautohint-*.tar.gz \
 && cd ttfautohint-*/ \
 && ./configure --without-qt \
 && make \
 && mv frontend/ttfautohint /usr/bin \
 && cd .. \
 && rm -r ttfautohint-*

# Download and compile woff2_compress
RUN wget "https://github.com/google/woff2/archive/d9a74803fa884559879e3205cfe6f257a2d85519.tar.gz" -O woff2.tar.gz \
 && tar -xzf woff2.tar.gz \
 && make -C woff2-*/woff2/ \
 && mv woff2-*/woff2/woff2_compress /usr/bin \
 && rm -r woff2*

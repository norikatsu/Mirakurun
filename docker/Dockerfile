##### Build lib & recisdb-rs
# FROM ubuntu:24.04 AS build_recisdb
# WORKDIR /app
# ENV DOCKER=YES NODE_ENV=production
#
# # apt install
# RUN apt-get update && \
#     apt-get upgrade -y && \
#     apt-get install -y --no-install-recommends \
#         build-essential \
#         autoconf \
#         automake \
#         cmake \
#         libtool \
#         libclang-dev  \
#         libpcsclite-dev \
#         libdvbv5-dev \
#         libudev-dev \
#         git \
#         curl \
#         ca-certificates \
#         pkg-config
#
# # cargo install
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y
# ENV PATH="/root/.cargo/bin:${PATH}"
#
# # libyakisoba
# RUN git clone https://github.com/tsunoda14/libyakisoba.git && \
#     cd libyakisoba && \
#     autoreconf -i && \
#     mkdir build && \
#     cd build && \
#     ../configure --sysconfdir /app-config && \
#     make && \
#     make install
#
# # sobacas
# RUN git clone https://github.com/tsunoda14/libsobacas.git   && \
#     cd libsobacas  && \
#     autoreconf -i  && \
#     mkdir build  && \
#     cd build  && \
#     ../configure  && \
#     make  && \
#     make install
#
# RUN git clone --recursive https://github.com/norikatsu/recisdb-rs.git && \
#     cd recisdb-rs && \
#     cargo build -F dvb --release


##### Build mirakurun
FROM ubuntu:24.04 AS build
WORKDIR /app
ENV DOCKER=YES NODE_ENV=production
ADD . .
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        build-essential \
        nodejs \
        npm \
        && \
    npm install --production=false && \
    npm run build && \
    npm install -g --unsafe-perm --production

##### Main image
FROM ubuntu:24.04
WORKDIR /app
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        build-essential \
        autoconf \
        automake \
        cmake \
        libtool \
        libclang-dev  \
        libpcsclite-dev \
        libccid \
        libdvbv5-dev \
        libudev-dev \
        git \
        curl \
        nodejs \
        npm \
        ca-certificates \
        make \
        gcc \
        g++ \
        pkg-config \
        pcscd \
        pcsc-tools \
        dvb-tools \
        pkg-config \
        && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# cargo install
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y
ENV PATH="/root/.cargo/bin:${PATH}"

# libyakisoba build & install
RUN git clone https://github.com/tsunoda14/libyakisoba.git && \
    cd libyakisoba && \
    autoreconf -i && \
    mkdir build && \
    cd build && \
    ../configure --sysconfdir /app-config && \
    make && \
    make install

# sobacas build & install
RUN git clone https://github.com/tsunoda14/libsobacas.git   && \
    cd libsobacas  && \
    autoreconf -i  && \
    mkdir build  && \
    cd build  && \
    ../configure  && \
    make  && \
    make install

RUN git clone --recursive https://github.com/norikatsu/recisdb-rs.git && \
    cd recisdb-rs && \
    cargo build -F dvb --release && \
    cp /app/recisdb-rs/target/release/recisdb /usr/local/bin/

# Remove libyakisoba & sobacas files
RUN rm -rf ./libyakisoba && \
    rm -rf ./libsobacas && \
    rm -rf ./recisdb-rs

# COPY mirakurun
COPY --from=build /usr/local/lib/node_modules/mirakurun /app
CMD ["./docker/container-init.sh"]
EXPOSE 40772 9229

FROM ubuntu:jammy as builder

WORKDIR /root
COPY    ./build.sh /root
RUN     /root/build.sh

FROM ubuntu:jammy
LABEL Author="Stroebs" Description="PtokaX DC++ Hub"

# Stop apt/dpkg from prompting for input
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root
COPY --from=builder --chown=root:root /root/PtokaX/PtokaX /usr/local/bin
COPY --from=builder --chown=www-data:www-data /root/PtokaX/cfg.example /cfg

# Ensure PtokaX can bind to tcp:411 as non-root
RUN apt-get update && \
    apt-get -y install libcap2-bin && \
    setcap 'cap_net_bind_service=+ep' /usr/local/bin/PtokaX && \
    dpkg --purge libcap2-bin libpam-cap && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 411/tcp
USER www-data

CMD ["/usr/local/bin/PtokaX", "-c", "/cfg"]

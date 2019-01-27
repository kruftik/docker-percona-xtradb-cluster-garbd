FROM debian:stretch-slim

ENV VERSION 5.7.24-31.33

ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -g 1001 mysql && \
    useradd -u 1001 -r -g 1001 -s /sbin/nologin -c "Default Application User" mysql && \
    apt-get update -qq && apt-get install -qqy --no-install-recommends \
    apt-transport-https ca-certificates pwgen wget gnupg2 && \
    wget https://repo.percona.com/apt/percona-release_0.1-6.stretch_all.deb && \
    dpkg -i percona-release_0.1-6.stretch_all.deb && \
    rm -rf *.deb && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && \
    apt-get install -qqy --force-yes netcat-openbsd libboost-program-options1.62.0 && \
    wget https://repo.percona.com/apt/pool/main/p/percona-xtradb-cluster-5.7/percona-xtradb-cluster-garbd-5.7_${VERSION}-1.stretch_amd64.deb && \
    dpkg -i percona-xtradb-cluster-garbd-5.7_${VERSION}-1.stretch_amd64.deb && \
    rm -rf *.deb && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

EXPOSE 3306 4567 4568

ENTRYPOINT ["/entrypoint.sh"]

USER 1001

CMD [""]

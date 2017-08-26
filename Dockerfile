FROM debian:jessie
MAINTAINER Razvan Crainea <razvan@opensips.org>

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV TLS 1
ARG VERSION=2.3

WORKDIR /usr/local/src

RUN apt-get update -qq && apt-get install -y ca-certificates && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 049AD65B && \
    echo "deb http://apt.opensips.org jessie $VERSION-releases" >>/etc/apt/sources.list && \
    apt-get update -qq && apt-get install -f -yqq --no-install-recommends rsyslog opensips opensips-json-module opensips-tls-module opensips-tlsmgm-module opensips-wss-module && \
    rm -rf /var/lib/apt/lists/* && \

    echo -e "local0.* -/var/log/opensips.log\n& stop" > /etc/rsyslog.d/opensips.conf && \
    touch /var/log/opensips.log

EXPOSE 5060/udp
EXPOSE 5061/tcp

COPY conf/opensips_tls.cfg /etc/opensips/opensips.cfg
COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]

FROM centos/systemd
ENV container=docker

COPY Rockstor.repo ZeroMQ.repo /etc/yum.repos.d/
COPY Rockstor.gpg /etc/pki/rpm-gpg/RPM-GPG-KEY-Rockstor

RUN yum update -y && \
    yum install -y https://centos7.iuscommunity.org/ius-release.rpm && \
    yum install -y rockstor NetworkManager && \
    sed -i 's/^inet_protocols = all$/inet_protocols = ipv4/g' /etc/postfix/main.cf

WORKDIR /opt/rockstor
CMD echo "nameserver 8.8.8.8" > /etc/resolv.conf && exec /usr/sbin/init
EXPOSE 80 443

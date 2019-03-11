FROM centos/systemd
ENV container=docker

COPY Rockstor.repo ZeroMQ.repo /etc/yum.repos.d/
COPY Rockstor.gpg /etc/pki/rpm-gpg/RPM-GPG-KEY-Rockstor

RUN yum update -y && \
    yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y rockstor git gcc gcc-c++ make python-devel zeromq-devel postgresql-devel file which grubby openssl man postgresql-server postgresql-contrib python-distro postgresql python-setuptools NetworkManager cryptsetup e2fsprogs
# Because we're going to use git
RUN yum remove -y rockstor docker-common
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum install -y docker-ce docker-ce-cli containerd.io

RUN mv /opt/rockstor /opt/rockstor-back
RUN git clone https://github.com/rockstor/rockstor-core /opt/rockstor
WORKDIR /opt/rockstor
RUN python /opt/rockstor/bootstrap.py -c /opt/rockstor/buildout.cfg
RUN /opt/rockstor/bin/buildout -N -c /opt/rockstor/buildout.cfg

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf 

# RUN systemctl disable NetworkManager
RUN mv /bin/hostnamectl /bin/hostnamectl-back
RUN ln -sv /bin/true /bin/hostnamectl

# Replace the docker service as we're using the hosts one instead
# We still need to allow it to start so rockstor doesn't
# get suspicious....
COPY ./docker.service /etc/systemd/system/docker.service

CMD exec /usr/sbin/init
EXPOSE 80 443

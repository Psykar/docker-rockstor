FROM opensuse/leap
RUN zypper --non-interactive install gcc python-devel gcc-c++ postgresql-devel libblkid-devel python-distro NetworkManager
RUN zypper --non-interactive install git which
RUN systemctl disable wicked
RUN systemctl enable NetworkManager


RUN git clone https://github.com/rockstor/rockstor-core /opt/rockstor-core
WORKDIR /opt/rockstor-core
RUN python /opt/rockstor-core/bootstrap.py -c /opt/rockstor-core/buildout.cfg
RUN zypper --non-interactive install systemd-sysvinit
RUN /opt/rockstor-core/bin/buildout -N -c /opt/rockstor-core/buildout.cfg

# RUN systemctl disable NetworkManager
# RUN mv /bin/hostnamectl /bin/hostnamectl-back
# RUN ln -sv /bin/true /bin/hostnamectl

CMD exec /usr/sbin/init

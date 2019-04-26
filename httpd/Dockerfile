FROM fedora:latest
RUN yum install -y expat-devel gcc make openssl openssl-devel pcre pcre-devel wget tar unzip findutils
COPY apr-1.7.0.tar.gz /root
COPY apr-util-1.6.1.tar.gz /root
COPY httpd-2.4.39.tar.gz /root
WORKDIR /root
RUN tar zxvf apr-1.7.0.tar.gz
RUN tar zxvf  apr-util-1.6.1.tar.gz
RUN tar zxvf httpd-2.4.39.tar.gz
RUn ln -s  apr-1.7.0 apr
RUN ln -s apr-util-1.6.1 apr-util
RUN ln -s httpd-2.4.39 httpd

WORKDIR /root/apr
RUN ./configure --prefix=/usr/local/apr
RUN make
RUN make install

WORKDIR /root/apr-util
RUN ./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr
RUN make
RUN make install

WORKDIR /root/httpd
RUN ./configure --prefix=/usr/local/httpd --with-mpm=worker --enable-mods-shared=most --enable-maintainer-mode --with-expat=builtin --enable-ssl --enable-proxy --enable-proxy-http --enable-proxy-ajp --disable-proxy-balancer --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util
# --with-included-apr
RUN make
RUN make install

RUN sed -i 's/^#ServerName.*/ServerName balancer-one.com:80/' /usr/local/httpd/conf/httpd.conf
RUN echo '127.0.0.1 balancer-one.com' >> /etc/hosts

COPY ProxyPass.txt /tmp
RUN cat /tmp/ProxyPass.txt >> /usr/local/httpd/conf/httpd.conf

CMD [ "/usr/local/httpd/bin/httpd", "-k", "start", "-f", "/usr/local/httpd/conf/httpd.conf", "-DFOREGROUND" ]

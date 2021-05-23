FROM tinyproxy-base:latest

WORKDIR /etc

# make /etc/tinyproxy as home
RUN   mkdir /etc/tinyproxy && \
      cd /etc/tinyproxy && \
      cp /usr/local/etc/tinyproxy/tinyproxy.conf ./

# collect entrypoint into image
COPY    entrypoint.sh /etc/tinyproxy/
RUN     chmod 755 /etc/tinyproxy/entrypoint.sh

ENTRYPOINT ["/etc/tinyproxy/entrypoint.sh"]

# publish port 8888
EXPOSE  8888
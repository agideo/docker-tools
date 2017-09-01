FROM nginx:stable

RUN set -ex \
  && apt-get update \
  && apt-get install -y --no-install-recommends ruby \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN set -ex \
  && mkdir -p /etc/nginx/main.d \
  && echo 'include /etc/nginx/main.d/*.conf;' >> /etc/nginx/nginx.conf

COPY http.conf.erb /etc/nginx/conf.d/
COPY https.conf.erb /etc/nginx/main.d/

EXPOSE 80 443

CMD ["/bin/bash", "-c", "erb /etc/nginx/conf.d/http.conf.erb > /etc/nginx/conf.d/default.conf \
                         && erb /etc/nginx/main.d/https.conf.erb > /etc/nginx/main.d/https.conf \
                         && nginx -g 'daemon off;'"]

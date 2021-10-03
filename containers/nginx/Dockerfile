FROM nginx:1.17

RUN apt-get update && apt-get install -y curl

RUN rm -f /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/myapp.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
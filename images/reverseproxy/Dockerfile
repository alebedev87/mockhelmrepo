FROM nginx

COPY default.conf.tmpl /default.conf.tmpl

CMD ["/bin/sh" , "-c" , "envsubst < /default.conf.tmpl > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]

FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y nginx zip

RUN cd projects/chicago-metro/
RUN bash deploy.sh

EXPOSE 80

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]


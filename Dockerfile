RUN yum update
RUN yum install -y nginx zip

RUN cd projects/chicago-metro/
RUN bash deploy.sh

EXPOSE 80

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]


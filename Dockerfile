FROM ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vim && \
    apt-get install -y \
        python3 \
        python3-dev \
        python3-setuptools \
        python3-pip \
        libsasl2-dev \
        libldap2-dev \
        libssl-dev \
        nginx && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /automation_center
COPY ./ ./
RUN pip3 install -r requirement.txt
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate
RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf-default
COPY ./config/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["sh", "-c", "uwsgi -i /automation_center/config/uwsgi.ini && nginx -g 'daemon off;'"]

FROM python:2.7
LABEL Name=francoburga/djangoapp Version=0.0.1 maintainer="franco.burga@gmail.com" 
ENV DJANGO_APP=**NULL**
ENV DJANGO_SECRET_KEY=**NULL**
ENV DJANGO_DEBUG=True
ENV GUNICORN_LOG_LEVEL=debug
ENV GUNICORN_WORKERS=3
ENV NGINX_PORT=80
ENV NGINX_HOST=_
ENV PIP_REQUIREMENTS_FILE=requirements.txt

VOLUME ["/app"]

RUN apt-get update \
&& apt-get install -yq nginx gettext \
&& pip install --upgrade pip \
&& pip install gunicorn

WORKDIR /app
EXPOSE 80

COPY default.template /nginx/default.template
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]

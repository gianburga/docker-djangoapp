# docker image:
gunicorn + django + nginx

## GUNICORN environment variables:
* GUNICORN_LOG_LEVEL default: 'debug'
* GUNICORN_WORKERS default: 3

## NGINX environment variables:
* NGINX_PORT default: 80
* NGINX_HOST default: _

## DJANGO APP environment variables:
* DJANGO_APP
* DJANGO_SECRET_KEY
* DJANGO_DEBUG

# docker compose:
haproxy + mongodb + gunicorn + django + nginx

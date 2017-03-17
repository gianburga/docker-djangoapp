#!/bin/bash
set -m

if [ -f /app/requirements.txt ]; then
    echo "*** install requirements ***"
    pip install -r /app/requirements.txt
else
    echo "requirements.txt not found!"
fi

if [ -f /app/manage.py ]; then
	echo "*** collectstatic ***"
	cd /app && python manage.py collectstatic --noinput
else
    echo "manage.py not found!"
fi

echo "- NGINX ENVS"
env | grep NGINX
envsubst < /nginx/default.template > /etc/nginx/sites-available/default

echo "- NGINX configuration check"
nginx -t
echo "- NGINX service restart"
service nginx restart && service nginx status

echo "GUNICORN ENVS"
env | grep GUNICORN
gunicorn $DJANGO_APP -w $GUNICORN_WORKERS --log-file - --log-level $GUNICORN_LOG_LEVEL

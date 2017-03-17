#!/bin/bash
set -m

if [ -f /app/$PIP_REQUIREMENTS_FILE ]; then
    echo "*** install ${PIP_REQUIREMENTS_FILE} file ***"
    pip install -r /app/$PIP_REQUIREMENTS_FILE
else
    echo "${PIP_REQUIREMENTS_FILE} not found!"
fi

if [ -f /app/manage.py ]; then
	echo "*** collectstatic ***"
	cd /app && python manage.py collectstatic --noinput
else
    echo "manage.py not found!"
fi

echo "*** NGINX environment variables ***"
env | grep NGINX
envsubst < /nginx/default.template > /etc/nginx/sites-available/default

echo "*** NGINX configuration check ***"
nginx -t
echo "*** NGINX service restart ***"
service nginx restart && service nginx status

echo "*** GUNICORN environment variables ***"
env | grep GUNICORN

echo "*** run django application ***"
gunicorn $DJANGO_APP -w $GUNICORN_WORKERS --log-file - --log-level $GUNICORN_LOG_LEVEL

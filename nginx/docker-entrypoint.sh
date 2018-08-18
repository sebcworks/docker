#!/bin/bash
set -e

#
# - Take host from link name: MUST BE "sonerezh-db"
# - Take database name from our own environment variable "MYSQL_DATABASE" (default to sonerezh)
# - Same for database user "MYSQL_USER" (default to sonerezh) 
# - Same for database password "MYSQL_PASSWORD" (but no default!)
#

if [ -z "$MYSQL_DATABASE" ]; then
	echo >&2 'error: missing required MYSQL_DATABASE environment variable'
	exit 1
fi

if [ -z "$MYSQL_USER" ]; then
	echo >&2 'error: missing required MYSQL_USER environment variable'
	exit 1
fi

if [ -z "$MYSQL_PASSWORD" ]; then
	echo >&2 'error: missing required MYSQL_PASSWORD environment variable'
	exit 1
fi

sed -i "s/SONEREZH_DB_PORT_3306_TCP_ADDR/sonerezh-db/" /usr/share/nginx/sonerezh/app/Config/database.php
sed -i "s/SONEREZH_DB_ENV_MYSQL_DATABASE/${MYSQL_DATABASE}/" /usr/share/nginx/sonerezh/app/Config/database.php
sed -i "s/SONEREZH_DB_ENV_MYSQL_USER/${MYSQL_USER}/" /usr/share/nginx/sonerezh/app/Config/database.php
sed -i "s/SONEREZH_DB_ENV_MYSQL_PASSWORD/${MYSQL_PASSWORD}/" /usr/share/nginx/sonerezh/app/Config/database.php
sed -i "s/define('DOCKER', false)/define('DOCKER', true)/" /usr/share/nginx/sonerezh/app/Config/bootstrap.php

exec "$@"

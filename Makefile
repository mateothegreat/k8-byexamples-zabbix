#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#
# https://hub.docker.com/r/zabbix/zabbix-appliance/
#
include .make/Makefile.inc

NS                  ?= default
APP                 ?= zabbix-server

DB_SERVER_HOST		?=
MYSQL_USER			?=
MYSQL_PASSWORD		?=
MYSQL_DATABASE		?=
PHP_TZ				?= America/Chicago

source-download:

	wget https://astuteinternet.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/3.4.10/zabbix-3.4.10.tar.gz
	tar -xvzf zabbix-3.4.10.tar.gz
	rm -rf zabbix-3.4.10.tar.gz

prepare: source-download

	mysql -h $(DB_SERVER_HOST) -u $(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE) < zabbix-3.4.10/database/mysql/schema.sql
	mysql -h $(DB_SERVER_HOST) -u $(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE) < zabbix-3.4.10/database/mysql/images.sql
	mysql -h $(DB_SERVER_HOST) -u $(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE) < zabbix-3.4.10/database/mysql/data.sql

	rm -rf zabbix-3.4.10
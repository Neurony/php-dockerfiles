#
#	Docker build instructions via Dockerfile
#

php:		php\:7.0		php\:7.1		php\:7.2		php\:7.3		php\:7.4		php\:8.0		php\:8.1

php\:7.0:	php-base\:7.0	php-cli\:7.0	php-fpm\:7.0	php-qa\:7.0		php-dev\:7.0
php\:7.1:	php-base\:7.1	php-cli\:7.1	php-fpm\:7.1	php-qa\:7.1		php-dev\:7.1
php\:7.2:	php-base\:7.2	php-cli\:7.2	php-fpm\:7.2	php-qa\:7.2		php-dev\:7.2
php\:7.3:	php-base\:7.3	php-cli\:7.3	php-fpm\:7.3	php-qa\:7.3		php-dev\:7.3
php\:7.4:	php-base\:7.4	php-cli\:7.4	php-fpm\:7.4	php-qa\:7.4		php-dev\:7.4
php\:8.0:	php-base\:8.0	php-cli\:8.0	php-fpm\:8.0	php-qa\:8.0		php-dev\:8.0
php\:8.1:	php-base\:8.1	php-cli\:8.1	php-fpm\:8.1	php-qa\:8.1		php-dev\:8.1

php-base:	php-base\:7.0	php-base\:7.1	php-base\:7.2	php-base\:7.3	php-base\:7.4	php-base\:8.0	php-base\:8.1
php-cli:	php-cli\:7.0	php-cli\:7.1	php-cli\:7.2	php-cli\:7.3	php-cli\:7.4	php-cli\:8.0	php-cli\:8.1
php-fpm:	php-fpm\:7.0	php-fpm\:7.1	php-fpm\:7.2	php-fpm\:7.3	php-fpm\:7.4	php-fpm\:8.0	php-fpm\:8.1
php-qa:		php-qa\:7.0		php-qa\:7.1		php-qa\:7.2		php-qa\:7.3		php-qa\:7.4		php-qa\:8.0		php-qa\:8.1
php-dev:	php-dev\:7.0	php-dev\:7.1	php-dev\:7.2	php-dev\:7.3	php-dev\:7.4	php-dev\:8.0	php-dev\:8.1

php-base\:%: php-base.Dockerfile
	docker build	--file $<																							\
					--tag $@																							\
					--build-arg VS=$*																					\
					--build-arg "BASE=20.04"																			\
					.																									\
	;
php-cli\:%: php-cli.Dockerfile
	docker build	--file $<																							\
					--tag $@																							\
					--build-arg VS=$*																					\
					.																									\
	;
php-fpm\:%: php-fpm.Dockerfile php-cli\:%
	docker build	--file $<																							\
					--tag $@																							\
					--build-arg VS=$*																					\
					.																									\
	;
php-qa\:%: php-qa.Dockerfile php-fpm\:%
	docker build	--file $<																							\
					--tag $@																							\
					--build-arg VS=$*																					\
					.																									\
	;
php-dev\:%: php-dev.Dockerfile php-qa\:% tools/php-serve
	docker build	--file $<																							\
					--tag $@																							\
					--build-arg VS=$*																					\
					.																									\
	;


#
#	Build all & push all instructions
#

all:	php

push-all:
	docker push --all-tags php-cli;
	docker push --all-tags php-fpm;
	docker push --all-tags php-qa;
	docker push --all-tags php-dev;

#!/bin/bash -ex

set -ex;

source common.sh;

VS=$1; shift;

if [[ "$VS" > "7.0" ]]; then
	nrn-add-packages																														\
			php$VS-pcov																															\
	;
	phpenmod																																		\
		pcov																																			\
	;
fi

curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
nrn-add-packages																															\
		gettext																																		\
		nodejs																																		\
;
npm install -g yarn

curl -fsSL -o /usr/local/bin/local-php-security-checker												\
 https://github.com/fabpot/local-php-security-checker/releases/download/v1.2.0/local-php-security-checker_1.2.0_linux_amd64
curl -fsSL -o /usr/local/bin/wait-until https://raw.githubusercontent.com/nickjj/wait-until/v0.2.0/wait-until

if [[ "$VS" > "7.3" ]]; then
  curl -fsSL -o /usr/local/bin/composer https://github.com/composer/composer/releases/download/2.2.6/composer.phar;
else
  curl -fsSL -o /usr/local/bin/composer https://github.com/composer/composer/releases/download/1.10.25/composer.phar;
fi
chmod +x /usr/local/bin/*;

composer self-update;
composer global config -- bin-dir /usr/local/bin
composer global config -- allow-plugins true || true;
composer global require bamarni/composer-bin-plugin;
if [[ "$VS" < "7.1" ]]; then
  composer global require hirak/prestissimo;
fi

composer global bin codecept									require codeception/codeception;
composer global bin composer-require-checker	require maglnet/composer-require-checker;
composer global bin infection									require infection/infection;
composer global bin phpmnd										require povils/phpmnd;
composer global bin phpunit										require 												\
		phpunit/phpunit																														\
		sebastian/phpcpd																													\
		phploc/phploc																															\
		brianium/paratest																													\
;
composer global bin phplint										require overtrue/phplint;
composer global bin phpstan										require phpstan/phpstan;

if [[ "$VS" > "7.0" ]]; then
	composer global bin composer-unused					require icanhazstring/composer-unused;
	composer global bin phpat										require phpat/phpat;
	composer global bin psalm										require psalm/plugin-laravel;
fi
if [[ "$VS" > "7.2" ]]; then
	composer global bin phpstan									require													\
			nunomaduro/larastan																											\
			ekino/phpstan-banned-code																								\
	;
	composer global bin phpinsights								require nunomaduro/phpinsights;
fi

rm -fr /root/.composer/cache/*;

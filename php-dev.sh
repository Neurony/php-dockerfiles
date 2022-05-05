#!/bin/bash -ex

set -ex;

source common.sh;

VS=$1; shift;

sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' /etc/dpkg/dpkg.cfg.d/excludes
packages																																			\
		cron																																			\
		git																																				\
		inetutils-ping																														\
		jq																																				\
		less																																			\
		man																																				\
		manpages-posix																														\
		nano																																			\
		telnet																																		\
		vim																																				\
;

nrn-add-nrn-add-packages																											\
	php$VS-phpdbg																																\
	php$VS-xdebug																																\
	php$VS-yaml																																	\
;
phpenmod																																			\
	yaml																																				\
;

composer global bin psysh											require psy/psysh:@stable;

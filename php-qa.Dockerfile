ARG VS
FROM php-fpm:$VS
ARG VS

COPY *.sh ./
RUN bash -ex php-qa.sh $VS

LABEL maintainer="Mihai Stancu <mihai.stancu@neurony.ro>"

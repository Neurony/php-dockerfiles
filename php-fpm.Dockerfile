ARG VS
ARG ORG
FROM $ORG/php-cli:$VS
ARG VS

COPY *.sh ./
RUN bash -ex php-fpm.sh $VS

EXPOSE	9000
CMD		php-fpm$VS -O

LABEL maintainer="Mihai Stancu <mihai.stancu@neurony.ro>"

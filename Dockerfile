FROM python:3.12.5-alpine3.20

RUN apk add --update build-base \
    openssl    \
    && wget -O- https://bootstrap.pypa.io/get-pip.py | python \
    && pip install --no-cache-dir twisted \
    && apk del --purge build-base \
    openssl    \
    && rm -rf /var/cache/apk/*

ENV MAIL_NAME=
ENV MAIL_PATH=/var/mail
ENV MAIL_USER=
ENV MAIL_PASS=
ENV MAIL_OPTS=

VOLUME /var/mail
EXPOSE 25 110

CMD twistd -n mail --smtp=tcp:25 \
    --pop3=tcp:110 \
    --maildirdbmdomain=$MAIL_NAME=$MAIL_PATH \
    --user=$MAIL_USER=$MAIL_PASS \
    --bounce-to-postmaster \
    $MAIL_OPTS

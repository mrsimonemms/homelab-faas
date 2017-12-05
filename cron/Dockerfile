FROM alpine:3.6

ARG SUPERCRONIC_VERSION=0.1.4
ARG SUPERCRONIC_SHA1SUM=3a631023f9f9dd155cfa0d1bb517a063d375055a

ENV SUPERCRONIC=supercronic-linux-amd64

WORKDIR /opt/cron

VOLUME /opt/cron

RUN apk add --no-cache curl \
  && curl -fsSLO "https://github.com/aptible/supercronic/releases/download/v${SUPERCRONIC_VERSION}/${SUPERCRONIC}" \
  && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
  && chmod +x "$SUPERCRONIC" \
  && mv "$SUPERCRONIC" "/usr/local/bin/supercronic" \
  && apk del curl

CMD [ "supercronic", "/opt/cron/crontab" ]

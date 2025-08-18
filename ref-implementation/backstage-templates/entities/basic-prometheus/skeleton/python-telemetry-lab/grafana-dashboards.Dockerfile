FROM alpine:3.20

RUN apk add --no-cache curl

COPY grafana-data/ /grafana/

WORKDIR /grafana

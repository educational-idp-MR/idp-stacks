#!/bin/sh

cd python-telemetry-lab
dockerd &
sleep 5
docker pull alpine:3.20
docker pull grafana/grafana:11.6.1
docker pull prom/prometheus:v3.3.0
sleep 5
docker-compose up -d
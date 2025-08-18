FROM prom/prometheus:v3.3.0

COPY prometheus.yaml /etc/prometheus/prometheus.yaml

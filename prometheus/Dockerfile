FROM prom/prometheus:v1.5.1

COPY prometheus.yml /config/

CMD [ "-config.file=/config/prometheus.yml", \
      "-storage.local.path=/prometheus", \
      "-web.console.libraries=/etc/prometheus/console_libraries", \
      "-web.console.templates=/etc/prometheus/consoles" ]


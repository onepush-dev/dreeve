# Dreeve on Railway: the official ghcr.io/dreeveapp/dreeve:v5.9.1 image (AGPL-3.0), application unmodified.
# Railway layer: one service runs the web server and the background daemon (upstream uses two containers sharing volumes),
# keeps watch/ and backups/ on the single volume, hashes the generated admin password at boot, and bakes the non-secret defaults.
FROM ghcr.io/dreeveapp/dreeve:v5.9.1
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/dreeve"
COPY railway/start.sh /railway-start.sh
RUN chmod +x /railway-start.sh
ENV IMPORT_MODE=files \
    TZ=UTC \
    ADMIN_USERNAME=admin
EXPOSE 8080
ENTRYPOINT []
CMD ["/railway-start.sh"]

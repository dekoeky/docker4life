FROM eclipse-mosquitto:latest
RUN addgroup -S app && adduser -S app -G app
USER app
WORKDIR /app
COPY --chown=app:app ./app.sh .
RUN chmod +x ./app.sh
ENTRYPOINT [ "/bin/sh", "-c", "./app.sh" ]
STOPSIGNAL SIGTERM
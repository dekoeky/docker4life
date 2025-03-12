FROM alpine:latest

# Install curl (no-cache keeps image size small)
RUN apk add --no-cache curl

# Copy script into container
COPY app.sh /opt/app.sh

# Ensure script is executable
RUN chmod +x /opt/app.sh

# Run the script
CMD ["sh", "/opt/app.sh"]
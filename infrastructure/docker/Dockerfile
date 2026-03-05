FROM alpine:3.18

# Install dependencies
RUN apk add --no-cache curl bash aws-cli jq

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

WORKDIR /app

# Copy scripts
COPY src/main/scripts/backup.sh src/main/scripts/restore.sh ./
RUN chmod +x backup.sh restore.sh

# Default command
CMD ["/bin/bash"]

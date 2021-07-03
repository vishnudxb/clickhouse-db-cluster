FROM ubuntu:latest

WORKDIR /app

COPY . .

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
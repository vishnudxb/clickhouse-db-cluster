FROM ubuntu:latest

WORKDIR /app

COPY . .

RUN chmod +x /app/entrypoint.sh

RUN apt-get update && \
    apt-get install make wget curl

ENTRYPOINT ["/app/entrypoint.sh"]
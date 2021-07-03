FROM ubuntu:latest

WORKDIR /app

COPY . .

RUN chmod +x /app/entrypoint.sh

RUN apt-get update && \
    apt-get install make

ENTRYPOINT ["/app/entrypoint.sh"]
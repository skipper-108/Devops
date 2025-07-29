FROM node:13-alpine

ENV MOMGO_DB_USERNAME=admin \
    MOMGO_DB_PASSWORD=admin 

RUN mkdir -p /home/app

COPY . /home/app

CMD ["node", "server.js "]

#doker build -t my-app:1.0 
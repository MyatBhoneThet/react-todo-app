# syntax=docker/dockerfile:1
FROM node:12-alpine

RUN apk add --no-cache python3 make g++ \
    && ln -sf /usr/bin/python3 /usr/bin/python

WORKDIR /app

COPY package*.json ./

RUN yarn install --production

COPY . .

CMD ["node", "src/index.js"]

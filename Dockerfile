FROM node:alpine
RUN mkdir /app
WORKDIR /app
COPY . /app

ENV HOST 0.0.0.0
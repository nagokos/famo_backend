FROM node:17.0

RUN mkdir -p /myapp
WORKDIR /myapp

COPY package.json ./
COPY yarn.lock ./

RUN yarn global add @vue/cli

RUN yarn install
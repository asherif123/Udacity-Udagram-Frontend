# docker build . -t a-sherif/udagram-frontend
# docker run --env-file env.list -p 8080:8080 --rm -d a-sherif/udagram-frontend

FROM node:16-alpine as build

WORKDIR /app

COPY package*.json /app/

RUN npm install -g ionic
RUN npm install

COPY ./ /app/

RUN npm run-script build:prod

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/www/ /usr/share/nginx/html/
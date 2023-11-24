FROM node:18.12.1-alpine3.16 as nodeimagem

WORKDIR /app

COPY package.json /app

RUN npm install --silent

COPY . .

RUN npm run build

FROM nginx:alpine

VOLUME /var/cache/nginx

COPY --from=nodeimagem app/dist/monitoraai /usr/share/nginx/html/monitora-ai

COPY ./nginx/default.conf  /etc/nginx/conf.d/default.conf


# docker build -t monitora-ai .
# docker run -p 8081:80 monitora-ai
# docker-compose -f docker-compose.yml up -d --build
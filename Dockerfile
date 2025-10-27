FROM node:18-alpine AS build
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

FROM nginx:1.28.0-alpine
COPY --from=build /app/dist /usr/share/nginx/html
RUN sed -i '/http {/a \    server_tokens off;' /etc/nginx/nginx.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]

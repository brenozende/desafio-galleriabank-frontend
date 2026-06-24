FROM node:22-alpine AS build

WORKDIR /app

RUN apk add --no-cache git

ARG REPO_URL
RUN git clone ${REPO_URL} .

RUN npm install
RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
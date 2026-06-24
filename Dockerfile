FROM node:20-alpine AS build

WORKDIR /app

RUN apk add --no-cache git

ARG REPO_URL

RUN git clone ${REPO_URL} .

RUN npm install
RUN npm run build

FROM node:20-alpine

WORKDIR /app

RUN npm install -g http-server

COPY --from=build /app/dist ./dist

EXPOSE 4200

CMD ["http-server", "dist", "-p", "4200", "-a", "0.0.0.0"]
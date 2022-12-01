FROM node:16-slim as builder
WORKDIR /build

COPY package.json .
COPY yarn.lock .
RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.13-alpine
COPY --from=builder /build/dist /usr/share/nginx/html

FROM node:8-jessie as builder
RUN npm install -g yarn
WORKDIR /build

COPY package.json .
COPY yarn.lock .
RUN yarn install

COPY . .

RUN yarn build

FROM nginx:1.13-alpine
COPY --from=builder /build/dist /usr/share/nginx/html

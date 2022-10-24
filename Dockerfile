##################
# Build stage
##################

FROM node:16.17.1-alpine3.16 AS builder

WORKDIR /app

COPY nest-cli.json tsconfig.json tsconfig.prod.build.json tsconfig.build.json package.json yarn.lock ./

RUN yarn

COPY ./src ./src

RUN yarn build



##################
# Deploy stage
##################
FROM node:16.17.1-alpine3.16 AS deployer

RUN npm i -g pm2

WORKDIR /app

COPY pm2.config.js package.json yarn.lock ./

RUN yarn install --prod

COPY --from=builder /app/dist ./dist

ENTRYPOINT ["pm2-runtime", "start", "pm2.config.js"]
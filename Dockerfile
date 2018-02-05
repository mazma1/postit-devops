#job 1: build application
FROM node:alpine AS build
RUN mkdir -p /usr/src/post-it/
WORKDIR /usr/src/post-it

COPY package.json ./
RUN npm install

COPY . ./
RUN npm run production


#Job 2: build image using artifacts from job 1
FROM node:6.11.2
RUN mkdir -p /usr/src/post-it/
WORKDIR /usr/src/post-it

COPY --from=build /usr/src/post-it/app/client/dist ./app/client/dist
COPY --from=build /usr/src/post-it/app/server/dist ./app/server/dist
COPY package.json ./
COPY .sequelizerc ./
COPY webpack.config.prod.js ./

EXPOSE 3000
RUN npm install
ENV NODE_ENV=production
ENV DATABASE_URL=postgres://tcxhnteqhkstgo:ea4213bef22260fad45241f2aaa33b6c9e3b2a48ee87a2c139a1e06ee74e2ce1@ec2-23-23-159-84.compute-1.amazonaws.com:5432/dd9sal0h5ihs8s
CMD ["npm", "start"]
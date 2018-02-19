#job 1: build application
FROM node:alpine AS build
RUN mkdir -p /usr/src/post-it/
WORKDIR /usr/src/post-it

COPY package.json ./
RUN npm install

COPY . ./
RUN npm run production


#Job 2: build image using artifacts from job 1
FROM node:alpine
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
ENV DATABASE_URL=postgres://apvyqqyw:_gRRoT-VhKF4CCwJ1iE9spmjuk-BG-O2@baasu.db.elephantsql.com:5432/apvyqqyw
CMD ["npm", "start"]
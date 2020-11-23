FROM node:latest as build-stage
WORKDIR /app
COPY package*.json /app
RUN yarn install
COPY ./ /app/
CMD ["yarn", "run", "start"]
EXPOSE 3000/tcp

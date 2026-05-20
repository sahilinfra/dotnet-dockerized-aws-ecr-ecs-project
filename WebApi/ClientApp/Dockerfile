FROM node:19.5.0-alpine AS build
ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV
WORKDIR /app
COPY WebApi/ClientApp/package*.json ./
COPY WebApi/ClientApp/ ./
RUN npm install
COPY . ./
CMD ["npm", "start"]

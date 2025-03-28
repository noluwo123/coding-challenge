FROM node:16-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

# We'll need to modify this for production deployment
# But for now, we'll set up a development build
ENV NODE_ENV=development

EXPOSE 3000

CMD ["npm", "start"]
# FROM node:16-alpine as build

# WORKDIR /app

# COPY package*.json ./
# RUN npm ci

# COPY . .

# # We'll need to modify this for production deployment
# # But for now, we'll set up a development build
# ENV NODE_ENV=development

# EXPOSE 3000

# CMD ["npm", "start"]

# Stage 1: Build the React app
FROM node:16-alpine AS build
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install --production
COPY frontend/. . 
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:1.21-alpine
COPY --from=build /app/build /usr/share/nginx/html
# Copy a basic nginx config to handle routing (if needed)
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf 
# Expose port 80 for the Nginx web server
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# FROM node:16-alpine

# WORKDIR /app

# COPY package*.json ./
# RUN npm ci

# COPY . .

# EXPOSE 8080

# CMD ["npm", "start"]

FROM node:16-alpine
WORKDIR /app
COPY backend/package*.json ./
RUN npm install --production
COPY backend/. .
# Expose the port that the Express app listens on (e.g., 3000)
EXPOSE 3000
CMD ["npm", "start"]

# ---------- Stage 1: Build ----------
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files first
COPY package*.json ./

RUN npm install

# Copy all source files and build the production app
COPY . .
RUN npm run build

# ---------- Stage 2: NGINX ----------
FROM nginx:1.27-alpine

# Copy build output to NGINX html directory
COPY --from=build /app/build /usr/share/nginx/html

# Optional: replace default NGINX config for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


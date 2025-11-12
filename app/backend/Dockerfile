# ---------- Stage 1: Build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy source code
COPY . .

# ---------- Stage 2: Runtime ----------
FROM node:20-alpine

WORKDIR /app

# Copy built files and node_modules from builder
COPY --from=builder /app /app

EXPOSE 8080

CMD ["node", "server.js"]


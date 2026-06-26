FROM node:20-slim AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

FROM node:20-slim

WORKDIR /app
RUN addgroup --system app && adduser --system --group app

COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
COPY src/ ./src/
COPY db/ ./db/

USER app

EXPOSE 3000
CMD ["node", "src/server.js"]
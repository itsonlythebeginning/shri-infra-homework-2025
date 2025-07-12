# Этап 1: Сборка проекта с Node.js 20
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Этап 2: Финальный образ для запуска на Node.js 20
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY --from=builder /app/build ./build
COPY --from=builder /app/server ./server
EXPOSE 3000
CMD ["npm", "start"]
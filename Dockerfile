# ============================================================
# AI-Generated Dockerfile
# Language: nodejs | Framework: express
# Builder: node:20-slim → Runtime: node:20-slim
# ============================================================

FROM node:20-slim AS builder
WORKDIR /app
COPY package*.json package-lock.json ./
RUN npm install --production
COPY . .


FROM node:20-slim
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /app ./
USER appuser
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1
CMD ["npm", "start"]
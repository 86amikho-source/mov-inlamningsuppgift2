FROM node:20-alpine AS build
WORKDIR /app
COPY app/package.json ./
RUN npm ci --omit=dev || npm install --omit=dev
COPY app/ ./

FROM node:20-alpine
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=build /app /app
ENV NODE_ENV=production PORT=8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1:$PORT/healthz || exit 1
EXPOSE 8080
USER appuser
CMD [ "node", "server.js" ]

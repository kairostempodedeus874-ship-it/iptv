FROM node:22-slim

ENV NODE_ENV=production
ENV PORT=3000
ENV WPP_AUTH_DIR=/var/data/auth

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends python3 make g++ ca-certificates curl \
  && rm -rf /var/lib/apt/lists/*

COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund

COPY . .

RUN mkdir -p /var/data/auth

EXPOSE 3000

CMD ["node", "server.js"]
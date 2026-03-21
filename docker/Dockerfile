FROM node:20-alpine

# Install system tools needed by rooms and node-pty
# hadolint ignore=DL3018
RUN apk add --no-cache \
  bash \
  python3 \
  make \
  g++ \
  coreutils \
  curl \
  vim \
  less \
  grep \
  sed \
  gawk \
  findutils \
  tree \
  openssl \
  shadow \
  sudo

WORKDIR /app

# ── Node.js app ───────────────────────────────────────────────────────────────
# Build context is the repo root (docker-compose: context: ..)
COPY docker/package.json ./
RUN npm install --omit=dev

COPY docker/server.js  ./
COPY docker/public/    ./public/

# ── Escape room content ───────────────────────────────────────────────────────
# Copied to /app/rooms/ - entrypoint.sh installs them to /home/escape/escapeRooms/
COPY content/escapeRoom/ ./rooms/

# ── Pre-built mkdocs documentation (served at /docs/) ────────────────────────
# Run `mkdocs build` before `docker build` to generate mkdocs-site/
COPY mkdocs-site/ ./docs/

# ── Entrypoint ────────────────────────────────────────────────────────────────
COPY docker/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

LABEL org.opencontainers.image.description="Interactive Bash Escape Room - learn Bash scripting by solving puzzles in a browser-based terminal"

EXPOSE 3000

ENV SHELL=/bin/bash

# ── Shell aliases ─────────────────────────────────────────────────────────────
RUN echo "alias ll='ls -lah'"  >> /etc/profile.d/aliases.sh && \
  echo "alias la='ls -laF'"  >> /etc/profile.d/aliases.sh && \
  echo "alias l='ls -lAh'"   >> /etc/profile.d/aliases.sh

ENTRYPOINT ["/app/entrypoint.sh"]

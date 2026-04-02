# ── Stage 1: build node-pty (shared framework builder) ───────────────────────
FROM node:20-alpine AS builder

# hadolint ignore=DL3018
RUN apk add --no-cache python3 make g++

WORKDIR /app
COPY .escaperoom-framework/package.json ./
RUN npm install --omit=dev

# ── Stage 2: runtime image ────────────────────────────────────────────────────
FROM node:20-alpine

# Install only runtime tools needed by the escape room
# hadolint ignore=DL3018
RUN apk add --no-cache \
  bash \
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

# ── Copy shared framework (server, UI, node_modules) ─────────────────────────
COPY --from=builder /app/node_modules           ./node_modules
COPY .escaperoom-framework/package.json         ./
COPY .escaperoom-framework/server.js            ./
COPY .escaperoom-framework/public/              ./public/

# ── Room-specific ENV vars for the framework server ──────────────────────────
ENV ROOM_NAME="Bash Escape Room" \
    ROOM_TITLE="Bash Escape Room" \
    TOTAL_ROOMS="56" \
    ACCENT_COLOR="#e94560" \
    ACCENT2_COLOR="#1abc9c" \
    BG_DEEP="#0d0d1a" \
    BG_PANEL="#12122a" \
    BG_HEADER="#0a0a1f" \
    BORDER_COLOR="#1e1e3f" \
    FALLBACK_DOCS_URL="https://nirgeier.github.io/Bash-EscapeRoom/"

# ── Escape room content ───────────────────────────────────────────────────────
COPY content/escapeRoom/ ./rooms/

# ── Passwords file (single source of truth for README encryption) ─────────────
COPY mkdocs/passwords.yml ./passwords.yml

# ── Room setup (build time) ───────────────────────────────────────────────────
# Encrypt READMEs, rename scripts, build archive, set wrong permissions.
# Done here so the entrypoint only creates the user and starts servers.
RUN set -e; \
  \
  # ── Remove solution and setup files (not for players) ──────────────────── \
  find ./rooms -name "_solution.sh" -delete; \
  find ./rooms -name "setup.sh"     -delete; \
  find ./rooms -name "README"       -delete; \
  \
  # ── Encrypt READMEs using passwords.yml as source of truth ─────────────── \
  # Parse "rooms/Room-NN.md": "password" and generate encrypt commands       \
  awk '/rooms\/Room-[0-9]+\.md/{                                              \
  match($0, /Room-([0-9]+)\.md.*"([^"]+)"/, a);                          \
  num=a[1]+0;                                                             \
  printf "room_dir=\"room_%02d\"; readme=\"./rooms/$room_dir/README\"; ", num; \
  printf "[ -f \"$readme\" ] && ";                                        \
  printf "openssl enc -aes-256-cbc -a -salt -pbkdf2 -in \"$readme\" -out \"${readme}.enc\" -pass pass:\"%s\" 2>/dev/null", a[2]; \
  printf " && mv \"${readme}.enc\" \"$readme\" || true\n"                 \
  }' ./passwords.yml > /tmp/encrypt_rooms.sh; \
  sh /tmp/encrypt_rooms.sh; \
  rm ./passwords.yml /tmp/encrypt_rooms.sh; \
  \
  # ── Room 07 - set deliberately wrong gate permissions ──────────────────── \
  chmod 000 ./rooms/room_07/gate_1; \
  chmod 777 ./rooms/room_07/gate_2; \
  chmod 644 ./rooms/room_07/gate_3; \
  chmod 755 ./rooms/room_07/gate_4; \
  chmod 000 ./rooms/room_07/gate_5; \
  chmod 777 ./rooms/room_07/gate_6; \
  chmod 644 ./rooms/room_07/gate_7; \
  mv ./rooms/room_07/script.sh ./rooms/room_07/getKey.sh; \
  chmod +x ./rooms/room_07/getKey.sh; \
  \
  # ── Rooms 08, 09, 32, 44, 50, 51, 54 - rename validation scripts ───────── \
  for room in room_08 room_09 room_32 room_44 room_50 room_51 room_54; do \
  [ -f "./rooms/$room/script.sh" ] && \
  mv "./rooms/$room/script.sh" "./rooms/$room/getKey.sh" && \
  chmod +x "./rooms/$room/getKey.sh" || true; \
  done; \
  \
  # ── Room 11 - wrap secret_scroll.txt in tar → gzip → base64 ────────────── \
  cd ./rooms/room_11; \
  tar cf secret.tar secret_scroll.txt; \
  gzip secret.tar; \
  base64 secret.tar.gz > artifact.b64; \
  rm -f secret_scroll.txt secret.tar.gz; \
  cd /app

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

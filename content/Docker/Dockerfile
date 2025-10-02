# ====================================================================
# Stage 1: Builder - Install tools and prepare the escape room
# ====================================================================
FROM   alpine:3.18 AS builder

USER root

# Install all required packages for Alpine
RUN apk update && \
  apk add --no-cache \
  attr \
  autoconf \
  automake \
  bash \
  curl \
  file \
  gcc \
  make \
  musl-dev \
  nodejs \
  npm \
  shadow \
  sudo \
  vim \
  zip && \
  cd /tmp && \
  curl -L https://github.com/neurobin/shc/archive/refs/tags/4.0.3.tar.gz -o shc.tar.gz && \
  tar xzf shc.tar.gz && \
  cd shc-4.0.3 && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install && \
  cd / && \
  rm -rf /tmp/shc* && \
  # Install the required library for obfuscating
  npm -g install javascript-obfuscator && \
  # Clean npm cache
  npm cache clean --force

# Create users (Alpine way)
RUN adduser -D -s /bin/bash escape && \
  echo "root:escaperoom" | chpasswd && \
  echo "escape:escape" | chpasswd && \
  addgroup escape wheel && \
  echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel

WORKDIR /home/escape

# Copy the desired content
COPY escapeRoom escapeRooms
COPY Docker/initEscapeRoom.sh ./initEscapeRoom.sh

# Init the room puzzle
RUN chmod 755 initEscapeRoom.sh && \
  ./initEscapeRoom.sh && \
  rm initEscapeRoom.sh

# ====================================================================
# Stage 2: Runtime - Minimal final image with only necessary files
# ====================================================================
FROM    alpine:3.18

USER root

# add community (example for v3.18) and edge/testing so cowsay is available
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install only runtime dependencies needed for the escape room
# Removed: build-essential, nodejs, npm, shc, zip (build-time only)
RUN apk update && \
  apk add --no-cache \
  attr      \
  bash      \
  cowsay    \
  curl      \
  file      \
  libcap    \
  man-pages \
  newt      \
  shadow    \
  sudo      \
  unzip     \
  vim       

# Create the same users
RUN adduser -D -s /bin/bash escape && \
  echo "root:escaperoom" | chpasswd && \
  echo "escape:escape" | chpasswd && \
  addgroup escape wheel && \
  echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel

WORKDIR /home/escape

# Copy only the processed escape room from builder stage
COPY --from=builder --chown=escape:escape /home/escape/escapeRooms escapeRooms
# Copy the passwd and group files to ensure user consistency
COPY --from=builder --chown=root:root /etc/passwd /etc/passwd
COPY --from=builder --chown=root:root /etc/group  /etc/group

# Switch to the escape user
USER escape

# Copy entrypoint script
COPY --chmod=705 Docker/entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh"]

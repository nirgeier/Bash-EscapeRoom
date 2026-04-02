#!/usr/bin/env bash
: <<'DOC'
build.sh
---------
Small helper for building and pushing a multi-architecture Docker image
for the Bash Escape Room project using Docker Buildx and a docker-compose
build definition.

What this script does (high level):
	1. Locates the git repository root and cd's there so paths are predictable.
	2. Ensures the host supports emulating other CPU architectures by
		 registering binfmt handlers (via tonistiigi/binfmt).
	3. Creates and switches to a docker buildx builder instance named
		 `multiarch-builder` and bootstraps it.
	4. Runs `docker buildx bake` with the project's docker-compose.yml to
		 build and push the image(s) defined in that file.

Usage:
	./build.sh              # build + push all platforms (default)
	./build.sh --local      # build for local arch only (no push, loads into docker)
	./build.sh --push       # explicitly build + push all platforms

Requirements / Preconditions:
	- Docker (Engine) installed and running on the host
	- docker buildx available (Docker >= 19.03 with buildx plugin or
		Docker Desktop which bundles it)
	- You must be logged in to the GitHub Container Registry:
		echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
	- You must be logged in to Docker Hub:
		docker login -u USERNAME
	- This script must be executed from a git working tree (it uses
		`git rev-parse --show-toplevel` to find the project root).

Notes / Behavior details:
	- The script uses the container image `tonistiigi/binfmt` to register
		qemu/binfmt handlers for cross-architecture emulation. That requires
		`--privileged` to the runner container (the temporary container).
	- This script creates a buildx builder named `multiarch-builder` and
		switches the current Docker context to use it. If you run this script
		multiple times, buildx will silently re-use an existing builder
		with the same name, or fail if it exists in a conflicting state.
	- The final build step uses `docker buildx bake` with the
		`docker/docker-compose.yml` file and targets the service
		named `escape-room-bash` (this is defined in the repo's compose file).

Customization:
	- You can change the image name and tag by exporting IMAGE and IMAGE_TAG
		before running the script, e.g.:
			IMAGE=ghcr.io/nirgeier/bash-escaperoom IMAGE_TAG=v1.2.3 ./build.sh

Failure modes:
	- If Docker is not running, commands will fail.
	- If `git rev-parse` fails (not a git repo), the script will abort.
	- If you are not logged into ghcr.io, the push step will fail.

DOC

set -euo pipefail

# ── Parse arguments ───────────────────────────────────────────────────────────
LOCAL=false
for arg in "$@"; do
  case $arg in
    --local) LOCAL=true ;;
    --push)  LOCAL=false ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

# ── Resolve repo root ─────────────────────────────────────────────────────────
ROOT_DIR=$(git rev-parse --show-toplevel)
cd "$ROOT_DIR"

# ── Variables ─────────────────────────────────────────────────────────────────
IMAGE=${IMAGE:-ghcr.io/nirgeier/bash-escaperoom}
IMAGE_TAG=${IMAGE_TAG:-latest}
DOCKERHUB_IMAGE=${DOCKERHUB_IMAGE:-nirgeier/bash-escaperoom}
BUILD_TIME=$(date +"%Y-%m-%dT%H:%M:%SZ")
SourceRepository=$(git config --local --get remote.origin.url)

echo ""
echo "  Image  : ${IMAGE}:${IMAGE_TAG}"
echo "  Mode   : $([ "$LOCAL" = true ] && echo 'local (current arch only)' || echo 'multi-platform push')"
echo "  Root   : ${ROOT_DIR}"
echo ""

# ── Step 1: Check mkdocs site ─────────────────────────────────────────────────
echo "[1/4] Checking mkdocs site..."
if [ ! -d "$ROOT_DIR/mkdocs-site" ]; then
  echo "  ERROR: mkdocs-site/ not found. Run 'mkdocs build' first."
  exit 1
fi
echo "  mkdocs-site/ found, skipping build."

# ── Step 2: Register binfmt (skip for local builds) ──────────────────────────
if [ "$LOCAL" = false ]; then
  echo "[2/4] Registering binfmt emulation handlers..."
  docker run --privileged --rm tonistiigi/binfmt --install all
else
  echo "[2/4] Skipping binfmt registration (local build)"
fi

# ── Step 3: Create / select buildx builder ────────────────────────────────────
if [ "$LOCAL" = false ]; then
  echo "[3/4] Setting up multiarch-builder..."
  if ! docker buildx inspect multiarch-builder >/dev/null 2>&1; then
    docker buildx create --name multiarch-builder --use
  else
    docker buildx use multiarch-builder
  fi
  docker buildx inspect --bootstrap
else
  echo "[3/4] Using default builder (local arch only)"
fi

# ── Step 4: Build ─────────────────────────────────────────────────────────────
cd "$ROOT_DIR/docker"

if [ "$LOCAL" = true ]; then
  echo "[4/4] Building for local arch (no push)..."
  docker buildx bake \
    --allow=fs.read=.. \
    -f docker-compose.yml \
    --set "escape-room-bash.platforms=linux/$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')" \
    --load \
    escape-room-bash
else
  echo "[4/4] Building all platforms and pushing..."
  # Verify registry logins before attempting push
  if ! docker login ghcr.io --password-stdin <<< "" 2>/dev/null; then
    echo ""
    echo "  WARNING: Not logged in to ghcr.io"
    echo "  Run: echo \$CR_PAT | docker login ghcr.io -u USERNAME --password-stdin"
    echo ""
  fi
  docker buildx bake \
    --allow=fs.read=.. \
    -f docker-compose.yml \
    --push \
    escape-room-bash
fi

echo ""
echo "  Done! Image: ${IMAGE}:${IMAGE_TAG}"
echo ""

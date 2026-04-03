#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

REPO_ROOT="$(dirname "$(pwd)")"
EXT_ID="nirgeier.7104198852270621241459005"

echo "▶ Syncing bundled content from repo..."
rm -rf content/ docs/ public/
mkdir -p content/escapeRoom public

cp -r "$REPO_ROOT/content/escapeRoom/" content/escapeRoom/
cp -r "$REPO_ROOT/mkdocs-site/" docs/
cp "$REPO_ROOT/.escaperoom-framework/public/index.html" public/index.html
cp "$REPO_ROOT/mkdocs/passwords.yml" content/passwords.yml

# Append custom CSS overrides on top of the built mkdocs CSS
cat assets/escape-room-overrides.css >>docs/assets/stylesheets/codewizard.css
echo "   CSS overrides appended"

# Extract room metadata into JSON (so README doesn't need to be bundled)
node scripts/build-metadata.js

# ── Docker build-time room setup (mirrors Dockerfile RUN block) ──────────────

# Room 07 - rename script only (permissions set at server start to avoid vsce packaging errors)
[ -f content/escapeRoom/room_07/script.sh ] &&
  mv content/escapeRoom/room_07/script.sh content/escapeRoom/room_07/getKey.sh &&
  chmod +x content/escapeRoom/room_07/getKey.sh || true

# Rooms 08,09,32,44,50,51,54 - rename validation scripts
for room in room_08 room_09 room_32 room_44 room_50 room_51 room_54; do
  [ -f "content/escapeRoom/$room/script.sh" ] &&
    mv "content/escapeRoom/$room/script.sh" "content/escapeRoom/$room/getKey.sh" &&
    chmod +x "content/escapeRoom/$room/getKey.sh" || true
done

# Room 11 - wrap secret_scroll.txt: tar → gzip → base64 → artifact.b64
if [ -f content/escapeRoom/room_11/secret_scroll.txt ]; then
  cd content/escapeRoom/room_11
  tar cf secret.tar secret_scroll.txt
  gzip secret.tar
  base64 -i secret.tar.gz -o artifact.b64
  rm -f secret_scroll.txt secret.tar.gz
  cd ../../..
fi

# Room 01 - scatter 500 random noise files (fresh per install)
cd content/escapeRoom/room_01
SUBDIRS=()
while IFS= read -r d; do SUBDIRS+=("$d"); done < <(find expedition/ -type d 2>/dev/null)
NSUBDIRS=${#SUBDIRS[@]}
if [ "$NSUBDIRS" -gt 0 ]; then
  for i in $(seq 1 500); do
    target="${SUBDIRS[RANDOM%NSUBDIRS]}"
    fname=$(dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -An -tx1 | tr -dc 'a-f0-9')
    case $((RANDOM % 3)) in
    0) ext=".rock" ;; 1) ext=".leaf" ;; 2) ext=".twig" ;;
    esac
    echo "noise data $i" >"${target}/${fname}${ext}"
  done
  echo "   room_01: 500 noise files scattered"
fi
cd ../../..

echo "   Docker room setup complete (permissions, archives, noise)"

# Room 14 — obfuscate server.js via base64 loader, copy to scripts/ for extension, remove from room
mkdir -p scripts
if [ -f content/escapeRoom/room_14/server.js ]; then
  # Obfuscate: strip shebang, base64-encode, wrap in thin loader
  node -e "
    const fs = require('fs');
    const src = fs.readFileSync('content/escapeRoom/room_14/server.js', 'utf8');
    const code = src.replace(/^#!.*\n/, '');
    const b64 = Buffer.from(code).toString('base64');
    const loader = '#!/usr/bin/env node\n' +
      '(function(_0x1f2e,_0x3a){const _0xb7=Buffer.from(_0x1f2e,_0x3a).toString();' +
      '(new Function(\'require\',\'process\',\'__filename\',\'__dirname\',_0xb7))(require,process,__filename,__dirname);}' +
      '(\'' + b64 + '\',\'base64\'));\n';
    fs.writeFileSync('scripts/room14_server.js', loader);
  "
  rm -f content/escapeRoom/room_14/server.js
  echo "   room_14: server.js obfuscated → scripts/room14_server.js, removed from room"
fi

echo "▶ Verifying rooms..."
node scripts/verify-rooms.js \
  content/escapeRoom \
  "$REPO_ROOT/mkdocs/passwords.yml" \
  "$REPO_ROOT/content/escapeRoom"

# Strip README and solution files - clean rooms for users
find content/escapeRoom -name "README" -delete
find content/escapeRoom -name "_solution*" -delete
find content/escapeRoom -name "setup.sh" -delete
echo "   rooms: $(ls content/escapeRoom | grep -c room), README+solution+server stripped, metadata JSON written"

echo "▶ Bumping patch version..."
npm version patch --no-git-tag-version
echo "   version: $(node -p "require('./package.json').version")"

echo "▶ Uninstalling existing extension..."
code-insiders --uninstall-extension "$EXT_ID" 2>/dev/null || echo "  (not installed - skipping)"

echo "▶ Building bundle..."
npm run bundle

echo "▶ Packaging VSIX..."
npm run package

VSIX=$(ls -t *.vsix | head -1)
echo "▶ Installing $VSIX..."
code-insiders --install-extension "$VSIX" --force

echo "▶ Opening VS Code Insiders..."
code-insiders .

echo "✅ Done - reload the window in VS Code Insiders (Cmd+Shift+P → Developer: Reload Window)"

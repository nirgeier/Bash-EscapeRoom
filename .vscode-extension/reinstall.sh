#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

REPO_ROOT="$(dirname "$(pwd)")"
EXT_ID="nirgeier.EscapeRoom-Bash"

# ── Sync bundled content from repo ───────────────────────────────────────────
echo "▶ Syncing bundled content from repo..."
rm -rf content/ docs/ public/
mkdir -p content/escapeRoom public

cp -r "$REPO_ROOT/content/escapeRoom/" content/escapeRoom/
cp -r "$REPO_ROOT/mkdocs-site/" docs/
cp "$REPO_ROOT/.escaperoom-framework/public/index.html" public/index.html
cp "$REPO_ROOT/mkdocs/passwords.yml" content/passwords.yml

SCSS_SRC="$REPO_ROOT/.mkdocs-shared/mkdocs/overrides/assets/stylesheets"
if command -v sass &>/dev/null; then
  sass --no-source-map --style=compressed \
    "$SCSS_SRC/_escape-room-overrides.scss" >>docs/assets/stylesheets/codewizard.css
  echo "   CSS overrides compiled from SCSS and appended"
  sass --no-source-map --style=expanded "$SCSS_SRC/_vscode.scss" media/style.css
  echo "   media/style.css compiled from _vscode.scss"
else
  cat assets/escape-room-overrides.css >>docs/assets/stylesheets/codewizard.css
  echo "   CSS overrides appended (sass not found - using pre-built CSS)"
fi

# ── Room setup ────────────────────────────────────────────────────────────────
node scripts/build-metadata.js

# Room 07 - rename script (permissions set at server start)
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

# Room 01 - scatter 500 random noise files
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

# Room 14 - obfuscate server.js
mkdir -p scripts
if [ -f content/escapeRoom/room_14/server.js ]; then
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
  echo "   room_14: server.js obfuscated → scripts/room14_server.js"
fi

# Strip solution/setup files
find content/escapeRoom -name "README" -delete
find content/escapeRoom -name "_solution*" -delete
find content/escapeRoom -name "setup.sh" -delete
echo "   rooms: $(ls content/escapeRoom | grep -c room) rooms ready"

# ── Verify rooms ──────────────────────────────────────────────────────────────
echo "▶ Verifying rooms..."
node scripts/verify-rooms.js \
  content/escapeRoom \
  "$REPO_ROOT/mkdocs/passwords.yml" \
  "$REPO_ROOT/content/escapeRoom"

# ── Build & package ───────────────────────────────────────────────────────────
echo "▶ Bumping patch version..."
npm version patch --no-git-tag-version
VERSION="$(node -p "require('./package.json').version")"
echo "   version: $VERSION"

echo "▶ Uninstalling existing extension..."
code-insiders --uninstall-extension "$EXT_ID" 2>/dev/null || echo "   (not installed - skipping)"

echo "▶ Building & packaging..."
npm run bundle
npm run package
VSIX="$(ls -t *.vsix | head -1)"
echo "   built: $VSIX"

mkdir -p dist
rm -f dist/*.vsix
mv "$VSIX" "dist/$VSIX"
echo "   size: $(ls -lh "dist/$VSIX" | awk '{print $5}')"

# ── Publish ───────────────────────────────────────────────────────────────────
if [ -n "$VSCE_PAT" ]; then
  echo "▶ Publishing to VS Code Marketplace..."
  npx vsce publish --allow-missing-repository --packagePath "dist/$VSIX"
  echo "   ✅ VS Code Marketplace: v$VERSION published"
else
  echo "   ⚠ VSCE_PAT not set — skipping VS Code Marketplace publish"
fi

if [ -n "$OVSX_PAT" ]; then
  echo "▶ Publishing to Open VSX Registry..."
  npx ovsx publish "dist/$VSIX" --pat "$OVSX_PAT"
  echo "   ✅ Open VSX: v$VERSION published"
else
  echo "   ⚠ OVSX_PAT not set — skipping Open VSX publish"
fi

# ── Install locally ───────────────────────────────────────────────────────────
echo "▶ Installing..."
code-insiders --install-extension "dist/$VSIX" --force
code-insiders .

echo ""
echo "✅ Done  (v$VERSION)"
echo "   VSIX          : dist/$VSIX"
echo "   Reload window : Cmd+Shift+P → Developer: Reload Window"

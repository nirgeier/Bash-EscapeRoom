#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

REPO_ROOT="$(dirname "$(pwd)")"
EXT_ID="nirgeier.468731"

echo "▶ Syncing bundled content from repo..."
rm -rf content/ docs/ public/
mkdir -p content/escapeRoom public

cp -r "$REPO_ROOT/content/escapeRoom/" content/escapeRoom/
cp -r "$REPO_ROOT/mkdocs-site/"        docs/
cp    "$REPO_ROOT/.escaperoom-framework/public/index.html" public/index.html

# Append custom CSS overrides on top of the built mkdocs CSS
cat assets/escape-room-overrides.css >> docs/assets/stylesheets/codewizard.css
echo "   CSS overrides appended"

# Extract room metadata into JSON (so README doesn't need to be bundled)
node scripts/build-metadata.js

# Strip README and solution files — clean rooms for users
find content/escapeRoom -name "README"     -delete
find content/escapeRoom -name "_solution*" -delete
echo "   rooms: $(ls content/escapeRoom | grep -c room), README+solution stripped, metadata JSON written"

echo "▶ Bumping patch version..."
npm version patch --no-git-tag-version
echo "   version: $(node -p "require('./package.json').version")"

echo "▶ Uninstalling existing extension..."
code-insiders --uninstall-extension "$EXT_ID" 2>/dev/null || echo "  (not installed — skipping)"

echo "▶ Building bundle..."
npm run bundle

echo "▶ Packaging VSIX..."
npm run package

VSIX=$(ls -t *.vsix | head -1)
echo "▶ Installing $VSIX..."
code-insiders --install-extension "$VSIX" --force

echo "▶ Opening VS Code Insiders..."
code-insiders .

echo "✅ Done — reload the window in VS Code Insiders (Cmd+Shift+P → Developer: Reload Window)"

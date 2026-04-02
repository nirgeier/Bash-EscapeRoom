const esbuild = require('esbuild');
const fs = require('fs');
const path = require('path');

esbuild.build({
  entryPoints: ['./src/extension.ts'],
  bundle: true,
  outfile: './out/extension.js',
  external: [
    'vscode',
    'node-pty',   // native binary — cannot be bundled
  ],
  format: 'cjs',
  platform: 'node',
  target: 'node18',
  sourcemap: false,
  minify: false,
}).then(() => {
  // Remove dead tsc-compiled files so only the bundle is shipped
  const dead = ['RoomPanel.js', 'ControlPanel.js', 'server.js', 'docker.js',
                'RoomPanel.js.map', 'ControlPanel.js.map', 'server.js.map', 'docker.js.map'];
  for (const f of dead) {
    const p = path.join(__dirname, 'out', f);
    if (fs.existsSync(p)) { fs.unlinkSync(p); console.log('removed', f); }
  }
  console.log('Build OK — bundle size:', fs.statSync('./out/extension.js').size, 'bytes');
}).catch(() => process.exit(1));

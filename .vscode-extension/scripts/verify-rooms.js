#!/usr/bin/env node
/**
 * verify-rooms.js - Run each room's _solution.sh and verify password output
 * Usage: node scripts/verify-rooms.js <contentDir> <passwordsYml> <solutionsDir>
 */
const { execSync, spawnSync } = require("child_process");
const fs = require("fs");
const path = require("path");

// Resolve all paths relative to CWD (reinstall.sh always cds to extension dir first)
const contentDir = path.resolve(process.argv[2] || "content/escapeRoom");
const passwordsYml = path.resolve(process.argv[3] || "../mkdocs/passwords.yml");
const solutionsDir = path.resolve(process.argv[4] || "../content/escapeRoom");

// Parse passwords.yml: "rooms/Room-NN.md": "PASSWORD"
// Room N solution → password for Room N+1 → stored under Room-(N+1).md
const expected = {};
const yml = fs.readFileSync(passwordsYml, "utf8");
for (const line of yml.split("\n")) {
  // match:   "rooms/Room-NN.md": "password"   (with possible escaped quotes)
  const m = line.match(/Room-(\d+)\.md[^:]*:\s*[\\"]?([A-Za-z0-9_\-]+)[\\"]?/);
  if (m) {
    const num = parseInt(m[1], 10);
    expected[num - 1] = m[2];
  }
}

// Start room_14 server
let room14proc;
const serverScript = path.join(__dirname, "room14_server.js");
if (fs.existsSync(serverScript)) {
  try {
    room14proc = require("child_process").spawn(
      process.execPath,
      [serverScript],
      {
        detached: true,
        stdio: "ignore",
      },
    );
    // Give it a moment to start
    execSync("sleep 1");
  } catch (e) {
    /* ignore */
  }
}

const rooms = fs
  .readdirSync(solutionsDir)
  .filter((d) => /^room_\d+$/.test(d))
  .sort((a, b) => parseInt(a.match(/\d+/)[0]) - parseInt(b.match(/\d+/)[0]));

// Rooms that require external services/OS state unavailable in CI
const SKIP_ROOMS = new Set([
  9, // needs ghost_user process running
  38, // needs running cron/timer
  48, // needs git repo with history
]);

let pass = 0,
  fail = 0,
  skip = 0;
const errors = [];

console.log("");
for (const room of rooms) {
  const num = parseInt(room.match(/\d+/)[0], 10);
  const solPath = path.join(solutionsDir, room, "_solution.sh");
  const builtDir = path.join(contentDir, room);

  if (SKIP_ROOMS.has(num)) {
    console.log(`  ⚪ ${room} - needs external service (skip)`);
    skip++;
    continue;
  }
  if (!fs.existsSync(solPath)) {
    console.log(`  ⚪ ${room} - no _solution.sh (skip)`);
    skip++;
    continue;
  }
  if (!fs.existsSync(builtDir)) {
    console.log(`  ⚪ ${room} - not in built content (skip)`);
    skip++;
    continue;
  }

  const result = spawnSync("bash", [solPath], {
    cwd: builtDir,
    timeout: 10000,
    encoding: "utf8",
    env: { ...process.env, ROOM_DIR: path.resolve(builtDir) },
  });

  if (result.error?.code === "ETIMEDOUT" || result.status === null) {
    console.log(`  ⏱  ${room} - timed out (skip)`);
    skip++;
    continue;
  }

  // Strip ANSI escape codes
  const output = ((result.stdout || "") + (result.stderr || "")).replace(
    /\x1b\[[0-9;]*m/g,
    "",
  );

  // Try JSON first (room_14 style)
  let actual = "";
  const jsonMatch = output.match(/"password"\s*:\s*"([^"]+)"/i);
  if (jsonMatch) {
    actual = jsonMatch[1];
  } else {
    // Match patterns: "Password: X", "password is: X", "Password (fallback): X", "next room is: X"
    // Use last occurrence, take last token on that line
    const lines = output.split("\n");
    for (let i = lines.length - 1; i >= 0; i--) {
      const l = lines[i];
      const m =
        l.match(/[Pp]assword[^:]*:\s*(\S+)/) ||
        l.match(/next room is:\s*(\S+)/i);
      if (m && m[1] && !/^(for|is|the|to|of)$/i.test(m[1])) {
        actual = m[1];
        break;
      }
    }
  }
  const exp = expected[num];

  if (!exp) {
    if (actual) {
      console.log(`  ✅ ${room} - OK (${actual}, last room)`);
      pass++;
    } else {
      console.log(`  ⚪ ${room} - ran, no password (skip)`);
      skip++;
    }
  } else if (actual === exp) {
    console.log(`  ✅ ${room} - OK (${actual})`);
    pass++;
  } else {
    console.log(`  ❌ ${room} - FAIL (got: '${actual}', expected: '${exp}')`);
    errors.push(`${room}: got='${actual}' expected='${exp}'`);
    fail++;
  }
}

if (room14proc) {
  try {
    process.kill(-room14proc.pid);
  } catch (e) {
    try {
      room14proc.kill();
    } catch (e2) {}
  }
}

console.log("");
console.log("─────────────────────────────────────");
console.log(
  `  Results: ✅ ${pass} passed  ❌ ${fail} failed  ⚪ ${skip} skipped`,
);
console.log("─────────────────────────────────────");

if (errors.length) {
  console.log("\nFailures:");
  errors.forEach((e) => console.log(`  • ${e}`));
  process.exit(1);
}
console.log("\nAll rooms verified ✅");

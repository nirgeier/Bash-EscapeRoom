/**
 * Pre-build script: reads all room READMEs from content/escapeRoom/
 * and writes content/rooms-metadata.json for the extension to consume.
 */
const fs = require("fs");
const path = require("path");

const roomsDir = path.join(__dirname, "..", "content", "escapeRoom");
const navFile = path.join(__dirname, "..", "..", "mkdocs", "06-mkdocs-nav.yml");
const outFile = path.join(__dirname, "..", "content", "rooms-metadata.json");

// Parse room titles and summary from Labs/rooms/Room-NN.md
const labsDir = path.join(__dirname, "..", "..", "Labs", "rooms");
function labsInfo(num) {
  const f = path.join(labsDir, `Room-${String(num).padStart(2, "0")}.md`);
  if (!fs.existsSync(f)) return { title: null, summary: null, labsRaw: null };
  const content = fs.readFileSync(f, "utf8");
  const lines = content.split("\n");

  // Extract frontmatter summary
  let summary = null;
  let inFrontmatter = false;
  for (const l of lines) {
    if (l.trim() === "---") { inFrontmatter = !inFrontmatter; continue; }
    if (inFrontmatter) {
      const m = l.match(/^summary:\s*["']?(.+?)["']?\s*$/);
      if (m) { summary = m[1]; }
    }
  }

  // Extract ### action title (all-caps h3)
  let title = null;
  for (const l of lines) {
    const h3 = l.match(/^###\s+([A-Z][A-Z\s,&!':'-]{3,}!?)\s*$/);
    if (h3) { title = h3[1].replace(/!$/, "").trim(); break; }
  }

  return { title, summary, labsRaw: content };
}
function labsTitle(num) { return labsInfo(num).title; }

// Parse room titles from mkdocs nav YAML as fallback: "Room NN - subtitle"
const navTitles = {};
if (fs.existsSync(navFile)) {
  const navLines = fs.readFileSync(navFile, "utf8").split("\n");
  for (const l of navLines) {
    const m = l.match(/"Room\s+(\d+)\s*[-–]\s*([^"]+)":/);
    if (m) {
      navTitles[parseInt(m[1], 10)] = m[2].trim();
    }
  }
}

const metadata = {};
const dirs = fs
  .readdirSync(roomsDir)
  .filter((d) => /^room_\d+$/.test(d))
  .sort();

for (const dir of dirs) {
  const readmePath = path.join(roomsDir, dir, "README");
  if (!fs.existsSync(readmePath)) {
    continue;
  }

  const raw = fs.readFileSync(readmePath, "utf8");
  const lines = raw.split("\n");

  // Title: prefer nav YAML, then README # heading, then dir name
  const num = parseInt(dir.replace("room_", ""), 10);
  const titleLine = lines.find((l) => l.startsWith("# "));
  const readmeTitle = titleLine
    ? titleLine
        .replace(/^#+\s*/, "")
        .replace(/^Room\s+\d+\s*[-–]\s*/i, "")
        .trim()
    : null;
  const labsData = labsInfo(num);
  const title = labsData.title || navTitles[num] || readmeTitle || dir;

  // Section
  const sectionLine = lines.find((l) => l.includes("Section:"));
  const section = sectionLine
    ? sectionLine.replace(/.*Section:\s*/i, "").trim()
    : "Bash Skills";

  // Helper: detect hint lines - ">>" or "> >" (with optional spaces)
  const isHintLine = (l) => /^>\s*>/.test(l.trim());

  // Tasks: numbered list items - include all continuation lines (skip hint lines)
  const tasks = [];
  let inTasks = false;
  let currentTask = "";
  for (const l of lines) {
    if (/^##\s*Tasks/i.test(l)) {
      inTasks = true;
      continue;
    }
    if (/^##/.test(l) && inTasks) {
      if (currentTask) {
        tasks.push(currentTask.trim());
        currentTask = "";
      }
      break;
    }
    if (!inTasks) {
      continue;
    }
    if (/^\d+\./.test(l.trim())) {
      if (currentTask) {
        tasks.push(currentTask.trim());
      }
      currentTask = l.trim().replace(/^\d+\.\s*/, "");
    } else if (currentTask && l.trim() && !isHintLine(l)) {
      currentTask += " " + l.trim();
    }
  }
  if (currentTask) {
    tasks.push(currentTask.trim());
  }

  // Hints: all ">>" or "> >" lines (command hints), excluding navigation hints
  const hints = lines
    .filter((l) => isHintLine(l))
    .map((l) =>
      l
        .trim()
        .replace(/^(>\s*)+/, "")
        .trim(),
    )
    .filter((h) => h && !h.toLowerCase().startsWith("to move"));

  // Command examples: backtick content from hint lines
  const commands = [];
  for (const l of lines) {
    if (!isHintLine(l)) {
      continue;
    }
    const matches = [...l.matchAll(/`([^`]+)`/g)].map((m) => m[1]);
    commands.push(...matches);
  }
  // Also grab backtick snippets from task lines
  for (const t of tasks) {
    const matches = [...t.matchAll(/`([^`]+)`/g)].map((m) => m[1]);
    commands.push(...matches);
  }
  // Deduplicate
  const uniqueCommands = [...new Set(commands)].filter(
    (c) => c.includes(" ") || c.length > 3,
  );

  const summary = labsData.summary || '';
  const labsRaw = labsData.labsRaw || '';

  metadata[num] = {
    number: num,
    title,
    section,
    tasks,
    hints,
    commands: uniqueCommands,
    raw,
    summary,
    labsRaw,
  };
}

fs.writeFileSync(outFile, JSON.stringify(metadata, null, 2));
console.log(
  `rooms-metadata.json written - ${Object.keys(metadata).length} rooms`,
);

// @ts-check
const vscode = acquireVsCodeApi();

let _currentRoom = 1;
let _maxRooms    = 56;

window.addEventListener('message', ({ data: msg }) => {
  if (msg.command === 'setState')   { applyState(msg); }
  if (msg.command === 'appendLog')  { addLogLine(msg.line); }
});

vscode.postMessage({ command: 'ready' });

function applyState(msg) {
  _currentRoom = msg.currentRoom ?? 1;
  _maxRooms    = msg.maxRooms   ?? 56;
  const s = msg.status ?? 'stopped';

  // Dot + label
  const dot = document.getElementById('dot');
  dot.className = 'dot ' + s;
  const labels = { stopped:'Stopped', starting:'Starting…', running:'Running', error:'Error' };
  document.getElementById('status-text').textContent = labels[s] ?? s;

  // Port badge
  const pb = document.getElementById('port-badge');
  if (s === 'running') { pb.textContent = `:${msg.port}`; pb.classList.remove('hidden'); }
  else                 { pb.classList.add('hidden'); }

  // Buttons
  const running = s === 'running';
  setDisabled('btn-launch',   s === 'starting' || running);
  setDisabled('btn-stop',     s === 'stopped');
  setDisabled('btn-open',     !running);
  setDisabled('btn-docs',     !running);
  setDisabled('btn-terminal', !running);
  setDisabled('btn-prev',     !running || _currentRoom <= 1);
  setDisabled('btn-next',     !running || _currentRoom >= _maxRooms);

  // Room display
  document.getElementById('room-num').textContent = String(_currentRoom).padStart(2, '0');
  document.getElementById('room-of').textContent  = `/ ${_maxRooms}`;

  // Logs
  if (msg.logs) {
    document.getElementById('log').innerHTML = '';
    msg.logs.forEach(addLogLine);
    scrollLog();
  }
}

function addLogLine(line) {
  const log = document.getElementById('log');
  const s = document.createElement('span');
  s.className = 'log-line ' + classify(line);
  s.textContent = line + '\n';
  log.appendChild(s);
  while (log.childElementCount > 200) { log.removeChild(log.firstElementChild); }
  scrollLog();
}
function scrollLog() {
  const l = document.getElementById('log');
  l.scrollTop = l.scrollHeight;
}
function classify(l) {
  if (/error|fail/i.test(l)) { return 'err'; }
  if (/warn/i.test(l))       { return 'warn'; }
  if (/✅|ready|ok/i.test(l)){ return 'ok'; }
  return '';
}

function setDisabled(id, disabled) {
  const el = document.getElementById(id);
  if (el) { el.disabled = disabled; }
}

// Actions
function launch()       { vscode.postMessage({ command: 'launch' }); }
function stop()         { vscode.postMessage({ command: 'stop' }); }
function openRoom()     { vscode.postMessage({ command: 'openRoom', room: _currentRoom }); }
function prevRoom()     { vscode.postMessage({ command: 'prevRoom' }); }
function nextRoom()     { vscode.postMessage({ command: 'nextRoom' }); }
function openDocs()     { vscode.postMessage({ command: 'openDocs' }); }
function openTerminal() { vscode.postMessage({ command: 'openTerminal' }); }
function clearLog()     { document.getElementById('log').innerHTML = ''; }

window.launch       = launch;
window.stop         = stop;
window.openRoom     = openRoom;
window.prevRoom     = prevRoom;
window.nextRoom     = nextRoom;
window.openDocs     = openDocs;
window.openTerminal = openTerminal;
window.clearLog     = clearLog;

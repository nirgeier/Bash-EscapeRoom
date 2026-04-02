// @ts-check
const vscode = acquireVsCodeApi();
let currentPort = 3000;

window.addEventListener('message', (event) => {
  const msg = event.data;
  switch (msg.command) {
    case 'setState':
      currentPort = msg.port;
      applyState(msg.status, msg.port, msg.logs);
      break;
    case 'appendLog':
      appendLog(msg.line);
      break;
  }
});

vscode.postMessage({ command: 'ready' });

function applyState(status, port, logs) {
  // Status dot
  const dot = document.getElementById('status-dot');
  dot.className = 'status-dot ' + status;

  const labels = { stopped: 'Stopped', starting: 'Starting…', running: 'Running', error: 'Error' };
  document.getElementById('status-text').textContent = labels[status] ?? status;

  // Port badge
  const portEl = document.getElementById('status-port');
  if (status === 'running') {
    portEl.textContent = `:${port}`;
    portEl.classList.remove('hidden');
  } else {
    portEl.classList.add('hidden');
  }

  // Buttons
  document.getElementById('btn-launch').disabled   = status === 'starting' || status === 'running';
  document.getElementById('btn-terminal').disabled = status !== 'running';
  document.getElementById('btn-docs').disabled     = status !== 'running';
  document.getElementById('btn-stop').disabled     = status === 'stopped';

  // Progress bar
  const pw = document.getElementById('progress-wrap');
  status === 'starting' ? pw.classList.remove('hidden') : pw.classList.add('hidden');

  // Info card
  const url = `http://localhost:${port}`;
  document.getElementById('info-port').textContent = String(port);

  const termEl = document.getElementById('info-terminal');
  const docsEl = document.getElementById('info-docs');
  if (status === 'running') {
    termEl.textContent = url;
    termEl.style.pointerEvents = 'auto';
    docsEl.textContent = url + '/docs/';
    docsEl.style.pointerEvents = 'auto';
  } else {
    termEl.textContent = '—';
    termEl.style.pointerEvents = 'none';
    docsEl.textContent = '—';
    docsEl.style.pointerEvents = 'none';
  }

  // Logs replay
  if (logs) {
    const box = document.getElementById('log-box');
    box.innerHTML = '';
    logs.forEach(_addLogLine);
    box.scrollTop = box.scrollHeight;
  }
}

function appendLog(line) {
  _addLogLine(line);
  const box = document.getElementById('log-box');
  box.scrollTop = box.scrollHeight;
}

function _addLogLine(line) {
  const box = document.getElementById('log-box');
  const span = document.createElement('span');
  span.className = 'log-line ' + classifyLog(line);
  span.textContent = line;
  box.appendChild(span);
  while (box.childElementCount > 300) { box.removeChild(box.firstElementChild); }
}

function classifyLog(line) {
  if (/error|fatal|failed/i.test(line))    { return 'log-error'; }
  if (/warn/i.test(line))                  { return 'log-warn'; }
  if (/✅|ready|done|success/i.test(line)) { return 'log-success'; }
  return '';
}

function clearLogs() { document.getElementById('log-box').innerHTML = ''; }

function launch()       { vscode.postMessage({ command: 'launch' }); }
function stop()         { vscode.postMessage({ command: 'stop' }); }
function openTerminal() { vscode.postMessage({ command: 'openTerminal' }); }
function openDocs()     { vscode.postMessage({ command: 'openDocs' }); }

window.launch       = launch;
window.stop         = stop;
window.openTerminal = openTerminal;
window.openDocs     = openDocs;
window.clearLogs    = clearLogs;

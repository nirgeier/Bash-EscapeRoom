/**
 * Bash Escape Room - Playwright E2E Tests
 *
 * Tests the full room navigation flow:
 *  1. Page loads with terminal + docs iframe
 *  2. Terminal connects via WebSocket
 *  3. `next PASSWORD` navigates to each room and decrypts its README
 *  4. Docs iframe updates to the correct room page
 *  5. Progress bar advances
 *
 * Prerequisites: container must be running on BASE_URL (default http://localhost:3000)
 *   docker compose -f docker/docker-compose.yml up -d
 */

import { test, expect, Page } from '@playwright/test';

// ── Password chain (source: mkdocs/passwords.yml) ────────────────────────────
const ROOM_PASSWORDS: Record<number, string> = {
   2: 'northstar',
   3: 'signal59',
   4: 'rewind99',
   5: 'sedmaster',
   6: 'translate',
   7: 'unique37',
   8: 'access42',
   9: 'export99',
  10: 'daemon77',
  11: 'awk2025',
  12: 'layered7',
  13: 'pipeline',
  14: 'link42',
  15: 'webfetch',
  16: 'json64',
  17: 'modulereactor',
  18: 'cron5min',
  19: 'patch13',
  20: 'hash256',
  21: 'deadbeef',
  22: 'hidden42',
  23: 'calc1337',
  24: 'epoch6026',
  25: 'format77',
  26: 'teeoff',
  27: 'expand99',
  28: 'array10',
  29: 'loop50',
  30: 'while100',
  31: 'branch3',
  32: 'matched7',
  33: 'funcret',
  34: 'optparse',
  35: 'heredoc5',
  36: 'nested42',
  37: 'sigcatch',
  38: 'readline',
  39: 'timeout3',
  40: 'port80',
  41: 'resolve9',
  42: 'ncat7',
  43: 'openfd',
  44: 'syscall',
  45: 'synced',
  46: 'cipher99',
  47: 'vimmode',
  48: 'sshkey',
  49: 'commit42',
  50: 'pipeline9',
  51: 'masterkey',
  52: 'chownit',
  53: 'netprobe',
  54: 'monitor5',
  55: 'sysinfo9',
  56: 'procctrl',
};

const TOTAL_ROOMS = 56;
const BASE_URL = process.env.BASE_URL || 'http://localhost:3000';

// ── Helpers ───────────────────────────────────────────────────────────────────

/** Wait for terminal to be ready (prompt visible).
 *  The welcome screen requires a keypress before the prompt appears. */
async function waitForPrompt(page: Page, timeout = 30_000) {
  // Dismiss the "Press any key to continue" welcome screen if present
  await page.locator('#terminal-container').click();
  const deadline = Date.now() + timeout;
  while (Date.now() < deadline) {
    const text = await page.locator('.xterm-rows').textContent().catch(() => '');
    if (text?.includes('escape:')) break;
    if (text?.includes('Press any key')) {
      await page.keyboard.press('Enter');
    }
    await page.waitForTimeout(500);
  }
  await expect(page.locator('.xterm-rows')).toContainText('escape:', { timeout: 10_000 });
}

/** Send a command to the terminal and wait for it to echo back */
async function sendCommand(page: Page, cmd: string) {
  // Click the terminal to ensure focus
  await page.locator('#terminal-container').click();
  await page.keyboard.type(cmd);
  await page.keyboard.press('Enter');
}

/** Wait for terminal to contain text.
 *  Polls continuously — necessary because `clear` can wipe text from the buffer. */
async function waitForTerminalText(page: Page, text: string, timeout = 20_000) {
  const deadline = Date.now() + timeout;
  while (Date.now() < deadline) {
    const content = await page.locator('.xterm-rows').textContent().catch(() => '');
    if (content?.includes(text)) return;
    await page.waitForTimeout(200);
  }
  // Final assertion for a clean error message on failure
  await expect(page.locator('.xterm-rows')).toContainText(text, { timeout: 2_000 });
}

/** Wait for the shell prompt to show a specific room path (e.g. room_02).
 *  More reliable than "Moved to Room" which gets cleared by `clear`. */
async function waitForRoomPrompt(page: Page, paddedNum: string, timeout = 20_000) {
  const deadline = Date.now() + timeout;
  while (Date.now() < deadline) {
    const content = await page.locator('.xterm-rows').textContent().catch(() => '');
    // Prompt looks like: escape:~/escapeRooms/room_02$
    if (content?.includes(`room_${paddedNum}`)) return;
    await page.waitForTimeout(200);
  }
  await expect(page.locator('.xterm-rows')).toContainText(`room_${paddedNum}`, { timeout: 2_000 });
}

/** Pad room number to two digits */
function pad(n: number): string {
  return String(n).padStart(2, '0');
}

// ── Tests ─────────────────────────────────────────────────────────────────────

test.describe('Bash Escape Room UI', () => {

  test('page loads with correct title', async ({ page }) => {
    await page.goto(BASE_URL);
    await expect(page).toHaveTitle(/Bash Escape Room/i);
  });

  test('header shows Bash Escape Room', async ({ page }) => {
    await page.goto(BASE_URL);
    await expect(page.locator('#header h1')).toContainText('Bash Escape Room');
  });

  test('progress bar is visible', async ({ page }) => {
    await page.goto(BASE_URL);
    await expect(page.locator('#progress-bar')).toBeVisible();
    await expect(page.locator('#progress-label')).toContainText('/56');
  });

  test('terminal connects and shows prompt', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await expect(page.locator('#status-text')).toHaveText('Connected');
  });

  test('docs iframe loads', async ({ page }) => {
    await page.goto(BASE_URL);
    // iframe src should be set to /docs/ or fallback
    await page.waitForFunction(() => {
      const frame = document.getElementById('docs-frame') as HTMLIFrameElement;
      return frame && frame.src !== 'about:blank';
    }, { timeout: 10_000 });
    const src = await page.locator('#docs-frame').getAttribute('src');
    expect(src).toBeTruthy();
  });

  test('add terminal button creates new tab', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await page.locator('#add-term-btn').click();
    // Should now have 2 tabs
    await expect(page.locator('.term-tab')).toHaveCount(2);
  });

  test('drag handle resizes panes', async ({ page }) => {
    await page.goto(BASE_URL);
    const handle = page.locator('#drag-handle');
    const handleBox = await handle.boundingBox();
    expect(handleBox).toBeTruthy();

    const docsPaneBefore = await page.locator('#docs-pane').boundingBox();
    // Drag handle 100px to the right
    await page.mouse.move(handleBox!.x + 3, handleBox!.y + handleBox!.height / 2);
    await page.mouse.down();
    await page.mouse.move(handleBox!.x + 103, handleBox!.y + handleBox!.height / 2);
    await page.mouse.up();

    const docsPaneAfter = await page.locator('#docs-pane').boundingBox();
    expect(docsPaneAfter!.width).toBeGreaterThan(docsPaneBefore!.width + 50);
  });

});

test.describe('Room 01 - Initial State', () => {

  test('lands in room_01 after login', async ({ page }) => {
    await page.goto(BASE_URL);
    // Wait for prompt (dismisses welcome screen if needed)
    await waitForPrompt(page);
    await waitForRoomPrompt(page, '01');
  });

  test('room_01 README is not encrypted (plain text)', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, 'cat $ESCAPE_ROOMS/room_01/README | head -1');
    await waitForTerminalText(page, 'Room 01');
  });

  test('welcome message is shown on first login', async ({ page }) => {
    await page.goto(BASE_URL);
    // Welcome script runs on first login
    await waitForTerminalText(page, 'Escape Room', 20_000);
  });

});

test.describe('next command - room navigation', () => {

  test('next without password moves to room_02 without decrypting', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    // Navigate to room_01 first
    await sendCommand(page, 'cd $ESCAPE_ROOMS/room_01');
    await waitForPrompt(page);
    await sendCommand(page, 'next');
    await waitForTerminalText(page, 'Moved to Room 02');
  });

  test('next with wrong password shows error', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, 'cd $ESCAPE_ROOMS/room_01');
    await waitForPrompt(page);
    await sendCommand(page, 'next wrongpassword');
    await waitForTerminalText(page, 'Wrong password');
  });

  test('next with correct password decrypts room_02', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, 'cd $ESCAPE_ROOMS/room_01');
    await waitForPrompt(page);
    await sendCommand(page, `next ${ROOM_PASSWORDS[2]}`);
    // `clear` runs after decrypt so we check the prompt path instead
    await waitForRoomPrompt(page, '02');
  });

  test('docs iframe navigates to room_02 after next', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, 'cd $ESCAPE_ROOMS/room_01');
    await waitForPrompt(page);
    await sendCommand(page, `next ${ROOM_PASSWORDS[2]}`);
    await waitForRoomPrompt(page, '02');
    // Wait for iframe src to update
    await page.waitForFunction(() => {
      const frame = document.getElementById('docs-frame') as HTMLIFrameElement;
      return frame?.src?.includes('Room-02');
    }, { timeout: 10_000 });
    const src = await page.locator('#docs-frame').getAttribute('src');
    expect(src).toContain('Room-02');
  });

  test('progress bar advances after moving to room_02', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, 'cd $ESCAPE_ROOMS/room_01');
    await waitForPrompt(page);
    await sendCommand(page, `next ${ROOM_PASSWORDS[2]}`);
    await waitForRoomPrompt(page, '02');
    await expect(page.locator('#progress-label')).toContainText('Room 2');
  });

});

test.describe('room command - direct navigation', () => {

  test('room 5 navigates directly to room_05', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, `room 5 ${ROOM_PASSWORDS[5]}`);
    await waitForRoomPrompt(page, '05');
  });

  test('room command with invalid number shows error', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, 'room 999');
    await waitForTerminalText(page, 'No room_999 found');
  });

  test('docs iframe updates when using room command', async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);
    await sendCommand(page, `room 3 ${ROOM_PASSWORDS[3]}`);
    await waitForRoomPrompt(page, '03');
    await page.waitForFunction(() => {
      const frame = document.getElementById('docs-frame') as HTMLIFrameElement;
      return frame?.src?.includes('Room-03');
    }, { timeout: 10_000 });
    const src = await page.locator('#docs-frame').getAttribute('src');
    expect(src).toContain('Room-03');
  });

});

// ── Full room walkthrough (rooms 2-10) ────────────────────────────────────────
// Tests sequential navigation through the first 10 rooms using `next`

test.describe('Full walkthrough - rooms 1 through 10', () => {

  test('navigate sequentially through rooms 01-10', async ({ page }) => {
    test.setTimeout(120_000);

    await page.goto(BASE_URL);
    await waitForPrompt(page);

    // Start from room_01
    await sendCommand(page, 'cd $ESCAPE_ROOMS/room_01');
    await waitForPrompt(page);

    for (let roomNum = 2; roomNum <= 10; roomNum++) {
      const password = ROOM_PASSWORDS[roomNum];
      const paddedNum = pad(roomNum);

      await sendCommand(page, `next ${password}`);
      // `clear` runs after successful decrypt — check prompt path
      await waitForRoomPrompt(page, paddedNum, 20_000);

      // Verify docs iframe navigates to the correct room
      await page.waitForFunction((num) => {
        const frame = document.getElementById('docs-frame') as HTMLIFrameElement;
        return frame?.src?.includes(`Room-${num}`);
      }, paddedNum, { timeout: 10_000 });

      const src = await page.locator('#docs-frame').getAttribute('src');
      expect(src).toContain(`Room-${paddedNum}`);

      // Verify progress label
      await expect(page.locator('#progress-label')).toContainText(`Room ${roomNum}`);
    }
  });

});

// ── All rooms reachable via `room` command ────────────────────────────────────
// Tests that every room directory exists and is accessible

for (let roomNum = 1; roomNum <= TOTAL_ROOMS; roomNum++) {
  const paddedNum = pad(roomNum);
  const password = ROOM_PASSWORDS[roomNum];

  test(`room ${paddedNum} is accessible`, async ({ page }) => {
    await page.goto(BASE_URL);
    await waitForPrompt(page);

    if (password) {
      await sendCommand(page, `room ${roomNum} ${password}`);
    } else {
      await sendCommand(page, `room ${roomNum}`);
    }

    // Check prompt shows correct room path (works even after `clear`)
    await waitForRoomPrompt(page, paddedNum, 20_000);
  });
}

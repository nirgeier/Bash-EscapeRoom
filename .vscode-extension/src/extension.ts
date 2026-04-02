import * as vscode from 'vscode';
import { RoomPanel } from './RoomPanel';

let roomPanel: RoomPanel | undefined;

export function activate(context: vscode.ExtensionContext): void {
  const workspaceFolders =
    vscode.workspace.workspaceFolders?.map(f => f.uri.fsPath) ?? [];

  roomPanel = new RoomPanel(context.extensionUri, workspaceFolders, context);

  context.subscriptions.push(
    vscode.window.registerWebviewViewProvider(
      RoomPanel.sidebarViewType,
      roomPanel,
      { webviewOptions: { retainContextWhenHidden: true } }
    ),

    vscode.commands.registerCommand('bashEscapeRoom.launch',       () => roomPanel?.launch()),
    vscode.commands.registerCommand('bashEscapeRoom.stop',         () => roomPanel?.stop()),
    vscode.commands.registerCommand('bashEscapeRoom.openTerminal', () => roomPanel?.openTerminal()),
    vscode.commands.registerCommand('bashEscapeRoom.openRoom',     () => roomPanel?.openRoom(1)),
  );

  // Welcome on first install
  const seen = context.globalState.get<boolean>('bashEscapeRoom.welcomed');
  if (!seen) {
    vscode.window
      .showInformationMessage('Bash Escape Room is ready! Click Launch to start.', 'Launch')
      .then((c) => { if (c === 'Launch') { roomPanel?.launch(); } });
    context.globalState.update('bashEscapeRoom.welcomed', true);
  }
}

export function deactivate(): void {
  roomPanel?.stop();
}

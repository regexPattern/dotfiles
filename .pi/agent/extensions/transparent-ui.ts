/** Pi 1.4.x: keep the active palette, but remove panel backgrounds and editor rules. */
import { CustomEditor, Theme, type ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, type TuiMouseEvent, type TuiMouseEventResult } from "@earendil-works/pi-tui";

/**
 * Patch the public styling helpers, not a copy of the system palette. Applying
 * this to the prototype also covers themes rebuilt after terminal color changes.
 * Explicit colors drawn independently by third-party extensions are unaffected.
 */
export function removeThemeBackgrounds(): () => void {
  const prototype = Theme.prototype;
  const original = {
    bg: prototype.bg,
    getBgAnsi: prototype.getBgAnsi,
    style: prototype.style,
  };
  const bg: Theme["bg"] = (_color, text) => `\x1b[49m${text}\x1b[49m`;
  const getBgAnsi: Theme["getBgAnsi"] = () => "\x1b[49m";
  const style: Theme["style"] = function (text, options) {
    return original.style.call(this, text, { ...options, bg: undefined });
  };
  prototype.bg = bg;
  prototype.getBgAnsi = getBgAnsi;
  prototype.style = style;

  return () => {
    // Don't undo changes another extension may have installed after ours.
    if (prototype.bg === bg) prototype.bg = original.bg;
    if (prototype.getBgAnsi === getBgAnsi) prototype.getBgAnsi = original.getBgAnsi;
    if (prototype.style === style) prototype.style = original.style;
  };
}

const BOTTOM_BORDER = "\x1b]pi-transparent-editor-bottom\x07";

export class PromptEditor extends CustomEditor {
  private prefixWidth = 2;
  private contentRows = 1;

  protected override renderTopBorder(): string { return ""; }
  protected override renderBottomBorder(): string { return BOTTOM_BORDER; }

  override render(width: number): string[] {
    // Reserve the prefix before wrapping, so cursor navigation uses the same width.
    this.prefixWidth = Math.min(2, Math.max(0, width - 1));
    // Pi's wrapper needs two text columns for wide graphemes; clip tiny views below.
    const lines = super.render(Math.max(3, width - this.prefixWidth));
    const bottom = lines.indexOf(BOTTOM_BORDER);
    this.contentRows = bottom - 1;
    const content = lines.slice(1, bottom);
    const autocomplete = lines.slice(bottom + 1);
    const indent = " ".repeat(this.prefixWidth);
    return [
      ...content.map((line, index) =>
        (index === 0 ? this.borderColor("> ".slice(0, this.prefixWidth)) : indent) + line),
      ...autocomplete.map(line => indent + line),
    ].map(line => truncateToWidth(line, width, ""));
  }

  override handleMouse(event: TuiMouseEvent): TuiMouseEventResult | undefined {
    // The base editor expects a top rule and, before completion, a bottom rule.
    return super.handleMouse({
      ...event,
      x: Math.max(0, event.x - this.prefixWidth),
      y: event.y + (event.y < this.contentRows ? 1 : 2),
      width: Math.max(3, event.width - this.prefixWidth),
      height: event.height + 2,
    });
  }
}

export default function (pi: ExtensionAPI) {
  let restoreBackgrounds: (() => void) | undefined;

  pi.on("session_start", (_event, ctx) => {
    if (ctx.mode !== "tui") return;
    restoreBackgrounds?.();
    restoreBackgrounds = removeThemeBackgrounds();
    ctx.ui.setEditorComponent((tui, theme, keybindings) =>
      new PromptEditor(tui, theme, keybindings));
  });

  pi.on("session_shutdown", () => {
    restoreBackgrounds?.();
    restoreBackgrounds = undefined;
  });
}

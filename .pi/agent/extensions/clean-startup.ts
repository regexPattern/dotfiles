/** Clean startup for Pi 1.4.x. Keep resource discovery and diagnostics owned by Pi. */
import { realpathSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { VERSION } from "@earendil-works/pi-coding-agent";
import { rgbColor, Text, truncateToWidth, wrapTextWithAnsi, type Component } from "@earendil-works/pi-tui";
type StartupQuote = { quote: string; author: { name: string } };

// Use an absolute package path: the compiled Pi loader does not reliably resolve
// bare npm names through createRequire, even with the correct source filename.
const sourcePath = realpathSync(new URL(import.meta.url));
const quotes: { getQuotesByCategory(category: string): StartupQuote[] } =
  createRequire(sourcePath)(join(dirname(sourcePath), "../node_modules/open-quotes/dist/index.js"));

// Pi has no public resource-label formatter. This small, guarded adapter targets
// its ExpandableText component, before wrapping, and leaves expanded details alone.
// If Pi changes that component, the original listing is left untouched.
type ResourceComponent = Component & {
  children?: Component[];
  build?: () => string;
  state?: { expanded: boolean };
};

const plain = (text: string) => text.replace(/\x1b\[[0-9;]*m/g, "");

export function extensionName(label: string): string {
  // Package labels: pi-web-access:dist, @scope/pkg:src/extension.ts.
  // Local filenames stay distinguishable, without their JS/TS extension.
  return label.trim().split(":", 1)[0].replace(/\.(?:[cm]?[jt]s)$/, "");
}

export default function (pi: ExtensionAPI) {
  pi.on("session_start", (_event, ctx) => {
    if (ctx.mode !== "tui") return;

    const collection: StartupQuote[] = quotes.getQuotesByCategory("Programming");
    const selected = collection[Math.floor(Math.random() * collection.length)];

    ctx.ui.setHeader((tui, theme) => {
      const adapted = new Map<ResourceComponent, () => string>();

      function adaptResourceLabels(component: ResourceComponent): void {
        if (!adapted.has(component) && typeof component.build === "function" &&
            typeof component.state?.expanded === "boolean") {
          const original = component.build;
          const heading = plain(original.call(component)).split("\n", 1)[0];
          if (heading === "[Extensions]") {
            adapted.set(component, original);
            component.build = () => {
              const text = original.call(component);
              if (component.state?.expanded) return text;
              const [title, ...body] = text.split("\n");
              const names = [...new Set(plain(body.join("\n")).split(", ")
                .map(extensionName).filter(Boolean))];
              names.sort((a, b) => a.localeCompare(b));
              return `${title}\n${theme.fg("dim", `  ${names.join(", ")}`)}`;
            };
            component.invalidate();
          }
        }
        for (const child of component.children ?? []) {
          adaptResourceLabels(child as ResourceComponent);
        }
      }

      const text = new Text("", 1, 0);
      return {
        render(width: number): string[] {
          // Resources may be rebuilt after startup, /reload, or session changes.
          adaptResourceLabels(tui as ResourceComponent);
          const coral = rgbColor(228, 138, 122);
          const blue = rgbColor(79, 142, 179);
          const yellow = rgbColor(234, 182, 93);
          // Double each original half-block pixel in both dimensions:
          // 4 columns × 2 terminal rows becomes 8 columns × 4 rows.
          const block = (count: number, color: ReturnType<typeof rgbColor>) =>
            theme.style("█".repeat(count), { fg: color });
          const logo = [
            `${block(6, coral)}  `,
            `${block(2, blue)}  ${block(2, coral)}  `,
            `${block(4, blue)}  ${block(2, yellow)}`,
            `${block(2, blue)}    ${block(2, yellow)}`,
          ];
          const innerWidth = Math.max(1, width - 2); // Text's horizontal padding.
          const sideBySide = innerWidth >= 37;
          const columnWidth = sideBySide ? innerWidth - 9 : innerWidth;
          const details = [
            theme.fg("dim", truncateToWidth(`Pi Coding Agent v${VERSION}`, columnWidth)),
            "", // The version and quote are separated by exactly \n\n.
            ...(selected ? [
              ...wrapTextWithAnsi(`“${selected.quote}”`, columnWidth)
                .map(line => theme.fg("muted", line)),
              theme.fg("dim", truncateToWidth(`— ${selected.author.name}`, columnWidth)),
            ] : []),
          ];
          const lines = sideBySide
            ? Array.from({ length: Math.max(logo.length, details.length) }, (_, index) =>
                `${logo[index] ?? " ".repeat(8)} ${details[index] ?? ""}`)
            : [...logo.map(line => truncateToWidth(line, innerWidth)), "", ...details];
          text.setText(lines.join("\n"));
          return text.render(width);
        },
        invalidate() { text.invalidate(); },
        dispose() {
          for (const [component, original] of adapted) {
            component.build = original;
            component.invalidate();
          }
          adapted.clear();
        },
      };
    });
  });
}

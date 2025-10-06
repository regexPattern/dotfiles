# Repository Guidelines

## Project Structure & Module Organization
This flake-based dotfiles repo centers on `flake.nix`, which assembles home-manager modules for each host. Primary configuration lives in `home/default.nix`; keep host logic behind existing `pkgs.stdenv` guards. Text assets live in `home/configs/text` (Neovim Lua, `skhdrc`, `yabairc`), while reusable nix snippets sit in `home/configs/nix`. Add packages or overlays in `home/packages`, mirroring `home/packages/neovim.nix` when you split out larger modules.

## Build, Test, and Development Commands
Run `nix develop` to enter the dev shell with `alejandra`, `stylua`, and LSP helpers. Run `nix fmt` before committing. Use `home-manager build --flake .#regexpattern@carlos-macbook-pro` (swap the host suffix) to validate changes without touching the live profile. When ready, `home-manager switch --flake .#regexpattern@HOST` applies the configuration. `nix flake check` validates inputs and module evaluation for every declared system.

## Coding Style & Naming Conventions
Follow two-space indentation for Nix expressions and attribute sets; keep option blocks alphabetized when practical (`programs.*`, `home.sessionPath`, `home.packages`). Lua inside `home/configs/text/nvim` uses four spaces; run `stylua home/configs/text/nvim` after edits. Keep shell configs (`skhdrc`, `yabairc`) minimal; comment only when behaviour differs from defaults. New files should adopt snake_case filenames and mirror the current directory layout (`configs/text/<tool>`).

## Testing Guidelines
Use `home-manager build --flake ... --show-trace` when debugging; follow with `home-manager switch --dry-run` on macOS to review service diffs. For Neovim updates, open `nvim` from within `nix develop` and run `:checkhealth` to confirm plugins declared via `vim.pack.add` load correctly. If you touch overlays or dependency versions, rerun `nix flake check` and rebuild for each target host listed in `flake.nix`.

## Commit & Pull Request Guidelines
Commits follow the lightweight Conventional Commits pattern seen in history (`feat:`, `fix:`, `typo:`), often in lowercase Spanish; keep the prefix and a concise verb phrase. Group related configuration updates per host per commit and mention affected modules (`neovim`, `fastfetch`, etc.). Pull requests should include: summary of behavioural impact, host(s) validated (e.g., `carlos-macbook-pro`), command log for the latest `home-manager build`, and any manual steps required (fonts, SSH keys). Link upstream issues or plugins when bumping pinned revisions.

## Security & Configuration Tips
Never commit secrets or personal tokens; SSH identities referenced in `programs.ssh` must remain in `~/.ssh`. Use host guards (`isDarwin`, `isLinux`) when adding platform-specific services, and prefer extending `home.packages` rather than hard-coding paths. Document non-obvious defaults (fonts, themes) in module comments to keep future contributors aligned with the current desktop experience.

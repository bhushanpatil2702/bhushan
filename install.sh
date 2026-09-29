#!/usr/bin/env bash
# bhushan installer — usage:
#   curl -fsSL https://raw.githubusercontent.com/<github-user>/bhushan/main/install.sh | bash
set -euo pipefail
REPO_RAW="${BHUSHAN_REPO_RAW:-https://raw.githubusercontent.com/bhushanpatil2702/bhushan/main}"
BHUSHAN_HOME="${BHUSHAN_HOME:-$HOME/.bhushan}"
MARK_START="# >>> bhushan init >>>"
MARK_END="# <<< bhushan init <<<"

rc_files() { for f in "$HOME/.bashrc" "$HOME/.zshrc"; do [ -f "$f" ] && echo "$f"; done; }

if [ "${1:-}" = "--uninstall" ]; then
  for f in $(rc_files); do sed -i "/$MARK_START/,/$MARK_END/d" "$f"; done
  rm -rf "$BHUSHAN_HOME"
  echo "bhushan removed (envs deleted too). Open a new terminal."
  exit 0
fi

command -v python3 >/dev/null || { echo "error: python3 is required"; exit 1; }
if ! python3 -c "import ensurepip" 2>/dev/null; then
  echo "→ installing python3-venv (needed to create envs)"
  sudo apt-get update -qq && sudo apt-get install -y -qq python3-venv
fi

mkdir -p "$BHUSHAN_HOME/bin" "$BHUSHAN_HOME/envs"
SRC_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; fi
if [ -n "$SRC_DIR" ] && [ -f "$SRC_DIR/bin/bhushan" ]; then
  cp "$SRC_DIR/bin/bhushan" "$BHUSHAN_HOME/bin/bhushan"
else
  curl -fsSL "$REPO_RAW/bin/bhushan" -o "$BHUSHAN_HOME/bin/bhushan"
fi
chmod +x "$BHUSHAN_HOME/bin/bhushan"

for f in $(rc_files); do
  grep -q "$MARK_START" "$f" || cat >> "$f" <<EOF

$MARK_START
export PATH="\$HOME/.bhushan/bin:\$PATH"
eval "\$(bhushan init)"
$MARK_END
EOF
done

echo "✓ bhushan $("$BHUSHAN_HOME/bin/bhushan" version | cut -d' ' -f2) installed to $BHUSHAN_HOME"
echo "  Open a new terminal (or run: source ~/.bashrc), then try: bhushan help"

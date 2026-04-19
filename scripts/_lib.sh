#!/usr/bin/env bash
# SPECFORCE – Gemeinsame Hilfsfunktionen für alle CLI-Skripte
# Einbinden mit: source "$(dirname "$0")/_lib.sh"

set -euo pipefail

# ── Farben ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Pfade ────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SESSION_DIR="$PROJECT_ROOT/sessions"
CURRENT_SESSION_DIR="$SESSION_DIR/current"
ARCHIVE_DIR="$SESSION_DIR/.archive"
PROMPT_DIR="$PROJECT_ROOT/prompts"
CASCADE_DIR="$PROMPT_DIR/cascades"

# ── Logging ──────────────────────────────────────────────────────────────────
log_info()    { echo -e "${CYAN}[INFO]${RESET}  $*"; }
log_success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
log_error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; }
log_header()  { echo -e "\n${BOLD}${BLUE}══ $* ══${RESET}\n"; }

# ── Session-Hilfsfunktionen ──────────────────────────────────────────────────

# Gibt den Pfad zur aktuellen session.json zurück
session_file() {
  echo "$CURRENT_SESSION_DIR/session.json"
}

# Prüft ob eine aktive Session existiert
session_exists() {
  [[ -f "$CURRENT_SESSION_DIR/session.json" ]]
}

# Liest einen Wert aus session.json (benötigt jq oder python3)
session_get() {
  local key="$1"
  local session_f
  session_f="$(session_file)"
  if command -v jq &>/dev/null; then
    jq -r ".$key // empty" "$session_f"
  elif command -v python3 &>/dev/null; then
    python3 - "$session_f" "$key" <<'PYEOF'
import json, sys
path, key = sys.argv[1], sys.argv[2]
with open(path) as f:
    d = json.load(f)
print(d.get(key, ''))
PYEOF
  else
    log_error "jq oder python3 ist erforderlich."
    exit 1
  fi
}

# Schreibt einen Wert in session.json
session_set() {
  local key="$1"
  local value="$2"
  local session_f
  session_f="$(session_file)"
  if command -v jq &>/dev/null; then
    local tmp
    tmp="$(mktemp)"
    jq ".$key = \"$value\"" "$session_f" > "$tmp" && mv "$tmp" "$session_f"
  elif command -v python3 &>/dev/null; then
    python3 - "$session_f" "$key" "$value" <<'PYEOF'
import json, sys
path, key, val = sys.argv[1], sys.argv[2], sys.argv[3]
with open(path) as f:
    d = json.load(f)
d[key] = val
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
    f.write('\n')
PYEOF
  else
    log_error "jq oder python3 ist erforderlich."
    exit 1
  fi
}

# Generiert eine neue Session-ID (Zeitstempel-basiert)
generate_session_id() {
  date +"%Y%m%d_%H%M%S"
}

# Aktuellen ISO-8601-Zeitstempel zurückgeben
now_iso() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

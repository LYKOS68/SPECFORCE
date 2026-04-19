#!/usr/bin/env bash
# SPECFORCE – Prompt-Kaskade ausführen
# Verwendung: bash scripts/run-cascade.sh <kaskaden-name>
#
# Eine Prompt-Kaskade ist eine geordnete Folge von Prompt-Schritten
# (YAML-Datei in prompts/cascades/), die nacheinander abgearbeitet werden.

source "$(dirname "$0")/_lib.sh"

# ── Argumente ─────────────────────────────────────────────────────────────────
if [[ $# -lt 1 || -z "$1" ]]; then
  log_error "Kein Kaskaden-Name angegeben."
  echo "Verwendung: bash scripts/run-cascade.sh <kaskaden-name>"
  echo ""
  echo "Verfügbare Kaskaden:"
  if [[ -d "$CASCADE_DIR" ]]; then
    find "$CASCADE_DIR" -name "*.yaml" -o -name "*.yml" 2>/dev/null \
      | sed "s|$CASCADE_DIR/||" | sed 's/\.\(yaml\|yml\)$//' | sort | sed 's/^/  • /'
  else
    echo "  (keine gefunden)"
  fi
  exit 1
fi

CASCADE_NAME="$1"
CASCADE_FILE=""

# Kaskaden-Datei suchen (.yaml oder .yml)
for ext in yaml yml; do
  candidate="$CASCADE_DIR/${CASCADE_NAME}.${ext}"
  if [[ -f "$candidate" ]]; then
    CASCADE_FILE="$candidate"
    break
  fi
done

if [[ -z "$CASCADE_FILE" ]]; then
  log_error "Kaskade '$CASCADE_NAME' nicht gefunden."
  log_info  "Erwartet unter: prompts/cascades/${CASCADE_NAME}.yaml"
  exit 1
fi

# ── Session prüfen ────────────────────────────────────────────────────────────
if ! session_exists; then
  log_warn "Keine aktive Session. Initialisiere automatisch..."
  bash "$(dirname "$0")/init-session.sh" "auto_${CASCADE_NAME}"
fi

SESSION_ID="$(session_get session_id)"
SESSION_NAME="$(session_get session_name)"

log_header "Kaskade: $CASCADE_NAME"
log_info "Session: $SESSION_NAME ($SESSION_ID)"
log_info "Datei:   prompts/cascades/${CASCADE_NAME}.yaml"
echo ""

# ── Kaskade parsen und ausführen ──────────────────────────────────────────────
# Einfacher YAML-Parser für Prompt-Schritte (benötigt kein externes Tool)
# Format: '- step: <name>' gefolgt von '  prompt: |' Block

STEP_COUNT=0
CURRENT_STEP=""
CURRENT_PROMPT=""
IN_PROMPT=0
INDENT=""

execute_step() {
  local step_name="$1"
  local prompt_text="$2"

  STEP_COUNT=$((STEP_COUNT + 1))
  echo -e "${BOLD}${BLUE}[Schritt $STEP_COUNT]${RESET} ${step_name}"
  echo -e "${CYAN}────────────────────────────────────────${RESET}"
  echo "$prompt_text"
  echo -e "${CYAN}────────────────────────────────────────${RESET}"
  echo ""

  # Prompt-Ausführung in session.json vermerken
  TIMESTAMP="$(now_iso)"
  session_set updated_at "$TIMESTAMP"
  session_set phase "$step_name"
}

# YAML-Datei zeilenweise verarbeiten
while IFS= read -r line; do
  # Neuer Schritt erkannt
  if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*step:[[:space:]]*(.*) ]]; then
    # Vorherigen Schritt ausführen wenn vorhanden
    if [[ -n "$CURRENT_STEP" && -n "$CURRENT_PROMPT" ]]; then
      execute_step "$CURRENT_STEP" "$CURRENT_PROMPT"
    fi
    CURRENT_STEP="${BASH_REMATCH[1]}"
    CURRENT_PROMPT=""
    IN_PROMPT=0

  # Prompt-Block Beginn
  elif [[ "$line" =~ ^[[:space:]]*prompt:[[:space:]]*\|[[:space:]]*$ && -n "$CURRENT_STEP" ]]; then
    IN_PROMPT=1
    INDENT=""

  # Prompt-Inhalt sammeln
  elif [[ $IN_PROMPT -eq 1 && -n "$CURRENT_STEP" ]]; then
    # Einrückung beim ersten Inhalt bestimmen
    if [[ -z "$INDENT" && "$line" =~ ^([[:space:]]+)[^[:space:]] ]]; then
      INDENT="${BASH_REMATCH[1]}"
    fi
    # Einrückung entfernen
    stripped="${line#$INDENT}"
    CURRENT_PROMPT+="${stripped}"$'\n'
  fi
done < "$CASCADE_FILE"

# Letzten Schritt ausführen
if [[ -n "$CURRENT_STEP" && -n "$CURRENT_PROMPT" ]]; then
  execute_step "$CURRENT_STEP" "$CURRENT_PROMPT"
fi

if [[ $STEP_COUNT -eq 0 ]]; then
  log_warn "Keine Schritte in der Kaskade '$CASCADE_NAME' gefunden."
  log_info  "Prüfe das Format in: prompts/cascades/${CASCADE_NAME}.yaml"
  exit 1
fi

log_success "Kaskade '$CASCADE_NAME' abgeschlossen ($STEP_COUNT Schritt(e))."

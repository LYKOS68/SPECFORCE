#!/usr/bin/env bash
# SPECFORCE – Neue Werkstatt-Session initialisieren
# Verwendung: bash scripts/init-session.sh [session-name]

source "$(dirname "$0")/_lib.sh"

# ── Banner ────────────────────────────────────────────────────────────────────
log_header "SPECFORCE Werkstatt – Session initialisieren"

# ── Prüfen ob bereits eine Session läuft ─────────────────────────────────────
if session_exists; then
  current_status="$(session_get status)"
  if [[ "$current_status" == "active" ]]; then
    log_warn "Es läuft bereits eine aktive Session."
    log_info  "Verwende 'bash scripts/resume-session.sh' um fortzufahren,"
    log_info  "oder 'bash scripts/archive-session.sh' um sie zu archivieren."
    exit 1
  fi
fi

# ── Session-Name bestimmen ────────────────────────────────────────────────────
SESSION_ID="$(generate_session_id)"

if [[ $# -ge 1 && -n "$1" ]]; then
  SESSION_NAME="$1"
else
  # Interaktive Eingabe wenn kein Argument übergeben
  read -r -p "$(echo -e "${CYAN}Session-Name${RESET} [Standard: session_${SESSION_ID}]: ")" SESSION_NAME
  SESSION_NAME="${SESSION_NAME:-session_${SESSION_ID}}"
fi

log_info "Session-ID:   $SESSION_ID"
log_info "Session-Name: $SESSION_NAME"

# ── Verzeichnisse anlegen ─────────────────────────────────────────────────────
mkdir -p "$CURRENT_SESSION_DIR" "$ARCHIVE_DIR"

# ── session.json schreiben ────────────────────────────────────────────────────
TIMESTAMP="$(now_iso)"

cat > "$CURRENT_SESSION_DIR/session.json" <<JSON
{
  "schema_version": "1.0",
  "session_id": "$SESSION_ID",
  "session_name": "$SESSION_NAME",
  "created_at": "$TIMESTAMP",
  "updated_at": "$TIMESTAMP",
  "status": "active",
  "phase": "init",
  "context": {},
  "history": [],
  "prompts_executed": []
}
JSON

# ── Kontext-Datei anlegen ─────────────────────────────────────────────────────
cat > "$CURRENT_SESSION_DIR/context.md" <<MARKDOWN
# Session: $SESSION_NAME
**ID:** $SESSION_ID
**Gestartet:** $TIMESTAMP

---

## Ziel dieser Session

> _Hier das Ziel der Werkstatt-Session beschreiben._

## Kontext & Voraussetzungen

- [ ] Voraussetzung 1
- [ ] Voraussetzung 2

## Notizen

_Notizen erscheinen hier während der Session._

## Ausgeführte Prompt-Kaskaden

_Noch keine Kaskaden ausgeführt._
MARKDOWN

log_success "Session '$SESSION_NAME' ($SESSION_ID) erfolgreich angelegt."
log_info    "Kontext-Datei: sessions/current/context.md"
log_info    ""
log_info    "Nächste Schritte:"
log_info    "  • Prompt-Kaskade starten:  bash scripts/run-cascade.sh basis"
log_info    "  • Status prüfen:           bash scripts/session-status.sh"
log_info    "  • VS Code Tasks:           Strg+Shift+B"

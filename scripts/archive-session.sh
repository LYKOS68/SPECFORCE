#!/usr/bin/env bash
# SPECFORCE – Aktuelle Session archivieren
# Verwendung: bash scripts/archive-session.sh

source "$(dirname "$0")/_lib.sh"

log_header "SPECFORCE – Session archivieren"

if ! session_exists; then
  log_error "Keine aktive Session gefunden."
  exit 1
fi

SESSION_ID="$(session_get session_id)"
SESSION_NAME="$(session_get session_name)"

log_info "Session: $SESSION_NAME ($SESSION_ID)"

read -r -p "$(echo -e "${YELLOW}Session archivieren?${RESET} [j/N]: ")" CONFIRM
if [[ "${CONFIRM,,}" != "j" && "${CONFIRM,,}" != "ja" ]]; then
  log_info "Abgebrochen."
  exit 0
fi

# Status auf archived setzen
session_set status "archived"
session_set updated_at "$(now_iso)"

# In Archiv verschieben
mkdir -p "$ARCHIVE_DIR"
ARCHIVE_TARGET="$ARCHIVE_DIR/${SESSION_ID}_${SESSION_NAME// /_}"
mv "$CURRENT_SESSION_DIR" "$ARCHIVE_TARGET"

log_success "Session '$SESSION_NAME' archiviert nach: sessions/.archive/${SESSION_ID}_${SESSION_NAME// /_}"
log_info    "Neue Session starten mit: bash scripts/init-session.sh"

#!/usr/bin/env bash
# SPECFORCE – Aktuellen Session-Status anzeigen
# Verwendung: bash scripts/session-status.sh

source "$(dirname "$0")/_lib.sh"

log_header "SPECFORCE – Session-Status"

if ! session_exists; then
  echo -e "Status: ${YELLOW}Keine aktive Session${RESET}"
  echo ""
  log_info "Neue Session starten mit: bash scripts/init-session.sh"
  exit 0
fi

SESSION_ID="$(session_get session_id)"
SESSION_NAME="$(session_get session_name)"
STATUS="$(session_get status)"
PHASE="$(session_get phase)"
CREATED="$(session_get created_at)"
UPDATED="$(session_get updated_at)"

# Farbiger Status
case "$STATUS" in
  active)   STATUS_COLOR="${GREEN}${STATUS}${RESET}" ;;
  paused)   STATUS_COLOR="${YELLOW}${STATUS}${RESET}" ;;
  archived) STATUS_COLOR="${BLUE}${STATUS}${RESET}" ;;
  *)        STATUS_COLOR="${RED}${STATUS}${RESET}" ;;
esac

echo -e "  ${BOLD}Session-ID:${RESET}   $SESSION_ID"
echo -e "  ${BOLD}Name:${RESET}         $SESSION_NAME"
echo -e "  ${BOLD}Status:${RESET}       $STATUS_COLOR"
echo -e "  ${BOLD}Phase:${RESET}        ${PHASE:-–}"
echo -e "  ${BOLD}Erstellt:${RESET}     $CREATED"
echo -e "  ${BOLD}Aktualisiert:${RESET} $UPDATED"
echo ""

# Kontext-Datei anzeigen wenn vorhanden
CONTEXT_FILE="$CURRENT_SESSION_DIR/context.md"
if [[ -f "$CONTEXT_FILE" ]]; then
  echo -e "${BOLD}Kontext-Datei:${RESET} sessions/current/context.md"
  echo ""
fi

# Archivierte Sessions zählen
ARCHIVE_COUNT=0
if [[ -d "$ARCHIVE_DIR" ]]; then
  ARCHIVE_COUNT="$(find "$ARCHIVE_DIR" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')"
fi
echo -e "  ${BOLD}Archivierte Sessions:${RESET} $ARCHIVE_COUNT"

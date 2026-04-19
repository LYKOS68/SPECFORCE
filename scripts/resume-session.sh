#!/usr/bin/env bash
# SPECFORCE – Unterbrochene Session fortsetzen
# Verwendung: bash scripts/resume-session.sh

source "$(dirname "$0")/_lib.sh"

log_header "SPECFORCE Werkstatt – Session fortsetzen"

# ── Prüfen ob eine Session existiert ─────────────────────────────────────────
if ! session_exists; then
  log_error "Keine Session gefunden."
  log_info  "Neue Session starten mit: bash scripts/init-session.sh"
  exit 1
fi

SESSION_ID="$(session_get session_id)"
SESSION_NAME="$(session_get session_name)"
STATUS="$(session_get status)"

log_info "Session-ID:   $SESSION_ID"
log_info "Session-Name: $SESSION_NAME"
log_info "Status:       $STATUS"

case "$STATUS" in
  active)
    log_warn "Session ist bereits aktiv."
    ;;
  paused)
    TIMESTAMP="$(now_iso)"
    session_set status "active"
    session_set updated_at "$TIMESTAMP"
    log_success "Session '$SESSION_NAME' erfolgreich fortgesetzt."
    ;;
  archived)
    log_error "Diese Session ist archiviert und kann nicht fortgesetzt werden."
    log_info  "Neue Session starten mit: bash scripts/init-session.sh"
    exit 1
    ;;
  *)
    log_warn "Unbekannter Status '$STATUS'. Setze auf 'active'."
    session_set status "active"
    session_set updated_at "$(now_iso)"
    ;;
esac

log_info ""
log_info "Aktuelle Kontext-Datei: sessions/current/context.md"

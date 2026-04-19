# Sessions

Dieses Verzeichnis enthält alle Werkstatt-Sessions.

## Struktur

```
sessions/
├── session.template.json  # Vorlage für Session-Dateien
├── current/               # Aktive Session (auto-generiert)
│   ├── session.json       # Session-Metadaten
│   └── context.md         # Session-Kontext und Notizen
└── .archive/              # Archivierte Sessions
```

## Session-Zustände

| Status     | Beschreibung                          |
|------------|---------------------------------------|
| `idle`     | Keine aktive Session                  |
| `active`   | Session läuft                         |
| `paused`   | Session pausiert, kann fortgesetzt werden |
| `archived` | Session abgeschlossen und archiviert  |

## Verwendung

Sessions werden über die CLI-Skripte verwaltet:

```bash
# Neue Session starten
bash scripts/init-session.sh

# Session fortsetzen
bash scripts/resume-session.sh

# Session-Status anzeigen
bash scripts/session-status.sh

# Session archivieren
bash scripts/archive-session.sh
```

Oder via VS Code Tasks: `Strg+Shift+B` → Task auswählen.

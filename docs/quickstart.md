# SPECFORCE – Schnellstart

## Voraussetzungen

| Tool       | Zweck                              | Installation                         |
|------------|------------------------------------|--------------------------------------|
| **bash**   | CLI-Orchestrierung (Kern)          | Vorinstalliert (Linux/macOS/Git Bash) |
| **jq**     | JSON-Verarbeitung in Scripts       | `apt install jq` / `brew install jq` |
| **VS Code**| Werkstatt-IDE                      | [code.visualstudio.com](https://code.visualstudio.com) |

> **Hinweis:** Ohne `jq` wird automatisch auf `python3` als Fallback zurückgegriffen.

---

## 1. Repository öffnen

```bash
# Workspace direkt in VS Code öffnen
code SPECFORCE.code-workspace
```

---

## 2. Erste Session starten

**Via Terminal:**
```bash
bash scripts/init-session.sh "meine-erste-session"
```

**Via VS Code Task (`Strg+Shift+B`):**
→ `SPECFORCE: Neue Session starten`

---

## 3. Prompt-Kaskade ausführen

```bash
# Basis-Kaskade für Session-Initialisierung
bash scripts/run-cascade.sh basis

# Review-Kaskade am Ende der Session
bash scripts/run-cascade.sh review
```

---

## 4. Session verwalten

```bash
# Status anzeigen
bash scripts/session-status.sh

# Session pausieren → manuell Status setzen oder einfach Terminal schließen
# Session fortsetzen
bash scripts/resume-session.sh

# Session abschließen und archivieren
bash scripts/archive-session.sh
```

---

## Projektstruktur

```
SPECFORCE/
├── .vscode/
│   ├── settings.json      # Workspace-Einstellungen
│   ├── tasks.json         # VS Code Tasks für CLI-Befehle
│   └── extensions.json    # Empfohlene Extensions
├── scripts/
│   ├── _lib.sh            # Gemeinsame Hilfsfunktionen
│   ├── init-session.sh    # Neue Session starten
│   ├── resume-session.sh  # Session fortsetzen
│   ├── session-status.sh  # Status anzeigen
│   ├── archive-session.sh # Session archivieren
│   └── run-cascade.sh     # Prompt-Kaskade ausführen
├── sessions/
│   ├── README.md          # Dokumentation
│   ├── session.schema.json# Session-Daten-Schema
│   └── current/           # Aktive Session (auto-generiert)
│       ├── session.json   # Metadaten
│       └── context.md     # Kontext & Notizen
├── prompts/
│   ├── README.md          # Kaskaden-Dokumentation
│   ├── cascades/
│   │   ├── basis.yaml     # Basis-Initialisierungs-Kaskade
│   │   └── review.yaml    # Abschluss-Review-Kaskade
│   └── templates/
│       ├── kontext.md     # Kontext-Vorlage
│       └── ziel.md        # Ziel-Formulierungs-Vorlage
├── docs/
│   └── quickstart.md      # Diese Datei
├── SPECFORCE.code-workspace
└── README.md
```

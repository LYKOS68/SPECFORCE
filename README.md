# SPECFORCE

**Minimale Basis für eine session-basierte Werkstatt-Umgebung auf VS Code.**

SPECFORCE ist ein schlankes Gerüst, das als Ausgangspunkt für iterative,
prompt-gesteuerte Arbeitssessions dient – orchestriert über die CLI und
eingebettet in VS Code als zentrales Arbeitsverzeichnis.

---

## Konzept

| Konzept               | Beschreibung                                                      |
|-----------------------|-------------------------------------------------------------------|
| **Session**           | Eine abgeschlossene Arbeitseinheit mit Kontext, Ziel und History  |
| **Prompt-Kaskade**    | Geordnete Folge von Prompts, die eine Session strukturieren       |
| **CLI-Orchestrierung**| Alle Aktionen als Bash-Skripte – von VS Code oder Terminal aus    |
| **Werkstatt**         | VS Code Workspace als persistente, konfigurierte Arbeitsumgebung  |

---

## Schnellstart

```bash
# 1. Workspace öffnen
code SPECFORCE.code-workspace

# 2. Erste Session starten
bash scripts/init-session.sh "meine-erste-session"

# 3. Basis-Kaskade ausführen
bash scripts/run-cascade.sh basis

# 4. Status prüfen
bash scripts/session-status.sh
```

Vollständige Anleitung: [docs/quickstart.md](docs/quickstart.md)

---

## VS Code Tasks (`Strg+Shift+B`)

| Task                              | Beschreibung                        |
|-----------------------------------|-------------------------------------|
| Neue Session starten              | `init-session.sh` ausführen         |
| Session fortsetzen                | `resume-session.sh` ausführen       |
| Prompt-Kaskade ausführen          | `run-cascade.sh <name>` ausführen   |
| Session-Status anzeigen           | `session-status.sh` ausführen       |
| Session archivieren               | `archive-session.sh` ausführen      |

---

## Voraussetzungen

- **bash** (Linux / macOS / Git Bash auf Windows)
- **jq** oder **python3** für JSON-Verarbeitung
- **VS Code** als Werkstatt-IDE

---

## Lizenz

MIT

# Prompt-Kaskaden

Dieses Verzeichnis enthält alle Prompt-Vorlagen und -Kaskaden für SPECFORCE.

## Struktur

```
prompts/
├── README.md              # Diese Datei
├── cascades/              # Kaskaden-Definitionen (YAML)
│   ├── basis.yaml         # Basis-Kaskade für neue Sessions
│   └── review.yaml        # Review-Kaskade für Abschluss
└── templates/             # Wiederverwendbare Prompt-Bausteine
    ├── kontext.md         # Kontext-Vorlage
    └── ziel.md            # Ziel-Formulierungs-Vorlage
```

## Kaskaden-Format (YAML)

Eine Kaskade ist eine YAML-Datei mit einer geordneten Liste von Schritten:

```yaml
# Kaskaden-Metadaten
name: meine-kaskade
description: Beschreibung der Kaskade
version: "1.0"

# Schritte werden der Reihe nach ausgeführt
steps:
  - step: schritt-1-name
    prompt: |
      Der Prompt-Text für diesen Schritt.
      Kann mehrere Zeilen umfassen.

  - step: schritt-2-name
    prompt: |
      Zweiter Schritt in der Kaskade.
```

## Ausführung

```bash
bash scripts/run-cascade.sh <kaskaden-name>
```

Beispiel:
```bash
bash scripts/run-cascade.sh basis
bash scripts/run-cascade.sh review
```

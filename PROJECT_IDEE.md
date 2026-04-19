# PROJECT_IDEE.md — Projekt-/Ideen-Katalog (SPECFORCE)

Stand: 2026-04-19 23:49:59  
Repo: LYKOS68/SPECFORCE  
Prinzip: **Append-only** (Ideen werden nicht gelöscht; Status wird geändert, Historie bleibt erhalten)

## Zweck (Purpose)
Dieses Dokument ist der zentrale, dauerhafte Katalog für **alle Projekte, Teilprojekte, Ideen, Experimente und offenen Richtungsentscheidungen** in SPECFORCE.

Ziele:
- **Nichts geht verloren:** Jede neue Idee wird **angehängt**, nicht überschrieben.
- **Nachvollziehbarkeit:** Jede Idee hat eine ID, einen Status und klare Next Actions.
- **Ablageklarheit:** Jede Idee wird dem S‑SÄU-System zugeordnet (Zustand/Transformation/Information/Validierung + Ebene + ggf. ABCD).
- **Ableitbarkeit:** Aus Ideen werden überprüfbare Artefakte (Regeln, Dateien, Sessions, Validierungen) und später ggf. generierbarer Code.

## Arbeitsregeln (Append-only)
- Neue Einträge werden **immer unten** unter „Ideen-Register“ angefügt.
- Einträge werden **nicht gelöscht**.
- Änderungen erfolgen nur durch:
  - Statuswechsel (z. B. DRAFT → READY → ACTIVE → DONE)
  - Ergänzungen (z. B. Links, Outputs, Akzeptanzkriterien)
  - Klarstellungen (mit Datum)

## Status
- **DRAFT**: Idee ist frisch/unklar
- **READY**: Idee ist präzise genug für Umsetzung
- **ACTIVE**: in Arbeit
- **BLOCKED**: hängt an Entscheidung/Voraussetzung
- **DONE**: umgesetzt
- **ARCHIVED**: eingefroren, bleibt dokumentiert

## ID-Konvention
- Format: `IDEA-0001`, `IDEA-0002`, … fortlaufend
- IDs werden nie wiederverwendet

## S‑SÄU Zuordnung (Ablage)
- `01_S-SÄU-Zustand/` – Definitionen des Ausgangszustands, Baselines, Snapshots
- `02_S-SÄU-Transformation/` – Prozesse/Workflows, Schritte, Orchestrierung
- `03_S-SÄU-Information/` – Wissensbasis, Protokolle, Sessions, Daten
- `04_S-SÄU-Validierung/` – Checks, Tests, Review-Kriterien, Gates

Ebenen:
- `01_Ebene` (Grobstruktur)
- `02_Meso` (Subsysteme/Module)
- `03_Makro` (größere Bausteine)
- `04_Mikro` (Detailregeln/Einzelkomponenten)
- `05_MetaNano` (Meta-Regeln / Nano-Details)

ABCD:
- `ABCD_Pipeline/Alpha|Bravo|Charlie|Delta` – Phasen/Orchestrierungsstufen (Bedeutung wird separat festgelegt)

---

# Ideen-Register (append-only)

## IDEA-0001: SPECFORCE als Prompt-first / No-Code-first Produktionsprozess
**Status:** DRAFT  
**Kurzbeschreibung:** Projekte entstehen primär über Prompt-Frameworks und strategische Chat-Sessions; Code (falls überhaupt) ist ableitbares Output, nicht Startpunkt.  
**Ziel/Nutzen:** Reproduzierbarer, überprüfbarer Entwicklungsprozess mit klarer Struktur und Artefakten im Repo.  
**S‑SÄU-Zuordnung:** Übergreifend (alle Quadranten)  
**Inputs:** Prompt-Sessions, Regeln, Vorgaben  
**Outputs/Artefakte:** definierte Regeln, Zustände, Validierungen, Orchestrierung; später ggf. Codeableitung  
**Next Actions:** Zweck/Definition von „SPECFORCE“ (Namensbedeutung, Scope) im README und in PROJECT_CHARTA sauber festziehen.  
**Akzeptanzkriterien:** Eine dritte Person kann das Repo öffnen und den Prozess anwenden, ohne Kontext aus dem Chat zu benötigen.

## IDEA-0002: Repo als persistente Datenbasis/Projektverzeichnis für Sessions
**Status:** DRAFT  
**Kurzbeschreibung:** Das Repo speichert Sessions und deren Ergebnisse als dauerhafte Wissens-/Datenbasis.  
**Ziel/Nutzen:** Kontinuität zwischen Iterationen; keine „verlorenen“ Entscheidungen/Outputs.  
**S‑SÄU-Zuordnung:** 03_S-SÄU-Information (primär), 01_S-SÄU-Zustand (sekundär)  
**Next Actions:** Standard-Struktur für Session-Ordner + Minimal-Dateisatz definieren (z. B. `session.md`, `inputs.*`, `outputs.*`, `decisions.md`).  

## IDEA-0003: VS Code als UI/Arbeitsoberfläche (Workspace-first)
**Status:** DRAFT  
**Kurzbeschreibung:** VS Code ist die UI; das Repo ist der Workspace, in dem alles entsteht/organisiert wird.  
**Ziel/Nutzen:** Einheitlicher Arbeitskontext, klare Navigation über Ordnerstruktur.  
**S‑SÄU-Zuordnung:** Meta/Organisation  
**Next Actions:** Optional: `.vscode/` Empfehlungen (Settings/Extensions) definieren.

## IDEA-0004: Chat+CLI-Steuerung mit Permissions und Checkpoints
**Status:** DRAFT  
**Kurzbeschreibung:** Chat steuert über definierte Kommandos/Permissions Änderungen; Checkpoints synchronisieren Zustände in Sequenzen.  
**Ziel/Nutzen:** Kontrollierte Änderungen, Wiederholbarkeit, Auditierbarkeit.  
**S‑SÄU-Zuordnung:** 02_S-SÄU-Transformation + 04_S-SÄU-Validierung  
**Next Actions:** Gate-/Permission-Regeln beschreiben (was darf automatisch geschrieben werden, was nur nach Bestätigung?).

## IDEA-0005: S‑SÄU + Ebenen + ABCD als formales Ablage-/Orchestrierungsmodell
**Status:** ACTIVE  
**Kurzbeschreibung:** Quadranten (Zustand/Transformation/Information/Validierung) + Ebenen (01–05) + ABCD-Pipeline strukturieren Artefakte.  
**Ziel/Nutzen:** Skalierbare Ordnung von grob→fein, plus Prozessstufen über die Pipeline.  
**S‑SÄU-Zuordnung:** Root-Struktur `01_...` bis `04_...` ist bereits angelegt.  
**Next Actions:** Bedeutung von Alpha/Bravo/Charlie/Delta festlegen und pro Quadrant definieren, welche Artefakte dort liegen.

---

## Template: Neue Idee anfügen (kopieren)

## IDEA-XXXX: <Titel>
**Status:** DRAFT  
**Datum hinzugefügt:** 2026-04-19  
**Kurzbeschreibung:**  
**Ziel/Nutzen:**  
**S‑SÄU-Zuordnung:** (Quadrant + Ebene + ggf. ABCD)  
**Inputs:**  
**Outputs/Artefakte:**  
**Risiken/Abhängigkeiten:**  
**Next Actions:**  
**Akzeptanzkriterien:**  

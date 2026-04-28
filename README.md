# DB2 Embedded SQL (COBOL)

This extension is **centered on embedded DB2 SQL** (`EXEC SQL` … `END-EXEC`). It is **not** a replacement for a full COBOL language extension.

## Who highlights what

- **Normal COBOL** (divisions, paragraphs, `MOVE`, `PIC`, data names, folding, etc.) comes from **your existing COBOL extension** and its TextMate grammar. Install whichever COBOL extension you prefer for `.cbl`, `.cob`, `.cpy`, and related files.

- **Embedded SQL** inside `EXEC SQL` … `END-EXEC` is added by **this** extension via an **injection grammar** (`syntaxes/db2-sql-injection.tmLanguage.json`). It only targets those blocks; it does not try to re-highlight all of COBOL.

- **Standalone “DB2 COBOL” language** is a **small fallback** for **`.sqlcbl`** and **`.sqb`** only (`syntaxes/db2-cobol.tmLanguage.json`): basic comments, strings, a short keyword list, plus the same embedded-SQL rules. It is **not** meant to match rich COBOL extensions. For production COBOL editing, prefer a dedicated COBOL extension and rely on injection for SQL.

This extension **does not register** `.cbl`, `.cob`, or `.cpy` for the `db2-cobol` language id, so it will not take those associations away from another extension.

## Injection vs standalone

| Mechanism | Where | Role |
|-----------|--------|------|
| Injection | `injectTo` in `package.json` → `db2-sql-injection.tmLanguage.json` | SQL highlighting inside `EXEC SQL` … `END-EXEC` when the editor uses a supported COBOL root scope. |
| Standalone | Language id `db2-cobol` on **`.sqlcbl`** / **`.sqb`** only | Minimal COBOL-ish coloring + embedded SQL when you open those extensions without a full COBOL grammar, or for quick viewing. |

Keep `exec-sql-*` / `sql-*` rules in the injection file and the standalone file **in step** if you change SQL highlighting (they are duplicated on purpose; VS Code does not cross-include TextMate repositories).

## Default injection targets

See `package.json` → `contributes.grammars` → `injectTo`. To discover your COBOL extension’s root scope or add a new target, see **[docs/testing.md](docs/testing.md)**.

## Development

Open this folder in VS Code and use **Run Extension** (F5) from `.vscode/launch.json` to test in an Extension Development Host.

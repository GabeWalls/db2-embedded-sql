# DB2 Embedded SQL (COBOL)

This extension complements **existing COBOL language extensions**. It does not try to own standard COBOL file extensions (`.cbl`, `.cob`, `.cpy`).

## What to use for which files

- **Regular COBOL** (`.cbl`, `.cob`, `.cpy`, and similar): install and use a **COBOL extension** you already rely on (syntax, folding, snippets, etc.). This project does not register those extensions for its own language id, so it will not displace another extension’s grammar association.

- **Embedded DB2 SQL in COBOL**: when your COBOL grammar exposes a **root TextMate scope** this extension knows about (see below), it **injects** rules that only match **`EXEC SQL` … `END-EXEC`** (and optional `.` after `END-EXEC`). Normal COBOL outside those spans is left to the host COBOL grammar; injection is also skipped inside **string** and **comment** scopes from the host grammar where those scopes are named in a conventional way.

- **Standalone “DB2 COBOL” mode**: files **`.sqlcbl`** and **`.sqb`** are associated with the **`db2-cobol`** language id and use the full bundled grammar (`syntaxes/db2-cobol.tmLanguage.json`)—COBOL keywords, comments, strings, and embedded SQL. Use this when you want this extension alone, or when injection does not apply (unsupported root scope, or host scopes that do not match the injection selector).

## Injection vs standalone

| Mechanism | Scope / association | Role |
|-----------|---------------------|------|
| Injection | `syntaxes/db2-sql-injection.tmLanguage.json` → `injectTo` | Adds EXEC SQL … END-EXEC highlighting inside existing COBOL documents. |
| Standalone | Language `db2-cobol` on `.sqlcbl` / `.sqb` | Full fallback / manual mode using `syntaxes/db2-cobol.tmLanguage.json`. |

SQL-related rules in the injection file are kept aligned with the standalone grammar’s `exec-sql-*`, `sql-*`, and string rules; if you change one, consider updating the other.

## Assumptions about COBOL TextMate scopes

Injection is registered for these **root grammar scope names** (via `injectTo`):

- `source.cobol`
- `source.cobol85`
- `source.gnucobol`

These match several common community / GnuCOBOL setups but are **not guaranteed** for every COBOL extension. If your extension uses a different root (for example `source.enterprise-cobol`), injection will not load until `package.json` `injectTo` (and the injection grammar’s `injectionSelector`, if needed) are extended to include that scope.

The injection `injectionSelector` additionally requires the injection point to sit under one of those roots and **excludes** `string` and `comment` (so `EXEC SQL` inside a string literal is not treated as SQL). If a COBOL grammar names strings or comments unusually (so they do not carry `string` / `comment` in the scope path), behavior may differ.

## Development

Open this folder in VS Code and use **Run Extension** (F5) from `.vscode/launch.json` to test in an Extension Development Host.

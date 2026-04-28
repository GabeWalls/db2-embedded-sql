# DB2 Embedded SQL

**DB2 Embedded SQL** adds syntax highlighting for **IBM Db2 SQL embedded in COBOL**—that is, statements between **`EXEC SQL`** and **`END-EXEC`** (with optional **`.`** after `END-EXEC`). It is intentionally **not** a full COBOL language extension.

## Features

- **Injection mode:** Highlights SQL keywords, host variables (`:name`), and SQL-style comments **inside** `EXEC SQL` … `END-EXEC` blocks when you edit COBOL with a grammar that exposes a supported root scope (see below).
- **Fallback mode:** A minimal **`db2-cobol`** language (basic comments, strings, a short keyword list, plus the same embedded-SQL rules) for **`.sqlcbl`** and **`.sqb`** only—useful for quick viewing or when injection does not apply.
- **Snippets** (language **`db2-cobol`** only): `execsql`, `selectinto`, `declarecursor`, `opencursor`, `fetchcursor`, `closecursor`, `commit`, `rollback`, `sqlca`.

## Supported file types

| Association | Extensions | Role |
|-------------|------------|------|
| **This extension** | **`.sqlcbl`**, **`.sqb`** | Language id `db2-cobol`: fallback grammar + snippets. |
| **Your COBOL extension** | **`.cbl`**, **`.cob`**, **`.cpy`**, etc. | Normal COBOL highlighting; this extension **does not** register these extensions for `db2-cobol`, so it does not replace your COBOL grammar. |

## Injection mode vs fallback mode

| Mode | When it applies | What you get |
|------|-----------------|--------------|
| **Injection** | File uses a COBOL language whose grammar root is listed in `package.json` → `injectTo` (e.g. `source.cobol`). | SQL-focused highlighting **only** inside `EXEC SQL` … `END-EXEC`. All other COBOL comes from **your** COBOL extension. |
| **Fallback** | File is **`.sqlcbl`** or **`.sqb`** (language `db2-cobol`). | Minimal COBOL-ish highlighting **plus** embedded SQL rules—enough for small samples or tooling output, **not** a substitute for a mature COBOL highlighter. |

To learn your COBOL grammar’s root scope or add a new injection target, see **[docs/testing.md](docs/testing.md)**.

## Local testing

1. Clone or open this repository in VS Code.
2. Run **Run Extension** (**F5**) using [`.vscode/launch.json`](.vscode/launch.json) to start an **Extension Development Host**.
3. In the host window:
   - Open a **`.cbl`** file with your COBOL extension enabled and confirm SQL inside `EXEC SQL` … `END-EXEC` picks up SQL scopes (use **Developer: Inspect Editor Tokens and Scopes** on a `SELECT` token).
   - Open a **`.sqlcbl`** or **`.sqb`** file and confirm `db2-cobol` highlighting and snippets (prefixes such as `execsql`, `sqlca`).

## Known limitations

- **Not a full COBOL grammar:** Division/section structure, copybooks, and rich COBOL semantics are out of scope; use a dedicated COBOL extension for `.cbl` / `.cob` / `.cpy`.
- **Injection roots are fixed:** Only grammars whose base scope matches `injectTo` (see `package.json`) receive SQL injection; others require a local change to `injectTo` and `injectionSelector` (documented in `docs/testing.md`).
- **String/comment guard:** Injection skips scopes whose path includes `string` or `comment`; unusual host grammars may behave differently.
- **Snippets** apply only when the language mode is **`db2-cobol`** (i.e. mainly **`.sqlcbl`** / **`.sqb`**), not automatically for all COBOL extensions.
- **SQL keyword list** is finite; rare Db2 syntax may not match a dedicated SQL extension.

## Roadmap

- **RPG** embedded SQL highlighting (similar injection pattern for RPG sources) is **planned**; not included in the current release.

## Development

From the repo root, **F5** → Extension Development Host. See `docs/testing.md` for token inspection and extending injection targets.

## Publisher

`package.json` sets `publisher` for local packaging; **change it to your Marketplace publisher id** before publishing to the VS Code Marketplace.

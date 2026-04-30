# DB2 Embedded SQL

Adds syntax highlighting for SQL inside COBOL (`EXEC SQL ... END-EXEC`).

Works with your existing COBOL extension — it does not replace it.

## What it does

- Highlights SQL keywords inside `EXEC SQL ... END-EXEC`
- Highlights host variables like `:WS-NAME`
- Keeps your normal COBOL highlighting intact

## How it works

### With a COBOL extension (recommended)
- Open `.cbl`, `.cob`, `.cpy`, etc.
- Your COBOL extension handles COBOL
- This extension highlights the SQL inside it

### Fallback mode
- For `.sqlcbl` and `.sqb` files
- Uses a lightweight built-in COBOL + SQL highlighter

## Notes

- This is not a full COBOL language extension
- Designed to enhance, not replace COBOL tooling
- Works best alongside an existing COBOL extension

## Roadmap

- RPG embedded SQL support (planned)

## Installation

Install from the VS Code Marketplace or via `.vsix`.

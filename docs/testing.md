# Testing injection and COBOL scopes

## Find the root TextMate scope of your COBOL grammar

VS Code needs the **root grammar scope name** (for example `source.cobol`) to know where to inject this extension’s SQL rules. That name must appear in `package.json` under `contributes.grammars[].injectTo` for the `db2-sql-injection.tmLanguage.json` entry.

### Use “Developer: Inspect Editor Tokens and Scopes”

1. Open a `.cbl` (or other) file that uses **your COBOL extension’s** language mode (not `db2-cobol` unless you chose it manually).
2. Run the command palette (**Ctrl+Shift+P** / **Cmd+Shift+P**) and choose **Developer: Inspect Editor Tokens and Scopes**.
3. Move the cursor over **ordinary COBOL code** (not inside a string or comment), ideally a line such as `MOVE` or `PROCEDURE DIVISION`.
4. In the hover / picker, read the **stack of scopes** from the top downward. The **first scope that represents the document’s base language** is usually the root you care about, for example:
   - `source.cobol`
   - `source.cobol85`
   - `source.gnucobol`
5. If the top entries are only `text.plain` or something unrelated, the file may not be using a COBOL grammar (wrong language mode or extension disabled).

Use that root string when adding a new injection target (see below).

## Known injection targets (shipped)

These are already listed in `package.json` → `injectTo` for `source.db2-sql-injection.cobol`:

| Scope | Typical use |
|-------|----------------|
| `source.cobol` | Common COBOL / bitlang-style grammars |
| `source.cobol85` | COBOL-85–oriented grammars |
| `source.gnucobol` | GnuCOBOL-oriented grammars |

The injection grammar’s `injectionSelector` in `syntaxes/db2-sql-injection.tmLanguage.json` is aligned with these roots (and excludes `string` / `comment` subtrees to reduce false matches).

## Adding another COBOL root scope

If **Inspect Editor Tokens** shows a root like `source.yourvendor-cobol` and SQL blocks are not highlighted:

1. **Confirm** the cursor stack includes that scope on normal COBOL lines.
2. Edit **`package.json`**: under the grammar object whose `path` is `./syntaxes/db2-sql-injection.tmLanguage.json`, append the new scope to the **`injectTo`** array, for example:
   ```json
   "injectTo": [
     "source.cobol",
     "source.cobol85",
     "source.gnucobol",
     "source.yourvendor-cobol"
   ]
   ```
3. Edit **`syntaxes/db2-sql-injection.tmLanguage.json`**: extend **`injectionSelector`** so the injected rules apply under that root, for example add it to the parenthesized OR list:
   ```json
   "injectionSelector": "(L:source.cobol | L:source.cobol85 | L:source.gnucobol | L:source.yourvendor-cobol) -string -comment"
   ```
4. Reload the window (**Developer: Reload Window**) or restart the Extension Development Host after **F5** changes.

If the host grammar names strings or comments in a non-standard way, `-string -comment` might not match; you may need to relax or adjust the selector (trade-off: fewer false SQL matches vs. more coverage).

## Quick check that injection runs

1. With your COBOL extension enabled, open a program that contains `EXEC SQL` … `END-EXEC`.
2. Inspect a token **inside** the SQL block (e.g. `SELECT`): you should see scopes such as `keyword.other.sql` and `meta.embedded.block.sql.cobol` from this extension **in addition to** the host COBOL scopes.
3. If you only see host scopes and no `keyword.other.sql` / `meta.embedded.block.sql.cobol`, the root scope is probably not in `injectTo` yet—repeat the steps above.

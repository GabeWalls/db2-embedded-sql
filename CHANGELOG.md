# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.6] - 2026-04-30

### Changed

- **COBOL fallback scopes:** Split reserved words into `keyword.control.cobol` (control flow: `IF`, `ELSE`, `END-IF`, `EVALUATE`, `WHEN`, `PERFORM`, `GO TO`, `GOTO`, `CALL`, `EXIT`, `STOP`, `GOBACK`, etc.), `support.function.cobol` (statement verbs such as `MOVE`, `TO`, `OPEN` / `INPUT` / `OUTPUT`, `READ`, `WRITE`, `DISPLAY`, `COMPUTE`, etc.), `storage.type.cobol` / `storage.modifier.cobol` (data clauses such as `PIC` / `PICTURE`, `VALUE` / `VALUES`, `REDEFINES`, `OCCURS`, `TIMES`, `COMP` / `COMP-3`, `USAGE`, etc.), and `keyword.other.cobol` for remaining structural / miscellaneous COBOL tokens—closer to common theme mappings for mature COBOL grammars (no theme colors hard-coded).
- **Embedded SQL scopes:** `EXEC SQL` and `END-EXEC` use `keyword.other.sql.embedded.cobol`; inside the block, `--` comments use `comment.line.double-dash.sql`, `/* */` use `comment.block.sql`, literals use `string.quoted.single.sql` / `string.quoted.double.sql`, with `keyword.other.sql`, `support.function.sql`, `variable.other.host.sql`, and `constant.numeric.sql` unchanged in role but applied consistently in both fallback and injection grammars.
- **DB2 SQL coverage:** Retained and ordered rules for common embedded SQL (including `NOT FOUND`, `GO TO` / `GOTO`, aggregates, scalar functions, and `CURRENT DATE` / `TIME` / `TIMESTAMP` / `USER`).

### Notes

- RPG embedded SQL support remains planned and is **not** included in this release.

## [0.0.5] - 2026-04-30

### Changed

- **COBOL fallback (`.sqlcbl` / `.sqb`):** Highlight standard data level numbers (`01`–`49`, `66`, `77`, `88`) on fixed-format lines (after sequence/change and column 7), scoped as `constant.numeric.level.cobol`, without treating `PIC` picture clauses like `9(5)` or `X(50)` as level numbers.
- **COBOL fallback:** Highlight hyphenated data names (e.g. `VEH-DESC`, `DISPLAY-DATE`, `RECORD-DATE`) as `variable.other.cobol`, with exclusions for common hyphenated reserved phrases.
- **Embedded SQL:** Broader DB2-style keyword and function coverage in both fallback and injection grammars (`keyword.other.sql`, `support.function.sql`), including joins, fetch/row limits, cursor lifecycle, `WHENEVER` / `SQLERROR` / `SQLWARNING` / `NOT FOUND`, `INCLUDE` / `SQLCA` / `SQLDA`, set operators, `CASE`, predicates, aggregates, scalar functions, and `CURRENT DATE` / `CURRENT TIME` / `CURRENT TIMESTAMP` / `CURRENT USER`.
- **Consistency:** SQL token rules and ordering are aligned between `db2-cobol.tmLanguage.json` and `db2-sql-injection.tmLanguage.json` (comments, strings, `CURRENT …`, numeric literals, host variables, then functions then keywords).

### Notes

- RPG embedded SQL support remains planned and is **not** included in this release.

## [0.0.1] - 2026-04-28

### Added

- Injection grammar for `EXEC SQL` … `END-EXEC` into common COBOL TextMate roots (`source.cobol`, `source.cobol85`, `source.gnucobol`).
- Standalone language `db2-cobol` with minimal grammar for `.sqlcbl` and `.sqb` (comments, strings, basic COBOL keywords, embedded SQL).
- Snippets for `db2-cobol`: `execsql`, `selectinto`, `declarecursor`, `opencursor`, `fetchcursor`, `closecursor`, `commit`, `rollback`, `sqlca`.
- Documentation: README, `docs/testing.md` (token inspection and extending `injectTo`).

### Notes

- Does not register `.cbl`, `.cob`, or `.cpy`; normal COBOL highlighting remains the responsibility of your COBOL extension.

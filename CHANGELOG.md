# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2026-04-28

### Added

- Injection grammar for `EXEC SQL` … `END-EXEC` into common COBOL TextMate roots (`source.cobol`, `source.cobol85`, `source.gnucobol`).
- Standalone language `db2-cobol` with minimal grammar for `.sqlcbl` and `.sqb` (comments, strings, basic COBOL keywords, embedded SQL).
- Snippets for `db2-cobol`: `execsql`, `selectinto`, `declarecursor`, `opencursor`, `fetchcursor`, `closecursor`, `commit`, `rollback`, `sqlca`.
- Documentation: README, `docs/testing.md` (token inspection and extending `injectTo`).

### Notes

- Does not register `.cbl`, `.cob`, or `.cpy`; normal COBOL highlighting remains the responsibility of your COBOL extension.

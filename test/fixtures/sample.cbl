      *> Free-form: optional leading whitespace then *>
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMPDEMO.
      *> Sample fixture: normal COBOL, SQL blocks, fixed/free comments
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-NAME          PIC X(40).
       01  WS-COUNT         PIC S9(9) COMP.
      * Fixed-format comment: asterisk in column 7 (cols 1-6 are sequence/blank)
       EXEC SQL INCLUDE SQLCA END-EXEC.
       PROCEDURE DIVISION.
      / Fixed-format comment: slash in column 7 for compiler directing line
           DISPLAY 'Normal COBOL before any SQL block.'
           MOVE 'O''BRIEN' TO WS-NAME
           EXEC SQL
             SELECT COUNT(*)
               INTO :WS-COUNT
               FROM SYSIBM.SYSDUMMY1
              WHERE 1 = 1
              -- SQL line comment inside EXEC SQL
           END-EXEC
           DISPLAY 'COBOL after SQL; count was:' WS-COUNT
           GOBACK
           .

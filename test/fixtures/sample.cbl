       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMPDEMO.
      *> Sample for DB2 embedded SQL highlighting
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-NAME          PIC X(40).
       01  WS-COUNT         PIC S9(9) COMP.
       EXEC SQL INCLUDE SQLCA END-EXEC
       PROCEDURE DIVISION.
           MOVE 'O''BRIEN' TO WS-NAME
           EXEC SQL
             SELECT COUNT(*)
               INTO :WS-COUNT
               FROM SYSIBM.SYSDUMMY1
              WHERE 1 = 1
           END-EXEC
           DISPLAY WS-COUNT
           GOBACK
           .

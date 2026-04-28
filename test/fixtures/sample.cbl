      *> Free-form comment line (*> after optional whitespace)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMPDEMO.
      *> Fixture: divisions, sections, levels, PIC, verbs, literals, figuratives, SQL
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Fixed-format: * in column 7 (sequence area 1-6 then comment)
       01  WS-NAME          PIC X(40) VALUE SPACES.
       05  WS-COUNT         PIC S9(9) COMP.
       05  WS-AMT           PIC 9(4)V99.
       77  WS-FLAG          PIC X VALUE 'N'.
       PROCEDURE DIVISION.
      / Fixed-format: / in column 7 (compiler-directing style line)
       010-MAIN.
           DISPLAY 'Paragraph 010-MAIN; literals and figuratives below.'
           MOVE ZERO TO WS-COUNT
           MOVE HIGH-VALUE TO WS-FLAG
           MOVE 100 TO WS-COUNT
           MOVE +1 TO WS-COUNT
           COMPUTE WS-AMT = 3.14 * 2
           IF WS-COUNT > 50
               GO TO 030-EXIT
           END-IF
           CALL 'SUBPROG' USING WS-NAME
           PERFORM 020-BRANCH
           .
       020-BRANCH.
           MOVE SPACES TO WS-NAME
           EXEC SQL INCLUDE SQLCA END-EXEC.
           EXEC SQL
             SELECT COUNT(*)
                  , CHAR(CURRENT DATE)
               INTO :WS-COUNT
                  , :WS-NAME
               FROM SYSIBM.SYSDUMMY1
              WHERE 1 = 1
              -- host vars :WS-* should stay variable.other.host.sql
           END-EXEC.
           CONTINUE.
       030-EXIT.
           GOBACK
           .

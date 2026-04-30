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

      *> Fixed-format style: cols 1-6 = sequence/change, col 7 blank, then level + names
654321      01  VEH-RECORD.
654321          05 VEH-DESC          PIC X(50).
654321          05 VEH-YR            PIC 9(4).
654321          05 DISPLAY-DATE      PIC X(10).
654321          05 DISPLAY-DATX      PIC X(10).
654321          05 DD8-MM            PIC X(8).
654321          05 RECORD-DATE       PIC X(10).
654321          05 AMT-FMT           PIC S9(7)V99.
654321      77  WS-SQLCODE          PIC S9(9) COMP.
654321      88  END-OF-DATA         VALUE HIGH-VALUES.
654321      88  HAS-ROWS            VALUE 'Y' 'y'.

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

       040-SQL.
654321          EXEC SQL
654321              DECLARE C1 CURSOR FOR
654321              SELECT VEH-DESC, VEH-YR, COALESCE(TRIM(:WS-NAME), ' ')
654321              FROM VEHICLE
654321              WHERE VEH-YR BETWEEN :WS-COUNT AND INTEGER(2026)
654321              GROUP BY VEH-DESC, VEH-YR
654321              HAVING COUNT(*) > 0
654321              ORDER BY VEH-YR DESC
654321              FETCH FIRST 10 ROWS ONLY
654321          END-EXEC
654321          EXEC SQL OPEN C1 END-EXEC
654321          EXEC SQL FETCH C1 INTO :WS-NAME, :WS-COUNT END-EXEC
654321          EXEC SQL
654321              UPDATE VEHICLE SET VEH-DESC = UPPER(:WS-NAME)
654321              WHERE VEH-YR = (SELECT MAX(VEH-YR) FROM VEHICLE V)
654321          END-EXEC
654321          EXEC SQL INSERT INTO LOG (MSG, TS) VALUES (:WS-NAME, CURRENT TIMESTAMP) END-EXEC
654321          EXEC SQL DELETE FROM LOG WHERE LENGTH(TRIM(MSG)) = 0 END-EXEC
654321          EXEC SQL COMMIT WORK END-EXEC
654321          EXEC SQL ROLLBACK WORK END-EXEC
654321          EXEC SQL WHENEVER NOT FOUND CONTINUE END-EXEC
654321          EXEC SQL WHENEVER SQLWARNING CONTINUE END-EXEC
654321          EXEC SQL WHENEVER SQLERROR GO TO DB-ERROR END-EXEC
654321          .

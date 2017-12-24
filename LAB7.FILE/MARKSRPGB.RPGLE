000100171123     FMARKSDSPB CF   E             WORKSTN
000101171123     DMINIMUM          S             10I 0
000102171123      /FREE
000103171123
000104171123            EXFMT RECORD1;
000105171123                  NUMQUERY = 0;
000106171123                  FAILURES = 0;
000107171123                  PASSES = 0;
000108171123                  TOTALGRADE = 0;
000110171123                  DOW NOT(*IN03);
000111171123                       EXSR GETGRADE;
000112171123                       WRITE RECORD1;
000113171123                       EXFMT RECORD2;
000114171123                       IF *IN03 = *OFF;
000115171123                               EXSR CLEARMARKS;
000117171123                               EXFMT RECORD1;
000119171123                       ENDIF;
000120171123                       EXSR QUERIES;
000122171123                  ENDDO;
000123171123                  EXSR QUERYRPT;
000124171123            *INLR = *ON;
000125171123            RETURN;
000126171123
000127171123            BEGSR GETGRADE;
000128171123                LETGRADE = 'F';
000129171123                SELECT;
000130171123                  WHEN (TEST1 < TEST2);
000131171123                    SELECT;
000132171123                      WHEN (TEST1 < TEST3);
000133171123                        MINIMUM = TEST1;
000134171123                        *IN31 = *ON;
000135171123                      OTHER;
000136171123                        *IN31 = *OFF;
000137171123                        MINIMUM = TEST3;
000138171123                        *IN33 = *ON;
000139171123                    ENDSL;
000140171123                  OTHER;
000141171123                    SELECT;
000142171123                      WHEN (TEST2 < TEST3);
000143171123                        MINIMUM = TEST2;
000144171123                        *IN32 = *ON;
000145171123                      OTHER;
000146171123                        *IN32 = *OFF;
000147171123                        MINIMUM = TEST3;
000148171123                        *IN33 = *ON;
000149171123                    ENDSL;
000150171123
000152171123                  ENDSL;
000153171123
000161171123                TESTOVRALL = (TEST1 + TEST2 + TEST3 - MINIMUM) / 2;
000162171123                NUMGRADE = (((TESTOVRALL + EXAM) * 70) / 200) + LABS;
000163171123
000164171123            SELECT;
000165171123                WHEN (TESTOVRALL > 50);
000166171123                    SELECT;
000167171123                        WHEN (EXAM > 50);
000168171123                            SELECT;
000169171123                                WHEN (NUMGRADE >= 90);
000170171123                                    LETGRADE = 'A+';
000171171123                                WHEN (NUMGRADE >= 80);
000172171123                                    LETGRADE = 'A';
000173171123                                WHEN (NUMGRADE >= 75);
000174171123                                    LETGRADE = 'B+';
000175171123                                WHEN (NUMGRADE >= 70);
000176171123                                    LETGRADE = 'B';
000177171123                                WHEN (NUMGRADE >= 65);
000178171123                                    LETGRADE = 'C+';
000179171123                                WHEN (NUMGRADE >= 60);
000180171123                                    LETGRADE = 'C';
000181171123                                WHEN (NUMGRADE >= 55);
000182171123                                    LETGRADE = 'D+';
000183171123                                WHEN (NUMGRADE >= 50);
000184171123                                    LETGRADE = 'D';
000185171123                                OTHER;
000186171123                                    LETGRADE = 'F';
000188171123                            ENDSL;
000189171123                        OTHER;
000191171123                            LETGRADE = 'F';
000192171123                            *IN34 = *ON;
000193171123                    ENDSL;
000194171123                OTHER;
000195171123                    LETGRADE = 'F';
000196171123                    SELECT;
000197171123                      WHEN (EXAM < 50);
000198171123                        *IN34 = *ON;
000199171123                    ENDSL;
000200171123                    *IN35 = *ON;
000201171123            ENDSL;
000202171123            ENDSR;
000203171123
000204171123            BEGSR QUERIES;
000205171123              TOTALGRADE += NUMGRADE;
000206171123              NUMQUERY +=1;
000207171123              SELECT;
000208171123                WHEN (LETGRADE = 'F');
000209171123                  FAILURES += 1;
000210171123                OTHER;
000211171123                  PASSES +=1;
000212171123              ENDSL;
000213171123              TOTALAVG = TOTALGRADE / NUMQUERY;
000215171123            ENDSR;
000216171123
000217171123            BEGSR CLEARMARKS;
000218171123                TEST1 = 0;
000219171123                TEST2 = 0;
000220171123                TEST3 = 0;
000221171123                LABS = 0;
000222171123                EXAM = 0;
000223171123                *IN31 = *OFF;
000224171123                *IN32 = *OFF;
000225171123                *IN33 = *OFF;
000226171123                *IN34 = *OFF;
000227171123                *IN35 = *OFF;
000228171123            ENDSR;
000229171123
000230171123            BEGSR QUERYRPT;
000231171123              EXFMT RECORD3;
000233171123            ENDSR;
000234171123
000235171123

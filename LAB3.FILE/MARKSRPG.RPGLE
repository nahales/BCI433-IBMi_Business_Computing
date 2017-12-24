000100171016     FMARKSDSP  CF   E             WORKSTN
000101171016      /FREE
000102171016            EXFMT RECORD1;
000103171016                  DOW NOT(*IN03);
000104171016                       EXSR GETGRADE;
000105171016                       WRITE RECORD1;
000106171016                       EXFMT RECORD2;
000107171016                       IF *IN03 = *OFF;
000108171016                               EXSR CLEARMARKS;
000109171016                               EXFMT RECORD1;
000110171016                       ENDIF;
000111171016                  ENDDO;
000112171016            *INLR = *ON;
000113171016            RETURN;
000114171016
000115171016            BEGSR GETGRADE;
000116171016                LETGRADE = 'F';
000117171016                TESTOVRALL = (TEST1 + TEST2 + TEST3) / 3;
000118171016                NUMGRADE = (((TESTOVRALL + EXAM) * 70) / 200) + LABS;
000119171016
000120171016            SELECT;
000121171016                WHEN (TESTOVRALL > 50);
000122171016                    SELECT;
000123171016                        WHEN (EXAM > 50);
000124171016                            SELECT;
000125171016                                WHEN (NUMGRADE >= 90);
000126171016                                    LETGRADE = 'A+';
000127171016                                WHEN (NUMGRADE >= 80);
000128171016                                    LETGRADE = 'A';
000129171016                                WHEN (NUMGRADE >= 75);
000130171016                                    LETGRADE = 'B+';
000131171016                                WHEN (NUMGRADE >= 70);
000132171016                                    LETGRADE = 'B';
000133171016                                WHEN (NUMGRADE >= 65);
000134171016                                    LETGRADE = 'C+';
000135171016                                WHEN (NUMGRADE >= 60);
000136171016                                    LETGRADE = 'C';
000138171016                                WHEN (NUMGRADE >= 55);
000139171016                                    LETGRADE = 'D+';
000140171016                                WHEN (NUMGRADE >= 50);
000141171016                                    LETGRADE = 'D';
000142171016                                OTHER;
000143171016                                    LETGRADE = 'F';
000144171016                            ENDSL;
000145171016                        OTHER;
000146171016                            LETGRADE = 'F';
000147171016                    ENDSL;
000148171016                OTHER;
000149171016                    LETGRADE = 'F';
000150171016            ENDSL;
000151171016            ENDSR;
000152171016            BEGSR CLEARMARKS;
000153171016                TEST1 = 0;
000154171016                TEST2 = 0;
000155171016                TEST3 = 0;
000156171016                LABS = 0;
000157171016                EXAM = 0;
000158171016            ENDSR;
000159171016
000160171016
000161171016

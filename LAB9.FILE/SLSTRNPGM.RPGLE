000100171201     FSALESTRANSIF   E             DISK    RENAME(SALESTRANS:SALESTRANR)
000101171201     FSALESSTAF2UF A E           K DISK
000102171201     FQPRINT    O    F  132        PRINTER OFLIND(*INOF)
000103171201     D SALESTRANSDS    DS
000104171201     D   TDEPT
000105171201     D   TSALESID
000106171201     D   TFNAME
000107171201     D   TLNAME
000108171201     D   TCITY
000109171201     D   TADDRESS
000110171201     D   TPCODE
000111171201     D SALESSTAF2DS    DS
000112171201     D    DEPT
000113171201     D    SALESID
000114171201     D    FNAME
000115171201     D    LNAME
000116171201     D    CITY
000117171201     D    ADDRESS
000118171201     D    PCODE
000119171201     D FullKey         DS                  LikeRec(SALESTFR: *Key)
000120171201     C/FREE
000121171201                   EXCEPT    HEADINGS;
000122171201                   READ      SALESTRANS;
000123171201                   DOW       NOT %EOF;
000124171201                      FullKey = TDept + TSalesID;
000125171201                      CHAIN %KDS(FullKey)        SalesStaf2;
000126171201                      SELECT;
000127171201                        WHEN      %FOUND(SALESSTAF2);
000128171201                        SELECT;
000129171201                           WHEN      TCODE = 'C';
000130171201                              EXSR      CHGREC;
000131171201                           WHEN      TCODE = 'D';
000132171201                              EXSR      DELREC;
000133171201                           OTHER;
000134171201                              EXSR      ERROR;
000135171201                        ENDSL;
000136171201                        WHEN      NOT %FOUND(SALESSTAF2);
000137171201                           IF        TCODE = 'A';
000138171201                              EXSR      ADDREC;
000139171201                           ELSE;
000140171201                              EXSR      ERROR;
000141171201                           ENDIF;
000142171201                        WHEN      %ERROR;
000143171201                              EXSR      ERROR;
000144171201                        ENDSL;
000145171201                        EXCEPT    DETAIL;
000146171201                        READ      SALESTRANS;
000147171201                   ENDDO;
000148171201                   *INLR = *ON;
000149171201                   RETURN;
000150171201         BEGSR  ADDREC;
000151171201                   SALESSTAF2DS = SALESTRANSDS;
000152171201                   Phone   = %Dec(TPhone:10:0);
000153171201                   WRITE     SALESTFR;
000154171201         ENDSR;
000155171201         BEGSR  CHGREC;
000156171201                   SALESSTAF2DS = SALESTRANSDS;
000157171201                   Phone   = %Dec(TPhone:10:0);
000158171201                   UPDATE    SALESTFR;
000159171201         ENDSR;
000160171201         BEGSR  DELREC;
000161171201                   DELETE    SALESTFR;
000162171201         ENDSR;
000163171201         BEGSR  ERROR;
000164171201                   TFNAME = 'UPDATE/DELETE/CHANGE';
000165171201                   TLNAME = 'E R R O R';
000166171201         ENDSR;
000167171201      /END-FREE
000168171201     OQPRINT    E            HEADINGS       2 02
000169171201     O                                            8 'PAGE'
000170171201     O                       PAGE                13
000171171201     O                                           50 'SALESSTAFF UPDATE'
000172171201     O                                           64 'DATE'
000173171201     O                       UDATE         Y     73
000174171201     O          E            HEADINGS       1
000175171201     O                                            4 'CODE'
000176171201     O                                           10 'DEPT'
000177171201     O                                           14 'ID'
000178171201     O                                           28 'FIRST NAME'
000179171201     O                                           49 'LAST NAME'
000180171201     O                                           66 'CITY'
000181171201     O                                           91 'ADDRESS'
000182171201     O                                          113 'PHONE'
000183171201     O                                          125 'POSTAL'
000184171201     O          E            HEADINGS       2
000185171201     O                                          124 'CODE'
000186171201     O          E            DETAIL         1
000187171201     O                       TCODE                2
000188171201     O                       TDEPT                9
000189171201     O                       TSALESID            15
000190171201     O                       TFNAME              38
000191171201     O                       TLNAME              60
000192171201     O                       TCITY               82
000193171201     O                       TADDRESS           102
000194171201     O                       TPHONE             116
000195171201     O                       TPCODE             125
000196171201

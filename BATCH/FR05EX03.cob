      *================================================================*00001000
       IDENTIFICATION                            DIVISION.              00002000
      *================================================================*00002100
                                                                        00002200
       PROGRAM-ID.  FR05EX03.                                           00002304
                                                                        00002400
      *================================================================*00002500
      *                         F O U R S Y S                          *00002600
      *================================================================*00002700
      *    AUTOR    : DOUGLAS PEREIRA DA COSTA                         *00002800
      *    EMPRESA  : FOURSYS                                          *00002900
      *    INSTRUTOR: IVAN PETRUCCI                                    *00003000
      *    DATA     : 26/05/2022                                       *00004000
      *----------------------------------------------------------------*00004100
      *    OBJETIVO : ESTE PROGRAMA TEM A FINALIDADE DE RECEBER DADOS  *00004215
      *               DOS ARQUIVOS DE ENTRADA CLI2505 E MOV2505, FAZER *00004315
      *               A RELACAO (BALANCO) ENTRE AS CHAVES E GRAVAR NO  *00004415
      *               ARQUIVO DE SAIDA MOV2505A, MOV2505C.             *00004515
      *----------------------------------------------------------------*00004600
      *    ARQUIVOS :                                                  *00004722
      *    DDNAME          I/O                                         *00004822
      *    CLI2505          I                                          *00004922
      *    MOV2505          I                                          *00005022
      *    MOV2505A         O                                          *00005122
      *    MOV2505C         O                                          *00005222
      *----------------------------------------------------------------*00005322
      *    BOOKS    :    B#GRALOG                                      *00005422
      *----------------------------------------------------------------*00005522
      *    MODULOS  :    GRAVALOG - TRATAMENTO DE ERROS                *00005622
      *================================================================*00005700
                                                                        00005800
      *================================================================*00005900
       ENVIRONMENT                                DIVISION.             00006000
      *================================================================*00006100
                                                                        00006200
      *----------------------------------------------------------------*00006300
       CONFIGURATION                              SECTION.              00006400
      *----------------------------------------------------------------*00006500
                                                                        00006600
       SPECIAL-NAMES.                                                   00006700
           DECIMAL-POINT IS COMMA.                                      00006800
                                                                        00006900
      *----------------------------------------------------------------*00007000
      *----------------------------------------------------------------*00007100
       INPUT-OUTPUT                               SECTION.              00007200
      *----------------------------------------------------------------*00007300
                                                                        00007400
       FILE-CONTROL.                                                    00007500
             SELECT CLI2505   ASSIGN     TO JCLCLI                      00007602
                    FILE STATUS          IS WRK-FS-CLI2505.             00007701
                                                                        00007801
             SELECT MOV2505   ASSIGN     TO JCLMOV                      00007902
                    FILE STATUS          IS WRK-FS-MOV2505.             00008001
                                                                        00008101
             SELECT MOV2505A ASSIGN      TO JCLMOVA                     00008217
                    FILE STATUS          IS WRK-FS-MOV2505A.            00008301
                                                                        00008401
             SELECT MOV2505C ASSIGN      TO JCLMOVC                     00008517
                    FILE STATUS          IS WRK-FS-MOV2505C.            00008601
                                                                        00008701
      *================================================================*00008800
       DATA                                      DIVISION.              00008900
      *================================================================*00009000
                                                                        00009100
      *----------------------------------------------------------------*00009200
       FILE                                      SECTION.               00009300
      *----------------------------------------------------------------*00009400
                                                                        00009500
      *----------------------------------------------------------------*00009600
      *  INPUT - DADOS DO ARQUIVO DE ENTRADA (CLI2505) - LRECL = 046.  *00009703
      *----------------------------------------------------------------*00009800
                                                                        00009900
       FD CLI2505                                                       00010000
           RECORDING MODE IS F                                          00010100
           BLOCK CONTAINS 0 RECORDS.                                    00010200
                                                                        00010303
       01 FD-CLI2505.                                                   00010401
          05 FD-CLI2505-CHAVE.                                          00010501
             10 FD-CLI2505-AGENCIA        PIC 9(004).                   00010603
             10 FD-CLI2505-CONTA          PIC 9(004).                   00010703
          05 FD-CLI2505-NOME              PIC X(030).                   00010801
          05 FD-CLI2505-SALDO             PIC 9(008).                   00010903
                                                                        00011000
      *----------------------------------------------------------------*00011100
      *  INPUT - DADOS DO ARQUIVO DE ENTRADA (MOV2505) - LRECL = 047.  *00011203
      *----------------------------------------------------------------*00011300
                                                                        00011400
       FD MOV2505                                                       00011500
           RECORDING MODE IS F                                          00011600
           LABEL RECORD IS STANDARD                                     00011700
           BLOCK CONTAINS 0 RECORDS.                                    00011800
                                                                        00011900
       01 FD-MOV2505.                                                   00012017
          05 FD-MOV2505-CHAVE.                                          00012101
             10 FD-MOV2505-AGENCIA        PIC X(004).                   00012215
             10 FD-MOV2505-CONTA          PIC X(004).                   00012315
          05 FD-MOV2505-MOVIMENTO         PIC X(030).                   00012401
          05 FD-MOV2505-VALOR             PIC 9(008).                   00012503
          05 FD-MOV2505-TIPO              PIC X(001).                   00012601
                                                                        00012700
      *----------------------------------------------------------------*00012800
      *   INPUT - DADOS DO ARQUIVO DE SAIDA (MOV2505A) - LRECL = 046.  *00012903
      *----------------------------------------------------------------*00013000
                                                                        00013100
       FD MOV2505A                                                      00013201
           RECORDING MODE IS F                                          00013300
           LABEL RECORD IS STANDARD                                     00013400
           BLOCK CONTAINS 0 RECORDS.                                    00013500
                                                                        00013600
       01 FD-MOV2505A                     PIC X(046).                   00013708
                                                                        00014001
      *----------------------------------------------------------------*00014101
      *   INPUT - DADOS DO ARQUIVO DE SAIDA (MOV2505C) - LRECL = 046.  *00014203
      *----------------------------------------------------------------*00014401
                                                                        00014501
       FD MOV2505C                                                      00014601
           RECORDING MODE IS F                                          00014701
           LABEL RECORD IS STANDARD                                     00014801
           BLOCK CONTAINS 0 RECORDS.                                    00014901
                                                                        00015001
       01 FD-MOV2505C                     PIC X(046).                   00015108
                                                                        00015601
      *----------------------------------------------------------------*00015700
       WORKING-STORAGE                            SECTION.              00015800
      *----------------------------------------------------------------*00015900
      *----------------------------------------------------------------*00016000
       01 FILLER                         PIC X(050)       VALUE         00016100
                   '*** INICIO DA WORKING FR05EX03 ***'.                00016201
      *----------------------------------------------------------------*00016300
                                                                        00016400
       77 WRK-GRAVALOG                   PIC X(008) VALUE 'GRAVALOG'.   00016500
                                                                        00016600
      *----------------------------------------------------------------*00016700
       01 FILLER                         PIC X(050)       VALUE         00016800
                '*** AREA DE VARIAVEIS DE FILE-STATUS ***'.             00016900
      *----------------------------------------------------------------*00017000
                                                                        00017100
       77 WRK-FS-CLI2505                 PIC 9(002) VALUE ZEROS.        00017208
       77 WRK-FS-MOV2505                 PIC 9(002) VALUE ZEROS.        00017308
       77 WRK-FS-MOV2505A                PIC 9(002) VALUE ZEROS.        00017408
       77 WRK-FS-MOV2505C                PIC 9(002) VALUE ZEROS.        00017608
                                                                        00017701
      *----------------------------------------------------------------*00017800
      *----------------------------------------------------------------*00017902
       01 FILLER                         PIC X(050)       VALUE         00018002
                     '*** AREA DA ACUMULADORES ***'.                    00018102
      *----------------------------------------------------------------*00018202
                                                                        00018302
       77 ACUM-LIDOS-CLI2505             PIC 9(004) VALUE ZEROS.        00018408
       77 ACUM-LIDOS-MOV2505             PIC 9(004) VALUE ZEROS.        00018508
       77 ACUM-GRAV-MOV2505A             PIC 9(004) VALUE ZEROS.        00018608
       77 ACUM-GRAV-MOV2505C             PIC 9(004) VALUE ZEROS.        00018708
       77 TOTAL-GRAVADOS                 PIC 9(004) VALUE ZEROS.        00018808
                                                                        00018908
      *----------------------------------------------------------------*00019008
       01 FILLER                         PIC X(050)       VALUE         00019108
                '*** AREA DE VARIAVEIS DE AUXILIARES ***'.              00019208
      *----------------------------------------------------------------*00019308
                                                                        00019408
       77 WRK-AUX-TOTAL                  PIC 9(008) VALUE ZEROS.        00019508
                                                                        00019908
      *----------------------------------------------------------------*00020008
      *----------------------------------------------------------------*00020100
       01 FILLER                         PIC X(050)       VALUE         00020200
                    '*** AREA DA BOOK GRAVALOG ***'.                    00020302
      *----------------------------------------------------------------*00020400
                                                                        00020500
                           COPY 'B#GRALOG'.                             00020600
                                                                        00020702
      *================================================================*00020800
       PROCEDURE                                 DIVISION.              00020900
      *================================================================*00021000
                                                                        00021100
      ******************************************************************00021200
      *              P R O G R A M A  P R I N C I P A L                *00021300
      ******************************************************************00021400
                                                                        00021500
      *----------------------------------------------------------------*00021600
       0000-PRINCIPAL                            SECTION.               00021700
      *----------------------------------------------------------------*00021800
                                                                        00021900
            PERFORM 1000-INICIAR                                        00022000
                                                                        00022100
            PERFORM 2000-VERIFICAR-VAZIO                                00022200
                                                                        00022300
            PERFORM 3000-PROCESSAR                                      00022400
                    UNTIL WRK-FS-CLI2505 EQUAL 10                       00022502
                    AND   WRK-FS-MOV2505 EQUAL 10                       00022602
            PERFORM 4000-FINALIZAR                                      00022700
                                                                        00022800
            STOP RUN.                                                   00022900
                                                                        00023000
      *----------------------------------------------------------------*00023100
       0000-99-FIM.                           EXIT.                     00023200
      *----------------------------------------------------------------*00023300
                                                                        00023400
      *----------------------------------------------------------------*00023500
      ******************************************************************00023600
      *                       I N I C I A R                            *00023700
      ******************************************************************00023800
                                                                        00023900
      *----------------------------------------------------------------*00024000
       1000-INICIAR                           SECTION.                  00024100
      *----------------------------------------------------------------*00024200
                                                                        00024300
           OPEN INPUT  CLI2505                                          00024402
                INPUT  MOV2505                                          00024508
                OUTPUT MOV2505A                                         00024602
                OUTPUT MOV2505C.                                        00024708
                                                                        00024802
           PERFORM 1100-TESTAR-STATUS.                                  00024900
                                                                        00025000
      *----------------------------------------------------------------*00025100
       1000-99-FIM.                            EXIT.                    00025200
      *----------------------------------------------------------------*00025300
                                                                        00025400
                                                                        00025500
      ******************************************************************00025600
      *                   T E S T A R  S T A T U S                     *00025700
      ******************************************************************00025800
                                                                        00025900
      *----------------------------------------------------------------*00026000
       1100-TESTAR-STATUS                    SECTION.                   00026100
      *----------------------------------------------------------------*00026200
                                                                        00026300
            PERFORM 1110-TESTAR-WRK-FS-CLI2505.                         00026402
                                                                        00026500
            PERFORM 1120-TESTAR-WRK-FS-MOV2505.                         00026602
                                                                        00026700
            PERFORM 1130-TESTAR-WRK-FS-MOV2505A.                        00026802
                                                                        00026900
            PERFORM 1140-TESTAR-WRK-FS-MOV2505C.                        00027002
                                                                        00027102
      *----------------------------------------------------------------*00027200
       1100-99-FIM.                            EXIT.                    00027300
      *----------------------------------------------------------------*00027400
                                                                        00028000
      ******************************************************************00029000
      *           TESTAR ARQUIVO DE ENTRADA - CLI2505                  *00030002
      ******************************************************************00040000
                                                                        00041000
      *----------------------------------------------------------------*00042000
       1110-TESTAR-WRK-FS-CLI2505              SECTION.                 00043002
      *----------------------------------------------------------------*00044000
                                                                        00045000
           IF WRK-FS-CLI2505 NOT EQUAL ZEROS                            00045102
              MOVE 'FR05EX03'                    TO WRK-PROGRAMA        00045202
              MOVE 'ERRO NA ABERTURA DO CLI2505' TO WRK-MENSAGEM        00045302
              MOVE '1000'                        TO WRK-SECAO           00045400
              MOVE WRK-FS-CLI2505                TO WRK-STATUS          00045502
              PERFORM 9000-TRATAR-ERRO                                  00045600
           END-IF.                                                      00045700
                                                                        00045800
      *----------------------------------------------------------------*00045900
       1110-99-FIM.                            EXIT.                    00046000
      *----------------------------------------------------------------*00047000
                                                                        00047100
      ******************************************************************00047200
      *           TESTAR ARQUIVO DE ENTRADO - MOV2505                  *00047302
      ******************************************************************00047400
                                                                        00047500
      *----------------------------------------------------------------*00047600
       1120-TESTAR-WRK-FS-MOV2505              SECTION.                 00047702
      *----------------------------------------------------------------*00047800
                                                                        00047900
           IF WRK-FS-MOV2505 NOT EQUAL ZEROS                            00048002
              MOVE 'FR05EX03'                     TO WRK-PROGRAMA       00048102
              MOVE 'ERRO NO ABERTURA DO MOV2505'  TO WRK-MENSAGEM       00048202
              MOVE '1000'                         TO WRK-SECAO          00048300
              MOVE WRK-FS-MOV2505                 TO WRK-STATUS         00048402
              PERFORM 9000-TRATAR-ERRO                                  00048500
           END-IF.                                                      00048600
                                                                        00048700
      *----------------------------------------------------------------*00048800
       1120-99-FIM.                            EXIT.                    00048900
      *----------------------------------------------------------------*00049000
      ******************************************************************00049100
      *             TESTAR ARQUIVO DE SAIDA - MOV2505A                 *00049202
      ******************************************************************00049300
                                                                        00049400
      *----------------------------------------------------------------*00049500
       1130-TESTAR-WRK-FS-MOV2505A             SECTION.                 00049602
      *----------------------------------------------------------------*00049700
                                                                        00049800
           IF WRK-FS-MOV2505A NOT EQUAL ZEROS                           00049902
              MOVE 'FR05EX03'                     TO WRK-PROGRAMA       00050002
              MOVE 'ERRO NA ABERTURA DO MOV2505A' TO WRK-MENSAGEM       00050102
              MOVE '1000'                         TO WRK-SECAO          00050200
              MOVE WRK-FS-MOV2505A                TO WRK-STATUS         00050302
              PERFORM 9000-TRATAR-ERRO                                  00050400
           END-IF.                                                      00050500
                                                                        00050600
      *----------------------------------------------------------------*00050700
       1130-99-FIM.                            EXIT.                    00050802
      *----------------------------------------------------------------*00050900
                                                                        00051002
      ******************************************************************00051102
      *             TESTAR ARQUIVO DE SAIDA - MOV2505C                 *00051202
      ******************************************************************00051302
                                                                        00051402
      *----------------------------------------------------------------*00051502
       1140-TESTAR-WRK-FS-MOV2505C             SECTION.                 00051602
      *----------------------------------------------------------------*00051702
                                                                        00051802
           IF WRK-FS-MOV2505C NOT EQUAL ZEROS                           00051902
              MOVE 'FR05EX03'                     TO WRK-PROGRAMA       00052002
              MOVE 'ERRO NA ABERTURA DO MOV2505C' TO WRK-MENSAGEM       00052102
              MOVE '1000'                         TO WRK-SECAO          00052202
              MOVE WRK-FS-MOV2505C                TO WRK-STATUS         00052302
              PERFORM 9000-TRATAR-ERRO                                  00052402
           END-IF.                                                      00052502
                                                                        00052602
      *----------------------------------------------------------------*00052702
       1140-99-FIM.                            EXIT.                    00052802
      *----------------------------------------------------------------*00052902
                                                                        00053002
      ******************************************************************00053100
      *                  V E R I F I C A R  V A Z I O                  *00053200
      ******************************************************************00053300
      *----------------------------------------------------------------*00053500
       2000-VERIFICAR-VAZIO                    SECTION.                 00053602
      *----------------------------------------------------------------*00053700
                                                                        00053802
            PERFORM 2100-LER-CLI2505.                                   00053903
                                                                        00054002
            PERFORM 2200-LER-MOV2505.                                   00054103
                                                                        00054800
            IF WRK-FS-CLI2505 EQUAL 10                                  00054908
               DISPLAY '***********************************'            00055009
               DISPLAY '                                   '            00055109
               DISPLAY '    ARQUIVO CLI2505 ESTA VAZIO     '            00055209
               DISPLAY '     PROCESSAMENTO ENCERRADO.      '            00055309
               DISPLAY '                                   '            00055409
               DISPLAY '***********************************'            00055509
            END-IF.                                                     00055608
                                                                        00055708
            IF WRK-FS-MOV2505 EQUAL 10                                  00055808
               DISPLAY '***********************************'            00056109
               DISPLAY '                                   '            00056209
               DISPLAY '    ARQUIVO MOV2505 ESTA VAZIO     '            00056309
               DISPLAY '     PROCESSAMENTO ENCERRADO.      '            00056409
               DISPLAY '                                   '            00056509
               DISPLAY '***********************************'            00056609
            END-IF.                                                     00056709
                                                                        00056809
      *----------------------------------------------------------------*00056900
       2000-99-FIM.                            EXIT.                    00057003
      *----------------------------------------------------------------*00057100
                                                                        00057200
      *----------------------------------------------------------------*00057303
       2100-LER-CLI2505                        SECTION.                 00057403
      *----------------------------------------------------------------*00057503
                                                                        00057603
            READ CLI2505.                                               00057703
                                                                        00057803
      *----------------------------------------------------------------*00058103
       2100-99-FIM.                         EXIT.                       00058203
      *----------------------------------------------------------------*00058303
                                                                        00058403
      *----------------------------------------------------------------*00058503
       2200-LER-MOV2505                        SECTION.                 00058603
      *----------------------------------------------------------------*00058703
                                                                        00058803
            READ MOV2505.                                               00058912
            IF WRK-FS-MOV2505         EQUAL 10                          00059012
               MOVE HIGH-VALUES       TO FD-MOV2505-CHAVE               00059115
            END-IF.                                                     00059212
                                                                        00059312
      *----------------------------------------------------------------*00059403
       2200-99-FIM.                         EXIT.                       00059512
      *----------------------------------------------------------------*00059603
      ******************************************************************00059700
      *                     P R O C E S S A R                          *00059800
      ******************************************************************00059900
                                                                        00060000
      *----------------------------------------------------------------*00060100
       3000-PROCESSAR                        SECTION.                   00060200
      *----------------------------------------------------------------*00060300
                                                                        00060400
            EVALUATE TRUE                                               00060500
                                                                        00060600
              WHEN FD-CLI2505-CHAVE      EQUAL FD-MOV2505-CHAVE         00060712
               PERFORM 3200-ATUALIZAR-SALDO                             00060812
               PERFORM 2200-LER-MOV2505                                 00060912
               ADD 1                      TO ACUM-LIDOS-MOV2505         00061012
                                                                        00061100
              WHEN FD-CLI2505-CHAVE      LESS FD-MOV2505-CHAVE          00061212
               PERFORM 3100-VERIFICAR-SALDO                             00061312
               PERFORM 2100-LER-CLI2505                                 00061412
               ADD 1                      TO ACUM-LIDOS-CLI2505         00061812
                                                                        00062012
              WHEN OTHER                                                00062112
                   DISPLAY 'CHAVE INCORRETA' FD-MOV2505                 00062212
               PERFORM 2200-LER-MOV2505                                 00062312
                                                                        00062412
            END-EVALUATE.                                               00062512
      *----------------------------------------------------------------*00062600
       3000-99-FIM.                           EXIT.                     00062700
      *----------------------------------------------------------------*00062800
      *----------------------------------------------------------------*00062905
       3100-VERIFICAR-SALDO                   SECTION.                  00063005
      *----------------------------------------------------------------*00063105
                                                                        00063206
            IF FD-CLI2505-SALDO          GREATER THAN OR EQUAL 1000000  00063315
               WRITE FD-MOV2505A         FROM FD-CLI2505                00063818
               ADD 1                     TO   ACUM-GRAV-MOV2505A        00063915
                                              TOTAL-GRAVADOS            00064015
            ELSE                                                        00064106
               WRITE FD-MOV2505C         FROM FD-CLI2505                00064618
               ADD 1                     TO   ACUM-GRAV-MOV2505C        00064715
                                              TOTAL-GRAVADOS            00064815
            END-IF.                                                     00064907
                                                                        00065007
      *----------------------------------------------------------------*00065105
       3100-99-FIM.                           EXIT.                     00065205
      *----------------------------------------------------------------*00065305
                                                                        00066015
      *----------------------------------------------------------------*00066712
       3200-ATUALIZAR-SALDO                   SECTION.                  00066812
      *----------------------------------------------------------------*00066912
                                                                        00067012
            IF FD-MOV2505-TIPO          EQUAL 'C'                       00067112
               DISPLAY 'CREDITO' FD-MOV2505-TIPO                        00067215
                  ADD FD-MOV2505-VALOR    TO   FD-CLI2505-SALDO         00067315
            ELSE                                                        00067412
               IF FD-MOV2505-TIPO       EQUAL 'D'                       00067515
                  DISPLAY 'DEBITO' FD-MOV2505-TIPO                      00067615
                  SUBTRACT FD-MOV2505-VALOR FROM FD-CLI2505-SALDO       00067715
               ELSE                                                     00067815
                  DISPLAY 'ERRO!'                                       00067915
               END-IF                                                   00068015
            END-IF.                                                     00068112
                                                                        00068212
      *----------------------------------------------------------------*00068312
       3200-99-FIM.                           EXIT.                     00068412
      *----------------------------------------------------------------*00068512
      ******************************************************************00068600
      *                     F I N A L I Z A R                          *00068700
      ******************************************************************00068800
      *----------------------------------------------------------------*00068900
       4000-FINALIZAR                        SECTION.                   00069000
      *----------------------------------------------------------------*00069100
              PERFORM 4100-TOTAIS-LIDOS                                 00069215
              CLOSE CLI2505                                             00069315
                    MOV2505                                             00069415
                    MOV2505A                                            00069515
                    MOV2505C                                            00069615
              PERFORM 1100-TESTAR-STATUS.                               00069715
      *----------------------------------------------------------------*00069800
       4000-99-FIM.                           EXIT.                     00069900
      *----------------------------------------------------------------*00070000
                                                                        00070100
      ******************************************************************00070200
      *                    T O T A I S  L I D O S                      *00070300
      ******************************************************************00070400
      *----------------------------------------------------------------*00070500
       4100-TOTAIS-LIDOS                     SECTION.                   00070600
      *----------------------------------------------------------------*00070700
                                                                        00070800
            DISPLAY '*************************************************' 00070915
            DISPLAY '                                                 ' 00071015
            DISPLAY '  LIDOS CLI2505       :  ' ACUM-LIDOS-CLI2505      00071115
            DISPLAY '  LIDOS MOV2505       :  ' ACUM-LIDOS-MOV2505      00071215
            DISPLAY '                                                 ' 00071315
            DISPLAY '  GRAVADOS MOV2505A   :  ' ACUM-GRAV-MOV2505A      00071415
            DISPLAY '  GRAVADOS MOV2505C   :  ' ACUM-GRAV-MOV2505C      00071515
            DISPLAY '  TOTAIS GRAVADOS     :  ' TOTAL-GRAVADOS          00071615
            DISPLAY '                                                 ' 00071715
            DISPLAY '*************************************************'.00071815
                                                                        00071900
      *----------------------------------------------------------------*00072000
       4100-99-FIM.                           EXIT.                     00072100
      *----------------------------------------------------------------*00072200
      ******************************************************************00072300
      *                   T R A T A R  E R R O                         *00072400
      ******************************************************************00072500
                                                                        00072600
       9000-TRATAR-ERRO                     SECTION.                    00072700
      *----------------------------------------------------------------*00072800
                  CALL WRK-GRAVALOG       USING WRK-LOG                 00072916
                  GOBACK.                                               00073500
      *----------------------------------------------------------------*00073600
       9000-99-FIM.                           EXIT.                     00074000
      *----------------------------------------------------------------*00080000

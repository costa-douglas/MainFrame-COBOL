      *================================================================*00001000
       IDENTIFICATION                            DIVISION.              00002000
      *================================================================*00002100
                                                                        00002200
       PROGRAM-ID.  FR05EX01.                                           00002300
                                                                        00002400
      *================================================================*00002500
      *                         F O U R S Y S                          *00002600
      *================================================================*00002700
      *    AUTOR    : DOUGLAS PEREIRA DA COSTA                         *00002800
      *    EMPRESA  : FOURSYS                                          *00002900
      *    INSTRUTOR: IVAN PETRUCCI                                    *00004101
      *    DATA     : 05/05/2022                                       *00004200
      *----------------------------------------------------------------*00004300
      *    OBJETIVO : ESTE PROGRMA TEM A FINALIDADE LER TODOS OS       *00005000
      *               REGISTROS DO ARQUIVO SEQUENCIAL ARQPECAS E GERAR *00005100
      *               UM ARQUIVO SEQUENCIAL DE SAIDA PECACOMP COM TODOS*00005200
      *               AS PECAS QUE ESTIVEREM ABAIXO DO MINIMO DE       *00005300
      *               ESTOQUE (20) E A RESPECTIVA QUANTIDADE A SER     *00005400
      *               COMPRADA.                                         00005500
      *----------------------------------------------------------------*00005601
      *    BOOKS    :                                                  *00005701
      *               B#ARQE - BOOK DE ENTRADA.                        *00005801
      *               B#ARQS - BOOK DE SAIDA.                          *00005901
      *================================================================*00006000
                                                                        00006100
      *================================================================*00006200
       ENVIRONMENT                                DIVISION.             00006300
      *================================================================*00006400
                                                                        00006500
      *----------------------------------------------------------------*00006600
       CONFIGURATION                              SECTION.              00006700
      *----------------------------------------------------------------*00006800
                                                                        00006900
       SPECIAL-NAMES.                                                   00007000
           DECIMAL-POINT IS COMMA.                                      00007100
                                                                        00007200
      *----------------------------------------------------------------*00007300
      *----------------------------------------------------------------*00007400
       INPUT-OUTPUT                               SECTION.              00007500
      *----------------------------------------------------------------*00007600
                                                                        00007700
       FILE-CONTROL.                                                    00007800
             SELECT ARQPECAS  ASSIGN     TO JCLPECAS                    00007901
                    FILE STATUS     IS WRK-FS-PECAS.                    00008001
                                                                        00008100
             SELECT PECACOMP  ASSIGN     TO JCLCOMP                     00008202
                    FILE STATUS     IS WRK-FS-PECACOMP.                 00008301
      *================================================================*00008400
       DATA                                      DIVISION.              00008500
      *================================================================*00008600
                                                                        00008700
      *----------------------------------------------------------------*00008800
       FILE                                      SECTION.               00008900
      *----------------------------------------------------------------*00009000
      *----------------------------------------------------------------*00009105
      *    IMPUT - DADOS DO ARQUIVO DE ENTRADA (ARQPECAS)              *00009205
      *                           - LRECL = 050                        *00009305
      *----------------------------------------------------------------*00009405
                                                                        00009505
       FD ARQPECAS                                                      00009601
           RECORDING MODE IS F                                          00009700
           BLOCK CONTAINS 0 RECORDS.                                    00009800
       01 FD-PECAS          PIC X(050).                                 00009901
                                                                        00010001
      *----------------------------------------------------------------*00010105
      *    OUTPUT - DADOS DO ARQUIVO DE SAIDA  (PECACOMP)              *00010205
      *                           - LRECL = 010                        *00010305
      *----------------------------------------------------------------*00010405
                                                                        00010705
       FD PECACOMP                                                      00010801
           RECORDING MODE IS F                                          00010901
           BLOCK CONTAINS 0 RECORDS.                                    00011001
       01 FD-PECACOMP       PIC X(010).                                 00011102
                                                                        00011201
      *----------------------------------------------------------------*00011300
       WORKING-STORAGE                            SECTION.              00011400
      *----------------------------------------------------------------*00011500
                                                                        00011605
      *----------------------------------------------------------------*00011705
       01 FILLER                  PIC X(050)     VALUE                  00011807
             '*** AREA DE VARIAVEL DE FILE STATUS ***'.                 00011909
      *----------------------------------------------------------------*00012005
                                                                        00012105
       01 WRK-FS-PECAS                   PIC X(002) VALUE SPACES.       00012208
       01 WRK-FS-PECACOMP                PIC X(002) VALUE SPACES.       00012305
                                                                        00012405
      *----------------------------------------------------------------*00012505
       01 FILLER                  PIC X(050)     VALUE                  00012607
                     '*** AREA DE ACUMULADORES ***'.                    00012709
      *----------------------------------------------------------------*00012805
                                                                        00012900
       01 WRK-GRAVADOS                   PIC 9(003) VALUE ZEROS.        00013006
       01 WRK-LIDOS                      PIC 9(003) VALUE ZEROS.        00013105
                                                                        00013205
      *----------------------------------------------------------------*00013305
       01 FILLER                  PIC X(050)     VALUE                  00013407
                     '*** AREA DE AUXILIARES ***'.                      00013509
      *----------------------------------------------------------------*00013605
                                                                        00013705
       01 WRK-MSG                        PIC X(030) VALUE SPACES.       00013805
                                                                        00013905
      ******************************************************************00014001
      *           B O O K  A R Q U I V O  D E  E N T R A D A           *00014101
      ******************************************************************00014201
                                                                        00014300
       COPY 'B#ARQE'.                                                   00014401
                                                                        00014501
      ******************************************************************00014601
      *             B O O K  A R Q U I V O  D E  S A I D A             *00014701
      ******************************************************************00014801
                                                                        00014901
       COPY 'B#ARQS'.                                                   00015001
                                                                        00015101
      *================================================================*00015200
       PROCEDURE                                 DIVISION.              00015302
      *================================================================*00015400
                                                                        00015500
      ******************************************************************00015600
      *              P R O G R A M A  P R I N C I P A L                *00015700
      ******************************************************************00015800
                                                                        00015900
      *----------------------------------------------------------------*00016000
       0000-PRINCIPAL                            SECTION.               00016100
      *----------------------------------------------------------------*00016200
                                                                        00016300
            PERFORM 1000-INICIAR                                        00016402
                                                                        00016502
            PERFORM 2000-VERIFICAR-VAZIO                                00016602
                                                                        00016702
            PERFORM 3000-PROCESSAR                                      00016802
                    UNTIL WRK-FS-PECAS EQUAL '10'                       00016902
                                                                        00017002
            PERFORM 4000-FINALIZAR.                                     00017102
                                                                        00017200
            STOP RUN.                                                   00017302
                                                                        00017402
      *----------------------------------------------------------------*00017500
       0000-99-FIM.                           EXIT.                     00017600
      *----------------------------------------------------------------*00017700
                                                                        00017800
      *----------------------------------------------------------------*00018000
      ******************************************************************00018100
      *                       I N I C I A R                            *00018200
      ******************************************************************00018300
                                                                        00018400
      *----------------------------------------------------------------*00018500
       1000-INICIAR                           SECTION.                  00018600
      *----------------------------------------------------------------*00018700
                                                                        00018800
           OPEN INPUT ARQPECAS                                          00018902
                OUTPUT PECACOMP                                         00019004
           PERFORM 1100-TESTAR-STATUS.                                  00020704
                                                                        00020804
      *----------------------------------------------------------------*00020900
       1000-99-FIM.                            EXIT.                    00021000
      *----------------------------------------------------------------*00021100
                                                                        00022000
                                                                        00026000
      ******************************************************************00027000
      *                   T E S T A R  S T A T U S                     *00028002
      ******************************************************************00029000
                                                                        00030000
      *----------------------------------------------------------------*00040000
       1100-TESTAR-STATUS                    SECTION.                   00041004
      *----------------------------------------------------------------*00042000
                                                                        00042104
            PERFORM 1110-TESTAR-WRK-FS-PECAS                            00042208
                                                                        00042304
            PERFORM 1120-TESTAR-WRK-FS-PECACOMP.                        00042404
                                                                        00042504
      *----------------------------------------------------------------*00043000
       1100-99-FIM.                            EXIT.                    00044004
      *----------------------------------------------------------------*00045000
                                                                        00045104
      ******************************************************************00045204
      *           TESTAR ARQUIVO DE ENTRADA - WRK-FS-PECAS             *00045308
      ******************************************************************00045404
                                                                        00045504
      *----------------------------------------------------------------*00045604
       1110-TESTAR-WRK-FS-PECAS           SECTION.                      00045708
      *----------------------------------------------------------------*00045804
                                                                        00045904
           IF WRK-FS-PECAS NOT EQUAL ZEROS                              00046004
              MOVE 'ERRO NO ARQUIVO ARQPECAS' TO WRK-MSG                00046108
              PERFORM 9000-TRATAR-ERRO                                  00046211
           END-IF.                                                      00046404
                                                                        00047104
      *----------------------------------------------------------------*00047204
       1110-99-FIM.                            EXIT.                    00047304
      *----------------------------------------------------------------*00047404
                                                                        00047604
      ******************************************************************00047704
      *           TESTAR ARQUIVO DE SAIDA - WRK-FS-PECACOMP            *00047804
      ******************************************************************00047904
                                                                        00048004
      *----------------------------------------------------------------*00048104
       1120-TESTAR-WRK-FS-PECACOMP             SECTION.                 00048204
      *----------------------------------------------------------------*00048304
                                                                        00048404
           IF WRK-FS-PECACOMP NOT EQUAL ZEROS                           00048504
              MOVE 'ERRO NA ABERTURA DO PECACOMP' TO WRK-MSG            00048604
              PERFORM 9000-TRATAR-ERRO                                  00048711
           END-IF.                                                      00049504
                                                                        00049604
      *----------------------------------------------------------------*00049704
       1120-99-FIM.                            EXIT.                    00049804
      *----------------------------------------------------------------*00049904
      ******************************************************************00050004
      *                  V E R I F I C A R  V A Z I O                  *00050104
      ******************************************************************00050204
                                                                        00050304
      *----------------------------------------------------------------*00050404
       2000-VERIFICAR-VAZIO                 SECTION.                    00050504
      *----------------------------------------------------------------*00050604
            READ ARQPECAS              INTO WRK-ARQPECAS                00050812
                                                                        00050912
               IF WRK-FS-PECAS     EQUAL '10'                           00051004
                  DISPLAY '********************************'            00051104
                  DISPLAY '                                '            00051204
                  DISPLAY '  ARQUIVO ARQPECAS ESTA VAZIO   '            00051304
                  DISPLAY '    PROCESSAMENTO ENCERRADO     '            00051404
                  DISPLAY '                                '            00051504
                  DISPLAY '********************************'            00051604
               END-IF.                                                  00051704
                                                                        00051804
      *----------------------------------------------------------------*00051904
       2000-99-FIM.                         EXIT.                       00052004
      *----------------------------------------------------------------*00052104
                                                                        00052200
      ******************************************************************00052300
      *                     P R O C E S S A R                          *00052404
      ******************************************************************00052500
                                                                        00052600
      *----------------------------------------------------------------*00052700
       3000-PROCESSAR                        SECTION.                   00052804
      *----------------------------------------------------------------*00052900
                                                                        00053006
            IF WRK-FS-PECAS            EQUAL '10'                       00053208
               GO                         TO 3000-99-FIM                00053306
            END-IF                                                      00053406
                                                                        00053506
            PERFORM 1100-TESTAR-STATUS                                  00053606
            ADD 1                         TO WRK-LIDOS                  00053706
                                                                        00053806
            IF WRK-QUANT-PECA          LESS THAN 20                     00053906
               COMPUTE WRK-QUANT-COMPRA = 20 - WRK-QUANT-PECA           00054006
               MOVE WRK-COD-PECA       TO WRK-COD-PECA-S                00054106
               MOVE WRK-FORN-PECA      TO WRK-FORN-PECA-S               00054210
               WRITE FD-PECACOMP       FROM WRK-PECACOMP                00054306
               ADD 1                   TO WRK-GRAVADOS                  00054406
            END-IF                                                      00054512
                                                                        00054606
            READ ARQPECAS              INTO WRK-ARQPECAS.               00054712
      *----------------------------------------------------------------*00054800
       3000-99-FIM.                           EXIT.                     00054900
      *----------------------------------------------------------------*00055000
      *----------------------------------------------------------------*00055100
      ******************************************************************00055204
      *                     F I N A L I Z A R                          *00055306
      ******************************************************************00055404
      *----------------------------------------------------------------*00055500
       4000-FINALIZAR                        SECTION.                   00055606
      *----------------------------------------------------------------*00055700
            IF WRK-LIDOS      GREATER ZEROS                             00055806
               PERFORM 4100-TOTAIS-LIDOS                                00055906
            END-IF                                                      00056006
                                                                        00056106
            CLOSE ARQPECAS                                              00056206
                  PECACOMP                                              00056306
            IF WRK-FS-PECAS           NOT EQUAL ZEROS                   00056408
               MOVE 'ERRO NO FECHAMENTO ARQPECAS' TO WRK-MSG            00056506
               PERFORM 9000-TRATAR-ERRO                                 00056606
               GO                                 TO 4000-99-FIM        00056706
            END-IF                                                      00056806
                                                                        00056906
            IF WRK-FS-PECACOMP        NOT EQUAL ZEROS                   00057006
               MOVE 'ERRO NO FECHAMENTO PECACOMP' TO WRK-MSG            00057106
               PERFORM 9000-TRATAR-ERRO                                 00057206
            END-IF.                                                     00057306
      *----------------------------------------------------------------*00057400
       4000-99-FIM.                           EXIT.                     00057500
      *----------------------------------------------------------------*00057600
                                                                        00057704
      ******************************************************************00057806
      *                    T O T A I S  L I D O S                      *00057906
      ******************************************************************00058006
      *----------------------------------------------------------------*00058106
       4100-TOTAIS-LIDOS                     SECTION.                   00058206
      *----------------------------------------------------------------*00058306
                                                                        00058406
                  DISPLAY '********************************'            00058506
                  DISPLAY '                                '            00058606
                  DISPLAY '  LIDOS   :  ' WRK-LIDOS                     00058706
                  DISPLAY '  GRAVADOS:  ' WRK-GRAVADOS                  00058806
                  DISPLAY '                                '            00058906
                  DISPLAY '********************************'.           00059007
                                                                        00059106
      *----------------------------------------------------------------*00059206
       4100-99-FIM.                           EXIT.                     00059306
      *----------------------------------------------------------------*00059406
      ******************************************************************00059504
      *                   T R A T A R  E R R O                         *00059611
      ******************************************************************00059704
                                                                        00059804
       9000-TRATAR-ERRO                     SECTION.                    00059911
      *----------------------------------------------------------------*00060000
                  CALL WRK-GRALOG          USING WRK-LOG.               00060113
                  GOBACK.                                               00060806
      *----------------------------------------------------------------*00060900
       9000-99-FIM.                           EXIT.                     00061000
      *----------------------------------------------------------------*00070000

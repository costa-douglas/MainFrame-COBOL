      *================================================================*00001000
       IDENTIFICATION                            DIVISION.              00002000
      *================================================================*00002100
                                                                        00002200
       PROGRAM-ID.  FR05CB36.                                           00002300
                                                                        00002400
      *================================================================*00002500
      *                         F O U R S Y S                          *00002600
      *================================================================*00002700
      *    AUTOR    : DOUGLAS PEREIRA DA COSTA                         *00002800
      *    EMPRESA  : FOURSYS                                          *00002900
      *    INSTRUTOR: IVAN PETRUCCI                                    *00003000
      *    DATA     : 10/05/2022                                       *00004002
      *----------------------------------------------------------------*00004100
      *    OBJETIVO : 1 - LER ARQUIVO CLIENTES AT? EOF                 *00004202
      *               2 - GRAVAR NO ARQUIVO RELAT TODOS OS REGISTROS   *00004302
      *               3 - SOMAR TODOS OS SALDOS E MOSTRAR NO RESUMO    *00004402
      *                   DA SYSOUT                                    *00004502
      *               4 - A CADA 05 REGISTROS PULAR 1 PAGINA           *00004602
      *               5 - MOSTRAR LIDOS E GRAVADOS NA SYSOUT           *00004702
      *----------------------------------------------------------------*00004800
      *    BOOKS    :                                                  *00004900
      *               B#CLIENT - BOOK DE ENTRADA                       *00005002
      *               B#RELAT  - BOOK DE SAIDA.                        *00005102
      *================================================================*00005200
                                                                        00005300
      *================================================================*00005400
       ENVIRONMENT                                DIVISION.             00005500
      *================================================================*00005600
                                                                        00005700
      *----------------------------------------------------------------*00005800
       CONFIGURATION                              SECTION.              00005900
      *----------------------------------------------------------------*00006000
                                                                        00006100
       SPECIAL-NAMES.                                                   00006200
           DECIMAL-POINT IS COMMA.                                      00006300
                                                                        00006400
      *----------------------------------------------------------------*00006500
      *----------------------------------------------------------------*00006600
       INPUT-OUTPUT                               SECTION.              00006700
      *----------------------------------------------------------------*00006800
                                                                        00006900
       FILE-CONTROL.                                                    00007000
             SELECT CLIENT  ASSIGN     TO JCLCLIEN                      00007123
                    FILE STATUS     IS WRK-FS-CLIENTES.                 00007204
                                                                        00007300
             SELECT RELAT   ASSIGN     TO JCLRELAT                      00007406
                    FILE STATUS     IS WRK-FS-RELATORIO.                00007504
      *================================================================*00007600
       DATA                                      DIVISION.              00007700
      *================================================================*00007800
                                                                        00007900
      *----------------------------------------------------------------*00008000
       FILE                                      SECTION.               00008100
      *----------------------------------------------------------------*00008200
      *----------------------------------------------------------------*00008300
      *    INPUT - DADOS DO ARQUIVO DE ENTRADA (CLIENTES)              *00008421
      *                           - LRECL = 037                        *00008503
      *----------------------------------------------------------------*00008600
                                                                        00008700
       FD CLIENT                                                        00008822
           RECORDING MODE IS F                                          00008900
           BLOCK CONTAINS 0 RECORDS.                                    00009000
       01 FD-CLIENTES       PIC X(037).                                 00009104
                                                                        00009200
      *----------------------------------------------------------------*00009300
      *    OUTPUT - DADOS DO ARQUIVO DE SAIDA  (RELAT)                 *00009403
      *                           - LRECL = 070                        *00009503
      *----------------------------------------------------------------*00009600
                                                                        00009700
       FD RELAT                                                         00009822
           RECORDING MODE IS F                                          00009900
           BLOCK CONTAINS 0 RECORDS.                                    00010000
       01 FD-RELAT               PIC X(070).                            00011028
                                                                        00011100
      *----------------------------------------------------------------*00011200
       WORKING-STORAGE                            SECTION.              00011300
      *----------------------------------------------------------------*00011400
                                                                        00011500
      *----------------------------------------------------------------*00011613
       01 FILLER                  PIC X(050) VALUE                      00011724
                     '*** AREA DE CABECALHO ***'.                       00011813
      *----------------------------------------------------------------*00011913
       01 WRK-CAB01.                                                    00012027
          05 FILLER               PIC X(040) VALUE                      00012124
             '---------RELATORIO DO CLIENTE-----------'.                00012228
          05 FILLER               PIC X(023) VALUE SPACES.              00012315
          05 FILLER               PIC X(005) VALUE 'PAG '.              00012427
          05 WRK-NUM-PAG          PIC 9(002) VALUE ZEROS.               00012514
                                                                        00012615
       01 WRK-CAB-CAMPOS.                                               00012715
          05 FILLER               PIC X(005) VALUE SPACES.              00012816
          05 FILLER               PIC X(007) VALUE 'AGENCIA'.           00012916
          05 FILLER               PIC X(002) VALUE SPACES.              00013016
          05 FILLER               PIC X(005) VALUE 'CONTA'.             00013116
          05 FILLER               PIC X(002) VALUE SPACES.              00013216
          05 FILLER               PIC X(015) VALUE 'NOME DO CLIENTE'.   00013326
          05 FILLER               PIC X(005) VALUE SPACES.              00013416
          05 FILLER               PIC X(005) VALUE 'SALDO'.             00013516
          05 FILLER               PIC X(024) VALUE SPACES.              00013616
      *----------------------------------------------------------------*00013700
       01 FILLER                  PIC X(050)     VALUE                  00013800
             '*** AREA DE VARIAVEL DE FILE STATUS ***'.                 00013900
      *----------------------------------------------------------------*00014000
                                                                        00014100
       01 WRK-FS-CLIENTES                PIC X(002) VALUE SPACES.       00014205
       01 WRK-FS-RELATORIO               PIC X(002) VALUE SPACES.       00014305
                                                                        00014400
      *----------------------------------------------------------------*00014500
       01 FILLER                  PIC X(050)     VALUE                  00014600
                     '*** AREA DE ACUMULADORES ***'.                    00014700
      *----------------------------------------------------------------*00014800
                                                                        00014900
       01 WRK-GRAVADOS                   PIC 9(003) VALUE ZEROS.        00015000
       01 WRK-LIDOS                      PIC 9(003) VALUE ZEROS.        00015100
                                                                        00015200
      *----------------------------------------------------------------*00015300
       01 FILLER                  PIC X(050)     VALUE                  00015400
                     '*** AREA DE AUXILIARES ***'.                      00015500
      *----------------------------------------------------------------*00015600
                                                                        00015700
       01 WRK-MSG                        PIC X(030) VALUE SPACES.       00015800
       01 WRK-PAGINA                     PIC 9(002) VALUE ZEROS.        00015917
       01 WRK-LINHA                      PIC 9(002) VALUE ZEROS.        00016017
                                                                        00016117
      ******************************************************************00016200
      *           B O O K  A R Q U I V O  D E  E N T R A D A           *00016300
      ******************************************************************00016400
                                                                        00016500
       COPY 'B#CLIENT'.                                                 00016605
                                                                        00016700
      ******************************************************************00016800
      *             B O O K  A R Q U I V O  D E  S A I D A             *00016900
      ******************************************************************00017000
                                                                        00017100
       COPY 'B#RELAT'.                                                  00017205
                                                                        00017300
      *================================================================*00017400
       PROCEDURE                                 DIVISION.              00017500
      *================================================================*00017600
                                                                        00017700
      ******************************************************************00017800
      *              P R O G R A M A  P R I N C I P A L                *00017900
      ******************************************************************00018000
                                                                        00018100
      *----------------------------------------------------------------*00018200
       0000-PRINCIPAL                            SECTION.               00018300
      *----------------------------------------------------------------*00018400
                                                                        00018500
            PERFORM 1000-INICIAR                                        00018600
                                                                        00018700
            PERFORM 2000-VERIFICAR-VAZIO                                00018800
                                                                        00018900
            PERFORM 3000-PROCESSAR                                      00019000
                    UNTIL WRK-FS-CLIENTES EQUAL '10'                    00019105
                                                                        00019200
            PERFORM 4000-FINALIZAR                                      00019327
                                                                        00019400
            STOP RUN.                                                   00019500
                                                                        00019600
      *----------------------------------------------------------------*00019700
       0000-99-FIM.                           EXIT.                     00019800
      *----------------------------------------------------------------*00019900
                                                                        00020000
      *----------------------------------------------------------------*00020100
      ******************************************************************00020200
      *                       I N I C I A R                            *00020300
      ******************************************************************00020400
                                                                        00020500
      *----------------------------------------------------------------*00020600
       1000-INICIAR                           SECTION.                  00020700
      *----------------------------------------------------------------*00020800
                                                                        00020900
           OPEN INPUT CLIENT                                            00021024
                OUTPUT RELAT                                            00021106
           PERFORM 1100-TESTAR-STATUS.                                  00021200
                                                                        00021300
      *----------------------------------------------------------------*00021400
       1000-99-FIM.                            EXIT.                    00021500
      *----------------------------------------------------------------*00021600
                                                                        00021700
                                                                        00021800
      ******************************************************************00021900
      *                   T E S T A R  S T A T U S                     *00022000
      ******************************************************************00022100
                                                                        00022200
      *----------------------------------------------------------------*00022300
       1100-TESTAR-STATUS                    SECTION.                   00022400
      *----------------------------------------------------------------*00022500
                                                                        00023000
            PERFORM 1110-TESTAR-WRK-FS-CLIENTES                         00024006
                                                                        00025000
            PERFORM 1120-TESTAR-WRK-FS-RELATORIO.                       00026006
                                                                        00027000
      *----------------------------------------------------------------*00028000
       1100-99-FIM.                            EXIT.                    00029000
      *----------------------------------------------------------------*00030000
                                                                        00040000
      ******************************************************************00041000
      *           TESTAR ARQUIVO DE ENTRADA - WRK-FS-CLIENTES          *00042006
      ******************************************************************00043000
                                                                        00044000
      *----------------------------------------------------------------*00045000
       1110-TESTAR-WRK-FS-CLIENTES        SECTION.                      00045106
      *----------------------------------------------------------------*00045200
                                                                        00045300
           IF WRK-FS-CLIENTES NOT EQUAL ZEROS                           00045406
              MOVE 'ERRO NO ARQUIVO CLIENTES' TO WRK-MSG                00045506
              PERFORM 9000-TRATAR-ERRO                                  00045600
           END-IF.                                                      00045700
                                                                        00045800
      *----------------------------------------------------------------*00045900
       1110-99-FIM.                            EXIT.                    00046000
      *----------------------------------------------------------------*00047000
                                                                        00047100
      ******************************************************************00047200
      *           TESTAR ARQUIVO DE SAIDA - WRK-FS-RELATORIO           *00047306
      ******************************************************************00047400
                                                                        00047500
      *----------------------------------------------------------------*00047600
       1120-TESTAR-WRK-FS-RELATORIO            SECTION.                 00047706
      *----------------------------------------------------------------*00047800
                                                                        00047900
           IF WRK-FS-RELATORIO NOT EQUAL ZEROS                          00048006
              MOVE 'ERRO NA ABERTURA DO RELAT' TO WRK-MSG               00048106
              PERFORM 9000-TRATAR-ERRO                                  00048200
           END-IF.                                                      00048300
                                                                        00048400
      *----------------------------------------------------------------*00048500
       1120-99-FIM.                            EXIT.                    00048600
      *----------------------------------------------------------------*00048700
      ******************************************************************00048800
      *                  V E R I F I C A R  V A Z I O                  *00048900
      ******************************************************************00049000
                                                                        00050000
      *----------------------------------------------------------------*00050100
       2000-VERIFICAR-VAZIO                 SECTION.                    00050200
      *----------------------------------------------------------------*00050300
            PERFORM 2100-LEITURA                                        00050418
                                                                        00050500
               IF WRK-FS-CLIENTES  EQUAL '10'                           00050606
                  DISPLAY '********************************'            00050700
                  DISPLAY '                                '            00050800
                  DISPLAY '  ARQUIVO CLIENTES ESTA VAZIO   '            00050906
                  DISPLAY '    PROCESSAMENTO ENCERRADO     '            00051000
                  DISPLAY '                                '            00051100
                  DISPLAY '********************************'            00051200
               END-IF.                                                  00051300
                                                                        00051400
      *----------------------------------------------------------------*00051500
       2000-99-FIM.                         EXIT.                       00051600
      *----------------------------------------------------------------*00051700
                                                                        00051800
      *----------------------------------------------------------------*00051918
       2100-LEITURA                         SECTION.                    00052018
      *----------------------------------------------------------------*00052118
            READ CLIENT              INTO WRK-CLIENTES                  00052224
                                                                        00052318
               IF WRK-FS-CLIENTES  EQUAL '10'                           00052418
                  GO               TO 2100-99-FIM                       00052518
               END-IF.                                                  00053218
                                                                        00053318
               PERFORM 1110-TESTAR-WRK-FS-CLIENTES                      00053418
               ADD 1               TO WRK-LIDOS.                        00053518
      *----------------------------------------------------------------*00053618
       2100-99-FIM.                         EXIT.                       00053718
      *----------------------------------------------------------------*00053818
      ******************************************************************00053900
      *                     P R O C E S S A R                          *00054000
      ******************************************************************00054100
                                                                        00054200
      *----------------------------------------------------------------*00054300
       3000-PROCESSAR                        SECTION.                   00054400
      *----------------------------------------------------------------*00054500
                                                                        00054620
               IF WRK-LINHAS          GREATER 5                         00054720
                  PERFORM 3100-GRAVAR-CABECALHO                         00054818
                  PERFORM 3200-GRAVAR-CAMPOS                            00054918
               END-IF.                                                  00055019
                                                                        00055120
               MOVE FD-AGENCIA        TO WRK-AGENCIA-S                  00055220
               MOVE FD-CONTA-CLIENTES TO WRK-CONTA-S                    00055320
               MOVE FD-NOME-CLIENTES  TO WRK-NOME-S                     00055420
               MOVE FD-SALDO-CLIENTES TO WRK-SALDO-S                    00055520
               PERFORM 3300-GRAVAS-DETALHES.                            00055627
                                                                        00055725
      *----------------------------------------------------------------*00055800
       3000-99-FIM.                           EXIT.                     00055900
      *----------------------------------------------------------------*00056000
      *----------------------------------------------------------------*00056118
       3100-GRAVAR-CABECALHO                 SECTION.                   00056218
      *----------------------------------------------------------------*00056318
               ADD 1               TO WRK-PAGINA                        00056418
               MOVE WRK-PAGINA     FROM WRK-NUM-PAG                     00056518
               WRITE FD-RELAT      FROM WRK-CAB01 AFTER PAGE            00056618
               PERFORM 1120-TESTAR-WRK-FS-RELATORIO                     00056718
               MOVE 1              FROM WRK-LINHAS.                     00056818
      *----------------------------------------------------------------*00056918
       3100-99-FIM.                           EXIT.                     00057018
      *----------------------------------------------------------------*00057118
                                                                        00057218
      *----------------------------------------------------------------*00057318
       3200-GRAVAR-CAMPOS                     SECTION.                  00057418
      *----------------------------------------------------------------*00057518
               WRITE FD-RELAT      FROM WRK-CAB-CAMPOS                  00057619
               PERFORM 1120-TESTAR-WRK-FS-RELATORIO                     00057718
               MOVE 1              FROM WRK-LINHAS.                     00057818
      *----------------------------------------------------------------*00057918
       3200-99-FIM.                           EXIT.                     00058018
      *----------------------------------------------------------------*00058118
      *----------------------------------------------------------------*00058220
       3300-GRAVAR-DETALHES                  SECTION.                   00058320
      *----------------------------------------------------------------*00058420
                                                                        00058520
               WRITE FD-RELAT         FROM WRK-RELAT                    00058620
               PERFORM 1120-TESTAR-WRK-FS-RELATORIO                     00058720
               ADD 1                  TO WRK-LINHAS                     00058820
                                         WRK-GRAVADOS.                  00058927
                                                                        00059020
      *----------------------------------------------------------------*00059620
       3300-99-FIM.                           EXIT.                     00059720
      *----------------------------------------------------------------*00059820
      ******************************************************************00059900
      *                     F I N A L I Z A R                          *00060000
      ******************************************************************00060100
      *----------------------------------------------------------------*00060200
       4000-FINALIZAR                        SECTION.                   00060300
      *----------------------------------------------------------------*00060400
            IF WRK-LIDOS      GREATER ZEROS                             00060500
               PERFORM 4100-TOTAIS-LIDOS                                00060600
            END-IF                                                      00060700
                                                                        00060800
            CLOSE CLIENT                                                00060924
                  RELAT                                                 00061012
            IF WRK-FS-CLIENTES        NOT EQUAL ZEROS                   00061112
               MOVE 'ERRO NO FECHAMENTO CLIENTES' TO WRK-MSG            00061212
               PERFORM 9000-TRATAR-ERRO                                 00061300
               GO                                 TO 4000-99-FIM        00061400
            END-IF                                                      00061500
                                                                        00061600
            IF WRK-FS-RELATORIO       NOT EQUAL ZEROS                   00061712
               MOVE 'ERRO NO FECHAMENTO RELAT' TO WRK-MSG               00061812
               PERFORM 9000-TRATAR-ERRO                                 00061900
            END-IF.                                                     00062000
      *----------------------------------------------------------------*00062100
       4000-99-FIM.                           EXIT.                     00062200
      *----------------------------------------------------------------*00062300
                                                                        00062400
      ******************************************************************00062500
      *                    T O T A I S  L I D O S                      *00062600
      ******************************************************************00062700
      *----------------------------------------------------------------*00062800
       4100-TOTAIS-LIDOS                     SECTION.                   00062900
      *----------------------------------------------------------------*00063000
                                                                        00063100
                  DISPLAY '********************************'            00063200
                  DISPLAY '                                '            00063300
                  DISPLAY '  LIDOS   :  ' WRK-LIDOS                     00063400
                  DISPLAY '  GRAVADOS:  ' WRK-GRAVADOS                  00063500
                  DISPLAY '                                '            00063600
                  DISPLAY '********************************'.           00063700
                                                                        00063800
      *----------------------------------------------------------------*00063900
       4100-99-FIM.                           EXIT.                     00064000
      *----------------------------------------------------------------*00064100
      ******************************************************************00064200
      *                   T R A T A R  E R R O                         *00064300
      ******************************************************************00064400
                                                                        00064500
       9000-TRATAR-ERRO                     SECTION.                    00064600
      *----------------------------------------------------------------*00064700
                                                                        00064800
                  DISPLAY '********************************'            00064900
                  DISPLAY '                                '            00065000
                  DISPLAY '  ERRO: ' WRK-MSG                            00065100
                  DISPLAY '                                '            00065200
                  DISPLAY '********************************'            00065300
                  GOBACK.                                               00065400
      *----------------------------------------------------------------*00065500
       9000-99-FIM.                           EXIT.                     00065600
      *----------------------------------------------------------------*00066000

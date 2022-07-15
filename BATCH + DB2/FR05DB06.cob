      *================================================================*00001000
       IDENTIFICATION                            DIVISION.              00002000
      *================================================================*00002100
                                                                        00002200
       PROGRAM-ID.  FR05DB06.                                           00002321
       AUTHOR.      DOUGLAS COSTA                                       00002400
                                                                        00002500
      *================================================================*00002600
      *                         F O U R S Y S                          *00002700
      *================================================================*00002800
      *    PROGRAMA...: FR05DB06                                       *00002921
      *    TIPO.......: SERVICO DE ACESSO A DADOS                      *00003000
      *----------------------------------------------------------------*00003100
      *    PROGAMADOR.: DOUGLAS COSTA                                  *00003200
      *    EMPRESA....: FOURSYS                                        *00003300
      *    ANALISTA...: IVAN SANCHES                                   *00003400
      *    DATA.......: 07/06/2022                                     *00003500
      *----------------------------------------------------------------*00003600
      *    OBJETIVO : ESTE PROGRAMA TEM A FINALIDADE DE RECEBER DADOS  *00003700
      *               DA TABELA FOUR001.FUNC2                          *00003801
      *----------------------------------------------------------------*00003900
      *    BASE DE DADOS:                                              *00004000
      *      TABELAS DB2                           INCLUDE/BOOK        *00004100
      *      FOUR001.FUNC2                          BOOKFUNC           *00004202
      *----------------------------------------------------------------*00004318
      *    MODULO   :                                                  *00004420
      *               GRAVALOG - TRATAMENTO DE ERROS                   *00004520
      *                                                                *00004620
      *----------------------------------------------------------------*00004718
      *    COPYBOOK :                                                  *00004820
      *               B#GRALOG - AREA DE TRATAMENTO DE ERROS           *00004920
      *                                                                *00005020
      ******************************************************************00005100
      *================================================================*00005200
                                                                        00005300
      *================================================================*00005400
       ENVIRONMENT DIVISION.                                            00005500
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
                                                                        00006600
      *================================================================*00006700
       DATA                                       DIVISION.             00006818
      *================================================================*00006900
      *----------------------------------------------------------------*00007000
       WORKING-STORAGE                            SECTION.              00007100
      *----------------------------------------------------------------*00007200
                                                                        00007300
      *----------------------------------------------------------------*00007400
       01  FILLER                      PIC  X(050)         VALUE        00007500
                 '*** INICIO DA WORKING FR05DB06 ***'.                  00007621
      *----------------------------------------------------------------*00007700
                                                                        00007800
      *----------------------------------------------------------------*00008000
       01  FILLER                       PIC X(050)           VALUE      00009000
                    '*** AREA DE AUXILIARES ***'.                       00010000
      *----------------------------------------------------------------*00011000
                                                                        00011100
       77 WRK-ID                 PIC 9(04).                             00011200
       77 WRK-SQLCODE            PIC -999.                              00011300
                                                                        00011711
      *----------------------------------------------------------------*00011820
       01  FILLER                       PIC X(050)           VALUE      00011920
                   '*** VARIAVEL DE NULIDADE ***'.                      00012020
      *----------------------------------------------------------------*00012120
                                                                        00012220
       77 WRK-EMAIL-NULL         PIC S9(4) COMP VALUE ZEROS.            00012320
       77 WRK-TELEFONE-NULL      PIC S9(4) COMP VALUE ZEROS.            00012420
                                                                        00012520
      *----------------------------------------------------------------*00012613
       01  FILLER                       PIC X(050)           VALUE      00012713
                       '*** AREA DE BOOK ***'.                          00012813
      *----------------------------------------------------------------*00012913
                                                                        00013013
           COPY 'B#GRALOG'.                                             00013115
                                                                        00013214
      *----------------------------------------------------------------*00013300
       01  FILLER                       PIC X(050)           VALUE      00013400
                        '*** AREA DB2 ***'.                             00013500
      *----------------------------------------------------------------*00013600
                                                                        00013700
           EXEC SQL                                                     00013800
             INCLUDE #BKFUNC2                                           00014005
           END-EXEC.                                                    00015000
           EXEC SQL                                                     00016000
               INCLUDE SQLCA                                            00017000
           END-EXEC.                                                    00018000
                                                                        00019000
      *----------------------------------------------------------------*00020000
       01  FILLER                      PIC  X(050)         VALUE        00021000
              '*** FR05DB06 - FIM DA AREA DE WORKING ***'.              00022021
      *----------------------------------------------------------------*00023000
                                                                        00024000
      *================================================================*00025000
        PROCEDURE                       DIVISION.                       00026000
      *================================================================*00026100
                                                                        00026200
      ******************************************************************00026300
      *                    P R I N C I P A L                           *00026400
      ******************************************************************00026500
                                                                        00026600
      *----------------------------------------------------------------*00026700
       0000-PRINCIPAL                            SECTION.               00026800
      *----------------------------------------------------------------*00026900
                                                                        00027000
           PERFORM 1000-INICIAR                                         00028000
                                                                        00029000
           PERFORM 2000-PROCESSAR                                       00030000
                                                                        00040000
           PERFORM 3000-FINALIZAR                                       00041000
                                                                        00041100
           STOP RUN.                                                    00041200
                                                                        00041300
      *----------------------------------------------------------------*00041400
       0000-99-FIM.                           EXIT.                     00041500
      *----------------------------------------------------------------*00041600
                                                                        00041700
      ******************************************************************00041800
      *                      I N I C I A R                             *00041900
      ******************************************************************00042000
                                                                        00042100
      *----------------------------------------------------------------*00042200
       1000-INICIAR                           SECTION.                  00042300
      *----------------------------------------------------------------*00042400
                                                                        00042500
           ACCEPT WRK-ID      FROM SYSIN.                               00042600
           MOVE   WRK-ID      TO DB2-ID.                                00042700
                                                                        00042800
      *----------------------------------------------------------------*00042900
       1000-99-FIM.                              EXIT.                  00043000
      *----------------------------------------------------------------*00044000
                                                                        00044100
      ******************************************************************00044200
      *                   P R O C E S S A R                            *00044300
      ******************************************************************00044400
                                                                        00044500
      *----------------------------------------------------------------*00044600
       2000-PROCESSAR                       SECTION.                    00044700
      *----------------------------------------------------------------*00044800
                                                                        00044900
            EXEC SQL                                                    00045000
             SELECT ID,NOME,SETOR,SALARIO,DATAADM,EMAIL,TELEFONE        00046004
              INTO :DB2-ID,                                             00046100
                   :DB2-NOME,                                           00046200
                   :DB2-SETOR,                                          00046300
                   :DB2-SALARIO,                                        00046400
                   :DB2-DATAADM,                                        00046500
                   :DB2-EMAIL    :WRK-EMAIL-NULL,                       00046610
                   :DB2-TELEFONE :WRK-TELEFONE-NULL                     00046710
              FROM FOUR001.FUNC2                                        00046803
              WHERE ID = :DB2-ID                                        00046903
            END-EXEC.                                                   00047003
                                                                        00047100
             IF (SQLCODE NOT EQUAL ZEROS AND +100) OR                   00047203
                (SQLWARN0    EQUAL 'W')                                 00047303
                MOVE 'FR05DB1'            TO  WRK-PROGRAMA              00047516
                MOVE '2000  '             TO  WRK-SECAO                 00047617
                MOVE 'NA LEITURA'         TO  WRK-MENSAGEM              00047717
                MOVE 'WRK-SQLCODE'        TO  WRK-STATUS                00047817
                MOVE SQLCODE              TO  WRK-SQLCODE               00047916
                DISPLAY 'ERRO .....' WRK-SQLCODE                        00048016
                 PERFORM 9999-TRATAR-ERROS                              00048119
             END-IF.                                                    00048203
                                                                        00048303
             IF (SQLCODE               EQUAL +100)                      00048403
                DISPLAY WRK-ID '... NAO ENCONTRADO '                    00048516
                MOVE 'FR05DB1'            TO  WRK-PROGRAMA              00048617
                MOVE '2000  '             TO  WRK-SECAO                 00048717
                MOVE 'NA LEITURA'         TO  WRK-MENSAGEM              00048817
                MOVE 'WRK-SQLCODE'        TO  WRK-STATUS                00048917
             END-IF.                                                    00049203
                                                                        00049303
             EVALUATE SQLCODE                                           00049400
               WHEN 0                                                   00049500
                DISPLAY '--------------------------------------'        00049600
                DISPLAY '             REGISTROS                '        00049700
                DISPLAY '--------------------------------------'        00049800
                DISPLAY 'ID....... ' DB2-ID                             00049900
                DISPLAY 'NOME..... ' DB2-NOME                           00050000
                DISPLAY 'SETOR.... ' DB2-SETOR                          00050100
                DISPLAY 'SALARIO.. ' DB2-SALARIO                        00050200
                DISPLAY 'DATAADM.. ' DB2-DATAADM                        00050300
                 IF WRK-EMAIL-NULL = 0                                  00050410
                    DISPLAY 'EMAIL...: ' DB2-EMAIL                      00050508
                 ELSE                                                   00050600
                    DISPLAY '-- SEM EMAIL --'                           00050708
                 END-IF                                                 00050800
                 IF WRK-TELEFONE-NULL = 0                               00050910
                    DISPLAY 'TELEFONE: ' DB2-TELEFONE                   00051010
                 ELSE                                                   00051110
                    DISPLAY '-- SEM TELEFONE --'                        00051210
                 END-IF                                                 00051310
                DISPLAY '--------------------------------------'        00051412
               WHEN 100                                                 00051500
                   DISPLAY WRK-ID '... NAO ENCONTRADO '                 00051600
               WHEN -803                                                00051703
                   DISPLAY 'DUPLICADO'                                  00051803
               WHEN OTHER                                               00051900
                   MOVE SQLCODE TO WRK-SQLCODE                          00052000
                   DISPLAY 'ERRO ...' WRK-SQLCODE                       00052100
             END-EVALUATE.                                              00052200
                                                                        00052300
             STOP RUN.                                                  00052400
                                                                        00052500
      *----------------------------------------------------------------*00052600
       2000-99-FIM.                       EXIT.                         00052700
      *----------------------------------------------------------------*00052800
                                                                        00052900
      ******************************************************************00053000
      *                 F I N A L I Z A C A O                          *00054000
      ******************************************************************00060000
                                                                        00070000
      *----------------------------------------------------------------*00071000
       3000-FINALIZAR                        SECTION.                   00072000
      *----------------------------------------------------------------*00073000
                                                                        00074000
              DISPLAY 'FIM DE PROCESSAMENTO'.                           00075003
                                                                        00076000
      *----------------------------------------------------------------*00077000
       3000-99-FIM.                           EXIT.                     00077100
      *----------------------------------------------------------------*00077200
                                                                        00077318
      ******************************************************************00077418
      *                 T R A T A R  E R R O S                         *00077518
      ******************************************************************00077618
                                                                        00077718
      *----------------------------------------------------------------*00077818
       9999-TRATAR-ERROS                     SECTION.                   00077919
      *----------------------------------------------------------------*00078018
                                                                        00079018
              CALL 'GRAVALOG'    USING WRK-LOG.                         00080018
                                                                        00081018
              GOBACK.                                                   00082018
                                                                        00090018
      *----------------------------------------------------------------*00100018
       9999-99-FIM.                           EXIT.                     00110018
      *----------------------------------------------------------------*00120018
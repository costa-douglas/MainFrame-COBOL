      *================================================================*00001000
       IDENTIFICATION                            DIVISION.              00002000
      *================================================================*00002100
                                                                        00002200
       PROGRAM-ID.  FR05DB08.                                           00002317
       AUTHOR.      DOUGLAS COSTA                                       00002400
                                                                        00002500
      *================================================================*00002600
      *                         F O U R S Y S                          *00002700
      *================================================================*00002800
      *    PROGRAMA...: FR05DB08                                       *00002917
      *    TIPO.......: SERVICO DE ACESSO A DADOS                      *00003000
      *----------------------------------------------------------------*00003100
      *    PROGAMADOR.: DOUGLAS COSTA                                  *00003200
      *    EMPRESA....: FOURSYS                                        *00003300
      *    ANALISTA...: IVAN SANCHES                                   *00003400
      *    DATA.......: 07/06/2022                                     *00003501
      *----------------------------------------------------------------*00003600
      *    OBJETIVO : ESTE PROGRAMA TEM A FINALIDADE DE INSERIR DADOS  *00003708
      *               DA TABELA FOUR001.FUNC2                          *00003803
      *----------------------------------------------------------------*00003900
      *    BASE DE DADOS:                                              *00004000
      *     TABELAS DB2                           INCLUDE/BOOK         *00004116
      *    FOUR001.FUNC2                           #BKFUNC2            *00004216
      *----------------------------------------------------------------*00004314
      *    MODULO   :                                                  *00004416
      *               GRAVALOG - TRATAMENTO DE ERROS                   *00004516
      *                                                                *00004616
      *----------------------------------------------------------------*00004714
      *    COPYBOOK :                                                  *00004816
      *               B#GRALOG - AREA DE TRATAMENTO DE ERROS           *00004916
      *                                                                *00005016
      ******************************************************************00005114
      *================================================================*00005216
                                                                        00005316
      *================================================================*00005414
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
       DATA                DIVISION.                                    00006800
      *================================================================*00006900
      *----------------------------------------------------------------*00007000
       WORKING-STORAGE                            SECTION.              00007100
      *----------------------------------------------------------------*00007200
                                                                        00007300
      *----------------------------------------------------------------*00007400
       01  FILLER                      PIC  X(050)         VALUE        00007500
                 '*** INICIO DA WORKING FR05DB08 ***'.                  00007617
      *----------------------------------------------------------------*00007700
                                                                        00007800
      *----------------------------------------------------------------*00008000
       01  FILLER                       PIC X(050)           VALUE      00009000
                    '*** AREA DE AUXILIARES ***'.                       00010000
      *----------------------------------------------------------------*00011000
                                                                        00011110
       77 WRK-CONTA              PIC 9(04).                             00012010
       77 WRK-POS                PIC 9(04).                             00012110
       77 WRK-SQLCODE            PIC -999.                              00013000
                                                                        00015107
      *----------------------------------------------------------------*00015216
       01  FILLER                       PIC X(050)           VALUE      00015316
                    '*** AREA DE ACUMULADORES ***'.                     00015416
      *----------------------------------------------------------------*00015516
                                                                        00015616
       77 ACUM-LIDOS             PIC 9(04).                             00015816
                                                                        00015916
      *----------------------------------------------------------------*00016000
       01  FILLER                       PIC X(050)           VALUE      00017000
                    '*** AREA DE VARIAVEIS ***'.                        00018000
      *----------------------------------------------------------------*00019000
                                                                        00020000
        01 WRK-ID.                                                      00021000
           02 FILLER             PIC X(10).                             00021100
           02 WRK-ID-AC          PIC 9(04).                             00021200
                                                                        00021300
        01 WRK-NOME.                                                    00021400
           02 FILLER             PIC X(10).                             00021500
           02 WRK-NOME-AC        PIC X(30).                             00021600
                                                                        00021700
        01 WRK-SETOR.                                                   00021800
           02 FILLER             PIC X(10).                             00021900
           02 WRK-SETOR-AC       PIC X(04).                             00022000
                                                                        00023000
        01 WRK-SALARIO.                                                 00023100
           02 FILLER             PIC X(10).                             00023200
           02 WRK-SALARIO-AC     PIC 9(08)V99.                          00023300
                                                                        00023400
        01 WRK-DATAADM.                                                 00023500
           02 FILLER             PIC X(10).                             00023600
           02 WRK-DATAADM-AC     PIC X(10).                             00023700
                                                                        00023800
        01 WRK-EMAIL.                                                   00023900
           02 FILLER             PIC X(10).                             00024000
           02 WRK-EMAIL-AC       PIC X(40).                             00024100
                                                                        00024201
        01 WRK-TELEFONE.                                                00024301
           02 FILLER             PIC X(10).                             00024401
           02 WRK-TELEFONE-AC    PIC X(11).                             00024501
                                                                        00024615
                                                                        00024715
      *----------------------------------------------------------------*00024815
       01  FILLER                       PIC X(050)           VALUE      00024915
                       '*** AREA DE BOOK ***'.                          00025015
      *----------------------------------------------------------------*00025115
                                                                        00025200
          COPY 'B#GRALOG'.                                              00025315
                                                                        00025415
      *----------------------------------------------------------------*00025500
       01  FILLER                       PIC X(050)           VALUE      00025600
                        '*** AREA DB2 ***'.                             00025700
      *----------------------------------------------------------------*00025800
                                                                        00025900
           EXEC SQL                                                     00026000
             INCLUDE #BKFUNC2                                           00026101
           END-EXEC.                                                    00026200
           EXEC SQL                                                     00026300
               INCLUDE SQLCA                                            00026400
           END-EXEC.                                                    00026500
                                                                        00026600
      *----------------------------------------------------------------*00026700
       01  FILLER                      PIC  X(050)         VALUE        00026800
              '*** FR05DB08 - FIM DA AREA DE WORKING ***'.              00026917
      *----------------------------------------------------------------*00027000
                                                                        00027100
      *================================================================*00027200
        PROCEDURE                       DIVISION.                       00027300
      *================================================================*00027400
                                                                        00027500
      ******************************************************************00028000
      *                    P R I N C I P A L                           *00029000
      ******************************************************************00030000
                                                                        00040000
      *----------------------------------------------------------------*00041000
       0000-PRINCIPAL                            SECTION.               00041100
      *----------------------------------------------------------------*00041200
                                                                        00041300
           PERFORM 1000-INICIAR                                         00041400
                                                                        00041500
           PERFORM 2000-PROCESSAR                                       00041600
                                                                        00041700
           PERFORM 3000-FINALIZAR                                       00041800
                                                                        00041900
           STOP RUN.                                                    00042000
                                                                        00042100
      *----------------------------------------------------------------*00042200
       0000-99-FIM.                           EXIT.                     00042300
      *----------------------------------------------------------------*00042400
                                                                        00042500
      ******************************************************************00042600
      *                      I N I C I A R                             *00042700
      ******************************************************************00042800
                                                                        00042900
      *----------------------------------------------------------------*00043000
       1000-INICIAR                           SECTION.                  00043100
      *----------------------------------------------------------------*00043200
                                                                        00043300
            ACCEPT WRK-ID.                                              00043400
            ACCEPT WRK-NOME.                                            00043500
            ACCEPT WRK-SETOR.                                           00043600
            ACCEPT WRK-SALARIO.                                         00043700
            ACCEPT WRK-DATAADM.                                         00043800
            ACCEPT WRK-EMAIL.                                           00043900
            ACCEPT WRK-TELEFONE.                                        00044001
                                                                        00044100
      *----------------------------------------------------------------*00044200
       1000-99-FIM.                              EXIT.                  00044300
      *----------------------------------------------------------------*00044400
                                                                        00044500
      ******************************************************************00044600
      *                   P R O C E S S A R                            *00044700
      ******************************************************************00044800
                                                                        00044900
      *----------------------------------------------------------------*00045000
       2000-PROCESSAR                       SECTION.                    00045100
      *----------------------------------------------------------------*00045200
                                                                        00045300
            MOVE WRK-ID-AC                 TO DB2-ID.                   00045409
            MOVE WRK-NOME-AC               TO DB2-NOME.                 00045509
            MOVE WRK-SETOR-AC              TO DB2-SETOR.                00045609
            MOVE WRK-SALARIO-AC            TO DB2-SALARIO.              00045709
            MOVE WRK-DATAADM-AC            TO DB2-DATAADM.              00045809
                                                                        00045909
            PERFORM VARYING WRK-CONTA      FROM 40                      00046009
                     BY -1 UNTIL WRK-CONTA EQUAL 0                      00046109
              IF WRK-EMAIL-AC(WRK-CONTA:1) NOT EQUAL SPACES             00046209
                 MOVE WRK-CONTA            TO WRK-POS                   00046309
                 MOVE 1                    TO WRK-CONTA                 00046413
              END-IF                                                    00046609
            END-PERFORM.                                                00046712
                                                                        00046809
            MOVE WRK-POS                   TO DB2-EMAIL-LEN.            00046909
            MOVE WRK-EMAIL-AC              TO DB2-EMAIL-TEXT.           00047009
            MOVE WRK-TELEFONE-AC           TO DB2-TELEFONE.             00047109
                                                                        00047200
            EXEC SQL                                                    00047300
             INSERT  INTO                                               00047400
             FOUR001.FUNC2(ID,NOME,SETOR,SALARIO,DATAADM,EMAIL,TELEFONE)00047503
             VALUES(:DB2-ID,                                            00047600
                    :DB2-NOME,                                          00047700
                    :DB2-SETOR,                                         00047800
                    :DB2-SALARIO,                                       00047900
                    :DB2-DATAADM,                                       00048000
                    :DB2-EMAIL,                                         00048101
                    :DB2-TELEFONE)                                      00048201
             END-EXEC.                                                  00048300
                                                                        00048401
             IF (SQLCODE NOT EQUAL ZEROS AND +100) OR                   00048515
                 (SQLWARN0    EQUAL 'W')                                00048615
                 MOVE 'FR05DB1'            TO  WRK-PROGRAMA             00048715
                 MOVE '2000  '             TO  WRK-SECAO                00048815
                 MOVE 'NA LEITURA'         TO  WRK-MENSAGEM             00048915
                 MOVE 'WRK-SQLCODE'        TO  WRK-STATUS               00049015
                 MOVE SQLCODE              TO  WRK-SQLCODE              00049115
                 DISPLAY 'ERRO .....' WRK-SQLCODE                       00049615
                  PERFORM 9999-TRATAR-ERROS                             00049715
             END-IF.                                                    00049815
                                                                        00049915
             IF (SQLCODE               EQUAL +100)                      00050015
                 DISPLAY WRK-ID '... NAO ENCONTRADO '                   00050115
                 MOVE 'FR05DB1'            TO  WRK-PROGRAMA             00050215
                 MOVE '2000  '             TO  WRK-SECAO                00050315
                 MOVE 'NA LEITURA'         TO  WRK-MENSAGEM             00050415
                 MOVE 'WRK-SQLCODE'        TO  WRK-STATUS               00050515
             END-IF.                                                    00050615
                                                                        00050715
             EVALUATE SQLCODE                                           00050800
               WHEN 0                                                   00050900
                ADD 1                         TO ACUM-LIDOS             00051002
                DISPLAY '--------------------------------------'        00051100
                DISPLAY '           DADOS GRAVADOS             '        00051200
                DISPLAY '--------------------------------------'        00051300
                DISPLAY 'ID....... ' DB2-ID                             00051400
                DISPLAY 'NOME..... ' DB2-NOME                           00051500
                DISPLAY 'SETOR.... ' DB2-SETOR                          00051600
                DISPLAY 'SALARIO.. ' DB2-SALARIO                        00051700
                DISPLAY 'DATAADM.. ' DB2-DATAADM                        00051800
                DISPLAY 'EMAIL.... ' DB2-EMAIL-TEXT                     00051911
                DISPLAY 'TELEFONE. ' DB2-TELEFONE                       00052002
                DISPLAY '--------------------------------------'        00052100
               WHEN -181                                                00052200
                 DISPLAY 'FORMATO DATA ERRADO ' WRK-DATAADM-AC          00052300
               WHEN -803                                                00052402
                 DISPLAY 'DUPLICADO'                                    00052502
               WHEN OTHER                                               00052600
                 MOVE SQLCODE  TO WRK-SQLCODE                           00052700
                 DISPLAY 'ERRO.... ' WRK-SQLCODE                        00052800
             END-EVALUATE.                                              00052900
      *----------------------------------------------------------------*00053000
       2000-99-FIM.                       EXIT.                         00053100
      *----------------------------------------------------------------*00054000
                                                                        00060000
      ******************************************************************00070000
      *                 F I N A L I Z A C A O                          *00071000
      ******************************************************************00072000
                                                                        00073000
      *----------------------------------------------------------------*00074000
       3000-FINALIZAR                        SECTION.                   00075000
      *----------------------------------------------------------------*00076000
                                                                        00077000
              DISPLAY 'TOTAL LIDOS...: ' ACUM-LIDOS.                    00077107
                                                                        00077200
      *----------------------------------------------------------------*00077300
       3000-99-FIM.                           EXIT.                     00077400
      *----------------------------------------------------------------*00077500
                                                                        00077615
      ******************************************************************00077715
      *                 T R A T A R   E R R O S                        *00077815
      ******************************************************************00077915
                                                                        00078015
      *----------------------------------------------------------------*00079015
       9999-TRATAR-ERROS                     SECTION.                   00080015
      *----------------------------------------------------------------*00090015
                                                                        00100015
           CALL 'GRAVALOG'      USING WRK-LOG.                          00110015
                                                                        00111015
           GOBACK.                                                      00112015
                                                                        00120015
      *----------------------------------------------------------------*00130015
       9999-99-FIM.                           EXIT.                     00140015
      *----------------------------------------------------------------*00150015
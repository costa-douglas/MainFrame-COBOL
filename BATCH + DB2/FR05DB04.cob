      *================================================================*00001000
       IDENTIFICATION                            DIVISION.              00002000
      *================================================================*00002100
                                                                        00002200
       PROGRAM-ID.  FR05DB04.                                           00002300
       AUTHOR.      DOUGLAS COSTA                                       00002400
                                                                        00002500
      *================================================================*00002600
      *                         F O U R S Y S                          *00002700
      *================================================================*00002800
      *    PROGRAMA...: FR05DB04                                       *00002900
      *    TIPO.......: SERVICO DE ACESSO A DADOS                      *00003000
      *----------------------------------------------------------------*00003100
      *    PROGAMADOR.: DOUGLAS COSTA                                  *00003200
      *    EMPRESA....: FOURSYS                                        *00003300
      *    ANALISTA...: IVAN SANCHES                                   *00003400
      *    DATA.......: 03/06/2022                                     *00003500
      *----------------------------------------------------------------*00003600
      *    OBJETIVO : ESTE PROGRAMA TEM A FINALIDADE DE ATUALIZAR DADOS*00003702
      *               DA TABELA FOUR001.FUNC                           *00003800
      *----------------------------------------------------------------*00003900
      *    BASE DE DADOS:                                              *00004000
      *      TABELAS DB2                           INCLUDE/BOOK        *00004100
      *      FOUR001.FUNC                           BOOKFUNC           *00004200
      ******************************************************************00004900
      *================================================================*00005000
                                                                        00005100
      *================================================================*00005200
       ENVIRONMENT DIVISION.                                            00005300
      *================================================================*00005400
                                                                        00005500
      *----------------------------------------------------------------*00005600
       CONFIGURATION                              SECTION.              00005700
      *----------------------------------------------------------------*00005800
                                                                        00005900
       SPECIAL-NAMES.                                                   00006000
           DECIMAL-POINT IS COMMA.                                      00006100
                                                                        00006200
      *----------------------------------------------------------------*00006300
                                                                        00006400
      *================================================================*00006500
       DATA                                       DIVISION.             00006601
      *================================================================*00006700
      *----------------------------------------------------------------*00006800
       WORKING-STORAGE                            SECTION.              00006900
      *----------------------------------------------------------------*00007000
                                                                        00008000
      *----------------------------------------------------------------*00009000
       01  FILLER                      PIC  X(050)         VALUE        00010000
                 '*** INICIO DA WORKING FR05DB04 ***'.                  00011001
      *----------------------------------------------------------------*00012000
                                                                        00013000
      *----------------------------------------------------------------*00014000
       01  FILLER                       PIC X(050)           VALUE      00015000
                    '*** AREA DE AUXILIARES ***'.                       00016000
      *----------------------------------------------------------------*00017000
                                                                        00018000
       77 WRK-SQLCODE            PIC -999.                              00019000
       77 WRK-INDICATOR          PIC S9(4) COMP VALUE ZEROS.            00020000
                                                                        00021000
      *----------------------------------------------------------------*00021100
       01  FILLER                       PIC X(050)           VALUE      00021200
                    '*** AREA DE VARIAVEIS ***'.                        00021300
      *----------------------------------------------------------------*00021400
                                                                        00021500
        01 WRK-ID.                                                      00021601
           02 FILLER             PIC X(10).                             00021701
           02 WRK-ID-AC          PIC 9(04).                             00021801
                                                                        00021901
        01 WRK-NOME.                                                    00022001
           02 FILLER             PIC X(10).                             00022101
           02 WRK-NOME-AC        PIC X(30).                             00022201
                                                                        00022301
        01 WRK-SETOR.                                                   00022401
           02 FILLER             PIC X(10).                             00022501
           02 WRK-SETOR-AC       PIC X(04).                             00022601
                                                                        00022701
        01 WRK-SALARIO.                                                 00022801
           02 FILLER             PIC X(10).                             00022901
           02 WRK-SALARIO-AC     PIC 9(08)V99.                          00023006
                                                                        00023101
        01 WRK-DATAADM.                                                 00023201
           02 FILLER             PIC X(10).                             00023301
           02 WRK-DATAADM-AC     PIC X(10).                             00023401
                                                                        00023501
        01 WRK-EMAIL.                                                   00023601
           02 FILLER             PIC X(10).                             00023701
           02 WRK-EMAIL-AC       PIC X(40).                             00023801
                                                                        00023901
      *----------------------------------------------------------------*00024000
      *----------------------------------------------------------------*00024700
       01  FILLER                       PIC X(050)           VALUE      00024800
                        '*** AREA DB2 ***'.                             00024900
      *----------------------------------------------------------------*00025000
                                                                        00025100
           EXEC SQL                                                     00025200
             INCLUDE BOOKFUNC                                           00025300
           END-EXEC.                                                    00025400
           EXEC SQL                                                     00025500
               INCLUDE SQLCA                                            00025600
           END-EXEC.                                                    00025700
                                                                        00025800
      *----------------------------------------------------------------*00025900
       01  FILLER                      PIC  X(050)         VALUE        00026000
              '*** FR05DB04 - FIM DA AREA DE WORKING ***'.              00026101
      *----------------------------------------------------------------*00026200
                                                                        00026300
      *================================================================*00026400
        PROCEDURE                       DIVISION.                       00026500
      *================================================================*00026600
                                                                        00026700
      ******************************************************************00026800
      *                    P R I N C I P A L                           *00026900
      ******************************************************************00027000
                                                                        00028000
      *----------------------------------------------------------------*00029000
       0000-PRINCIPAL                            SECTION.               00030000
      *----------------------------------------------------------------*00040000
                                                                        00041000
           PERFORM 1000-INICIAR                                         00041100
                                                                        00041200
           PERFORM 2000-PROCESSAR                                       00041300
                                                                        00041400
           PERFORM 3000-FINALIZAR                                       00041500
                                                                        00041600
           STOP RUN.                                                    00041700
                                                                        00041800
      *----------------------------------------------------------------*00041900
       0000-99-FIM.                           EXIT.                     00042000
      *----------------------------------------------------------------*00042100
                                                                        00042200
      ******************************************************************00042300
      *                      I N I C I A R                             *00042400
      ******************************************************************00042500
                                                                        00042600
      *----------------------------------------------------------------*00042700
       1000-INICIAR                           SECTION.                  00042800
      *----------------------------------------------------------------*00042900
                                                                        00043000
            ACCEPT WRK-ID.                                              00043100
            ACCEPT WRK-NOME.                                            00043200
            ACCEPT WRK-SETOR.                                           00043300
            ACCEPT WRK-SALARIO.                                         00043400
            ACCEPT WRK-DATAADM.                                         00043500
            ACCEPT WRK-EMAIL.                                           00043600
                                                                        00043700
      *----------------------------------------------------------------*00043800
       1000-99-FIM.                              EXIT.                  00043900
      *----------------------------------------------------------------*00044000
                                                                        00045000
      ******************************************************************00045100
      *                   P R O C E S S A R                            *00045200
      ******************************************************************00045300
                                                                        00045400
      *----------------------------------------------------------------*00045500
       2000-PROCESSAR                       SECTION.                    00045600
      *----------------------------------------------------------------*00045700
             EXEC SQL                                                   00046503
               SELECT ID,NOME,SETOR,SALARIO,DATAADM,EMAIL               00047703
                INTO :DB2-ID,                                           00047803
                     :DB2-NOME,                                         00047903
                     :DB2-SETOR,                                        00048003
                     :DB2-SALARIO,                                      00048103
                     :DB2-DATAADM,                                      00048203
                     :DB2-EMAIL                                         00048303
                FROM FOUR001.FUNC                                       00048403
                WHERE ID = :DB2-ID                                      00048503
             END-EXEC.                                                  00048603
                                                                        00048703
             EVALUATE TRUE                                              00048803
             WHEN DB2-NOME              NOT EQUAL WRK-NOME-AC AND       00048903
                  WRK-NOME-AC           NOT EQUAL SPACES                00049003
             MOVE WRK-NOME-AC           TO DB2-NOME                     00049103
                                                                        00049203
             WHEN DB2-SETOR             NOT EQUAL WRK-SETOR-AC AND      00049303
                  WRK-SETOR-AC          NOT EQUAL SPACES                00049403
             MOVE WRK-SETOR-AC          TO DB2-SETOR                    00049503
                                                                        00049603
             WHEN DB2-SALARIO           NOT EQUAL WRK-SALARIO-AC AND    00049703
                  WRK-SALARIO-AC        NOT EQUAL ZEROS                 00049803
             MOVE WRK-SALARIO-AC        TO DB2-SALARIO                  00049903
                                                                        00050003
             WHEN DB2-DATAADM           NOT EQUAL WRK-DATAADM-AC AND    00050103
                  WRK-DATAADM-AC        NOT EQUAL SPACES                00050203
             MOVE WRK-DATAADM-AC        TO DB2-DATAADM                  00050303
                                                                        00050403
             WHEN DB2-EMAIL             NOT EQUAL WRK-EMAIL-AC AND      00050503
                  WRK-EMAIL-AC          NOT EQUAL SPACES                00050603
             MOVE WRK-EMAIL-AC          TO DB2-EMAIL                    00050703
                                                                        00050800
             END-EVALUATE.                                              00050903
                                                                        00051003
             MOVE WRK-ID-AC             TO DB2-ID.                      00051103
             MOVE WRK-NOME-AC           TO DB2-NOME.                    00051203
             MOVE WRK-SETOR-AC          TO DB2-SETOR.                   00051303
             MOVE WRK-SALARIO-AC        TO DB2-SALARIO.                 00051403
             MOVE WRK-DATAADM-AC        TO DB2-DATAADM.                 00051503
             MOVE WRK-EMAIL-AC          TO DB2-EMAIL.                   00051603
                                                                        00051703
             EXEC SQL                                                   00051803
              UPDATE FOUR001.FUNC                                       00051903
               SET  NOME    =:DB2-NOME,                                 00052003
                    SETOR   =:DB2-SETOR,                                00052103
                    SALARIO =:DB2-SALARIO,                              00052203
                    DATAADM =:DB2-DATAADM,                              00052303
                    EMAIL   =:DB2-EMAIL                                 00052403
               WHERE ID=:DB2-ID                                         00052503
             END-EXEC.                                                  00052603
                                                                        00052703
             EVALUATE SQLCODE                                           00052800
               WHEN 0                                                   00052900
                DISPLAY '--------------------------------------'        00053000
                DISPLAY '           DADOS ALTERADOS            '        00053100
                DISPLAY '--------------------------------------'        00053200
                DISPLAY 'ID....... ' DB2-ID                             00053300
                DISPLAY 'NOME..... ' DB2-NOME                           00053400
                DISPLAY 'SETOR.... ' DB2-SETOR                          00053500
                DISPLAY 'SALARIO.. ' DB2-SALARIO                        00053600
                DISPLAY 'DATAADM.. ' DB2-DATAADM                        00053700
                DISPLAY 'EMAIL.... ' DB2-EMAIL                          00053800
                DISPLAY '--------------------------------------'        00053900
               WHEN -181                                                00054000
                 DISPLAY 'FORMATO DATA ERRADO ' WRK-DATAADM-AC          00054100
               WHEN OTHER                                               00054200
                 MOVE SQLCODE  TO WRK-SQLCODE                           00054300
                 DISPLAY 'ERRO.... ' WRK-SQLCODE                        00054400
             END-EVALUATE.                                              00054500
      *----------------------------------------------------------------*00054600
       2000-99-FIM.                       EXIT.                         00054700
      *----------------------------------------------------------------*00054800
                                                                        00054900
      ******************************************************************00055000
      *                 F I N A L I Z A C A O                          *00056000
      ******************************************************************00060000
                                                                        00070000
      *----------------------------------------------------------------*00071000
       3000-FINALIZAR                        SECTION.                   00072000
      *----------------------------------------------------------------*00073000
                                                                        00074000
              DISPLAY 'FIM DE PROCESSAMENTO'.                           00075004
                                                                        00076000
      *----------------------------------------------------------------*00077000
       3000-99-FIM.                           EXIT.                     00077100
      *----------------------------------------------------------------*00077200

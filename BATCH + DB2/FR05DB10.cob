      *================================================================*00001000
       IDENTIFICATION                            DIVISION.              00002000
      *================================================================*00002100
                                                                        00002200
       PROGRAM-ID.  FR05DB10.                                           00002305
       AUTHOR.      DOUGLAS COSTA                                       00002400
                                                                        00002500
      *================================================================*00002600
      *                         F O U R S Y S                          *00002700
      *================================================================*00002800
      *    PROGRAMA...: FR05DB10                                       *00002905
      *    TIPO.......: SERVICO DE ACESSO A DADOS                      *00003000
      *----------------------------------------------------------------*00003100
      *    PROGAMADOR.: DOUGLAS COSTA                                  *00003200
      *    EMPRESA....: FOURSYS                                        *00003300
      *    ANALISTA...: IVAN SANCHES                                   *00003400
      *    DATA.......: 07/06/2022                                     *00003500
      *----------------------------------------------------------------*00003600
      *    OBJETIVO : ESTE PROGRAMA TEM A FINALIDADE DE DELETAR DADOS  *00003700
      *               DA TABELA FOUR001.FUNC2                          *00003800
      *----------------------------------------------------------------*00003900
      *    BASE DE DADOS:                                              *00004000
      *     TABELAS DB2                           INCLUDE/BOOK         *00004104
      *    FOUR001.FUNC2                           #BKFUNC2            *00004204
      *----------------------------------------------------------------*00004303
      *    MODULO   :                                                  *00004404
      *               GRAVALOG - TRATAMENTO DE ERROS                   *00004504
      *                                                                *00004604
      *----------------------------------------------------------------*00004703
      *    COPYBOOK :                                                  *00004804
      *               B#GRALOG - AREA DE TRATAMENTO DE ERROS           *00004904
      *                                                                *00005004
      ******************************************************************00005103
      *================================================================*00005204
                                                                        00005304
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
       DATA                                       DIVISION.             00006800
      *================================================================*00006900
      *----------------------------------------------------------------*00007000
       WORKING-STORAGE                            SECTION.              00007100
      *----------------------------------------------------------------*00007200
                                                                        00007300
      *----------------------------------------------------------------*00007400
       01  FILLER                      PIC  X(050)         VALUE        00007500
                 '*** INICIO DA WORKING FR05DB10 ***'.                  00007605
      *----------------------------------------------------------------*00007700
                                                                        00007800
      *----------------------------------------------------------------*00008000
       01  FILLER                       PIC X(050)           VALUE      00009000
                    '*** AREA DE AUXILIARES ***'.                       00010000
      *----------------------------------------------------------------*00011000
                                                                        00011102
       77 WRK-ID                 PIC 9(04).                             00012000
       77 WRK-SQLCODE            PIC -999.                              00013000
       77 WRK-INDICATOR          PIC S9(4) COMP VALUE ZEROS.            00014000
                                                                        00015000
      *----------------------------------------------------------------*00015103
       01  FILLER                       PIC X(050)           VALUE      00015203
                        '*** AREA DE BOOK ***'.                         00015303
      *----------------------------------------------------------------*00015403
                                                                        00015503
           COPY 'B#GRALOG'.                                             00015603
                                                                        00015703
      *----------------------------------------------------------------*00016000
       01  FILLER                       PIC X(050)           VALUE      00017000
                        '*** AREA DB2 ***'.                             00018000
      *----------------------------------------------------------------*00019000
                                                                        00020000
           EXEC SQL                                                     00021000
             INCLUDE #BKFUNC2                                           00022000
           END-EXEC.                                                    00023000
           EXEC SQL                                                     00024000
               INCLUDE SQLCA                                            00025000
           END-EXEC.                                                    00025100
                                                                        00025200
      *----------------------------------------------------------------*00025300
       01  FILLER                      PIC  X(050)         VALUE        00025400
              '*** FR05DB10 - FIM DA AREA DE WORKING ***'.              00025505
      *----------------------------------------------------------------*00025600
                                                                        00025700
      *================================================================*00025800
        PROCEDURE                       DIVISION.                       00025900
      *================================================================*00026000
                                                                        00026100
      ******************************************************************00026200
      *                    P R I N C I P A L                           *00026300
      ******************************************************************00026400
                                                                        00026500
      *----------------------------------------------------------------*00026600
       0000-PRINCIPAL                            SECTION.               00026700
      *----------------------------------------------------------------*00026800
                                                                        00026900
           PERFORM 1000-INICIAR                                         00027000
                                                                        00028000
           PERFORM 2000-PROCESSAR                                       00029000
                                                                        00030000
           PERFORM 3000-FINALIZAR                                       00040000
                                                                        00041000
           STOP RUN.                                                    00041100
                                                                        00041200
      *----------------------------------------------------------------*00041300
       0000-99-FIM.                           EXIT.                     00041400
      *----------------------------------------------------------------*00041500
                                                                        00041600
      ******************************************************************00041700
      *                      I N I C I A R                             *00041800
      ******************************************************************00041900
                                                                        00042000
      *----------------------------------------------------------------*00042100
       1000-INICIAR                           SECTION.                  00042200
      *----------------------------------------------------------------*00042300
                                                                        00042400
            ACCEPT WRK-ID   FROM SYSIN.                                 00042500
            MOVE WRK-ID     TO DB2-ID.                                  00042600
                                                                        00042700
      *----------------------------------------------------------------*00042800
       1000-99-FIM.                              EXIT.                  00042900
      *----------------------------------------------------------------*00043000
                                                                        00044000
      ******************************************************************00045000
      *                   P R O C E S S A R                            *00045100
      ******************************************************************00045200
                                                                        00045300
      *----------------------------------------------------------------*00045400
       2000-PROCESSAR                       SECTION.                    00045500
      *----------------------------------------------------------------*00045600
                                                                        00045700
            EXEC SQL                                                    00045800
             DELETE FROM FOUR001.FUNC2 WHERE ID = :DB2-ID               00045900
            END-EXEC.                                                   00046000
                                                                        00047000
            IF (SQLCODE NOT EQUAL ZEROS AND +100) OR                    00048003
               (SQLWARN0    EQUAL 'W')                                  00048103
               MOVE 'FR05DB1'            TO  WRK-PROGRAMA               00048203
               MOVE '2000  '             TO  WRK-SECAO                  00048303
               MOVE 'NA LEITURA'         TO  WRK-MENSAGEM               00048403
               MOVE 'WRK-SQLCODE'        TO  WRK-STATUS                 00048503
               MOVE SQLCODE              TO  WRK-SQLCODE                00048603
               DISPLAY 'ERRO .....' WRK-SQLCODE                         00048703
                PERFORM 9999-TRATAR-ERROS                               00048803
            END-IF.                                                     00048903
                                                                        00049000
            IF (SQLCODE               EQUAL +100)                       00049103
               DISPLAY WRK-ID '... NAO ENCONTRADO '                     00049203
               MOVE 'FR05DB1'            TO  WRK-PROGRAMA               00049303
               MOVE '2000  '             TO  WRK-SECAO                  00049403
               MOVE 'NA LEITURA'         TO  WRK-MENSAGEM               00049503
               MOVE 'WRK-SQLCODE'        TO  WRK-STATUS                 00049603
            END-IF.                                                     00049703
                                                                        00049803
             EVALUATE SQLCODE                                           00049900
               WHEN 0                                                   00050000
                 DISPLAY '--------------------------------------'       00050100
                 DISPLAY '           DADOS DELETADOS            '       00050200
                 DISPLAY '--------------------------------------'       00050300
                 DISPLAY 'ID....... ' DB2-ID                            00050400
                 DISPLAY 'NOME..... ' DB2-NOME                          00050500
                 DISPLAY 'SETOR.... ' DB2-SETOR                         00050600
                 DISPLAY 'SALARIO.. ' DB2-SALARIO                       00050700
                 DISPLAY 'DATAADM.. ' DB2-DATAADM                       00050800
                 DISPLAY 'EMAIL.... ' DB2-EMAIL-TEXT                    00050900
                 DISPLAY 'TELEFONE. ' DB2-TELEFONE                      00051000
                 DISPLAY '--------------------------------------'       00051100
                  IF WRK-INDICATOR = 0                                  00051200
                     DISPLAY 'ID... ' WRK-ID                            00051300
                  ELSE                                                  00051400
                     DISPLAY '-- SEM ID CADASTRADO '                    00051500
                  END-IF                                                00051600
                                                                        00051700
               WHEN 100                                                 00051800
                 DISPLAY ' ... ID N?O ENCONTRADO ' WRK-ID               00051900
                                                                        00052000
               WHEN OTHER                                               00052100
                 MOVE SQLCODE         TO WRK-SQLCODE                    00052200
                 DISPLAY 'ERRO ... ' WRK-SQLCODE                        00052300
                                                                        00052400
             END-EVALUATE.                                              00052500
      *----------------------------------------------------------------*00052600
       2000-99-FIM.                       EXIT.                         00052700
      *----------------------------------------------------------------*00052800
                                                                        00052900
      ******************************************************************00053000
      *                 F I N A L I Z A C A O                          *00053100
      ******************************************************************00053200
                                                                        00053300
      *----------------------------------------------------------------*00053400
       3000-FINALIZAR                        SECTION.                   00053500
      *----------------------------------------------------------------*00053600
                                                                        00053700
              DISPLAY 'FIM DE PROCESSAMENTO'.                           00053800
                                                                        00053900
      *----------------------------------------------------------------*00054000
       3000-99-FIM.                           EXIT.                     00054100
      *----------------------------------------------------------------*00055000
                                                                        00056003
      ******************************************************************00057003
      *                 T R A T A R   E R R O S                        *00058003
      ******************************************************************00059003
                                                                        00060003
      *----------------------------------------------------------------*00070003
       9999-TRATAR-ERROS                     SECTION.                   00080003
      *----------------------------------------------------------------*00090003
                                                                        00100003
           CALL 'GRAVALOG'      USING WRK-LOG.                          00110003
                                                                        00120003
           GOBACK.                                                      00121003
                                                                        00122003
      *----------------------------------------------------------------*00130003
       9999-99-FIM.                           EXIT.                     00140003
      *----------------------------------------------------------------*00150003

//FOUR005X JOB 'EXEC DB2',MSGCLASS=X,CLASS=C,NOTIFY=&SYSUID,TIME=(0,01) 00010003
//*-------------------------------------------------------------------* 00020000
//*      JOB DE EXECUCAO   DE PROGRAMA COBOL COM DB2 BATCH            * 00030000
//*-------------------------------------------------------------------* 00040000
//EXECDB   EXEC PGM=IKJEFT01,DYNAMNBR=20                                00060008
//STEPLIB  DD   DSN=DSN810.SDSNLOAD,DISP=SHR
//LOGERROS DD   DSN=GR.FOUR005.LOGERROS,DISP=OLD
//DBRMLIB  DD   DSN=DSN810.DBRMLIB.DATA,DISP=SHR
//SYSTSPRT DD   SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSOUT   DD   SYSOUT=*
//SYSTSIN  DD   *                                                       00080000
  DSN  SYSTEM(DB8G)
  RUN PROGRAM(FR05DB08) PLAN(FR05DB08) -                                00090004
       LIB('GR.GERAL.LOADLIB')                                          00100000
  END                                                                   00120000
/*
//SYSIN    DD *
ID.......:0553
NOME.....:HOMER SIMPSON
SETOR....:KKKK
SALARIO..:0000050000
DATAADM..:12/05/2018
EMAIL....:HOMERSI@HOTMAIL.COM
TELEFONE.:11000000000

//FOUR005X JOB 'COMPDB2',MSGCLASS=X,CLASS=C,NOTIFY=&SYSUID,TIME=(0,01)
//*-------------------------------------------------------------------*
//*      JOB DE COMPILACAO DE PROGRAMA COBOL COM DB2 BATCH            *
//*      NAME = SEU PROGRAMA  -   INSTR = SUA CHAVE
//*-------------------------------------------------------------------*
//         JCLLIB ORDER=GR.GERAL.PROCLIB
//COMPDB2B EXEC DFHCODB2,NAME=FR05DB11,INSTR=FOUR005
//LKED.SYSIN    DD   *
  NAME FR05DB11(R)
//*
//BIND.SYSTSIN  DD *
DSN  SYSTEM(DB8G)
BIND PLAN(FR05DB11)MEM(FR05DB11) ACT(REP) ISOLATION(CS) -
       LIB('DSN810.DBRMLIB.DATA')
END
//*

//FOUR005X JOB 'CRIAVSAM',MSGCLASS=X,CLASS=C,NOTIFY=&SYSUID,TIME=(0,01)
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
 DEFINE CLUSTER (NAME(GR.FOUR005.ARQVSAM) -
   IXD -
   VOL(PR39X7) -
   RECORDSIZE(99 99) -
   FREESPACE(04 04) -
   SHR(2) -
   TRK(1 1) -
   UNIQUE -
   KEYS(05 0)) -
  DATA(NAME(GR.FOUR005.ARQVSAM.DATA)) -
  INDEX(NAME(GR.FOUR005.ARQVSAM.INDEX))

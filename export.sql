--------------------------------------------------------
--  File created - Tuesday-February-28-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type PARCHEGGIO_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."PARCHEGGIO_TY" AS OBJECT (
nome varchar2(30),
via varchar2(50),
latitudine decimal(9,6),
longitudine decimal(9,6)) NOT FINAL;


/

--------------------------------------------------------
--  DDL for Type PASS_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."PASS_TY" AS OBJECT (
codice varchar(5),
dataRilascio date,
scadenza date,
NomeZona varchar2(25),
targaAuto varchar2(10),
ppc ref ppc_ty,
utente ref utente_ty
) FINAL;


/

--------------------------------------------------------
--  DDL for Type PL_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."PL_TY" UNDER parcheggio_ty (
durataMaxSosta number(2) 
) FINAL;


/

--------------------------------------------------------
--  DDL for Type POSTOAUTO_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."POSTOAUTO_TY" AS OBJECT (
numero integer,
larghezza integer,
lunghezza integer,
libero char(1),
ppc varchar2(30),
sensore ref sensore_ty
) FINAL;


/

--------------------------------------------------------
--  DDL for Type PPC_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."PPC_TY" UNDER parcheggio_ty (
telefono number(8),
mail varchar2(30),
società varchar2(50),
postiauto integer
) FINAL;


/

--------------------------------------------------------
--  DDL for Type SENSORE_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."SENSORE_TY" AS OBJECT (
codice varchar2(5),
modello varchar2(20),
azienda varchar2(30)
) FINAL;


/

--------------------------------------------------------
--  DDL for Type SOSTA_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."SOSTA_TY" AS OBJECT (
codice varchar(8),
dataInizio date,
dataFine date,
costo integer,
targaAuto varchar2(10),
ppc ref ppc_ty,
utente ref utente_ty,
MEMBER FUNCTION 
CalcolaCosto 
RETURN NUMBER
) FINAL;
/
CREATE OR REPLACE TYPE BODY "PARCHEGGIO"."SOSTA_TY" AS
MEMBER FUNCTION
CalcolaCosto
RETURN NUMBER IS
BEGIN
RETURN  24 * (to_date(to_char(dataFine, 'YYYY-MM-DD hh24:mi'), 'YYYY-MM-DD hh24:mi') - to_date(to_char(dataInizio, 'YYYY-MM-DD hh24:mi'), 'YYYY-MM-DD hh24:mi'))*0.5;
END;
END;


/

--------------------------------------------------------
--  DDL for Type UTENTEABBONATO_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."UTENTEABBONATO_TY" UNDER utente_ty () NOT FINAL;


/

--------------------------------------------------------
--  DDL for Type UTENTEPREMIUM_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."UTENTEPREMIUM_TY" UNDER utente_ty (
nickname varchar2(30),
passwd varchar2(8)) FINAL;


/

--------------------------------------------------------
--  DDL for Type UTENTE_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "PARCHEGGIO"."UTENTE_TY" AS OBJECT (
cf varchar2(16),
nome varchar2(30),
cognome varchar2(30),
anno_nascita integer,
numero_patente varchar2(15)
) NOT FINAL;


/

--------------------------------------------------------
--  DDL for Table PARCHEGGIO
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."PARCHEGGIO" OF "PARCHEGGIO"."PARCHEGGIO_TY" 
 ;
--------------------------------------------------------
--  DDL for Table PASS
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."PASS" OF "PARCHEGGIO"."PASS_TY" 
   (	SCOPE FOR ("PPC") IS "PARCHEGGIO"."PPC" , 
	SCOPE FOR ("UTENTE") IS "PARCHEGGIO"."UTENTE" 
   ) ;
--------------------------------------------------------
--  DDL for Table PL
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."PL" OF "PARCHEGGIO"."PL_TY" 
 ;
--------------------------------------------------------
--  DDL for Table POSTOAUTO
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."POSTOAUTO" OF "PARCHEGGIO"."POSTOAUTO_TY" 
   (	SCOPE FOR ("SENSORE") IS "PARCHEGGIO"."SENSORE" 
   ) ;
--------------------------------------------------------
--  DDL for Table PPC
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."PPC" OF "PARCHEGGIO"."PPC_TY" 
 ;
--------------------------------------------------------
--  DDL for Table SENSORE
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."SENSORE" OF "PARCHEGGIO"."SENSORE_TY" 
 ;
--------------------------------------------------------
--  DDL for Table SOSTA
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."SOSTA" OF "PARCHEGGIO"."SOSTA_TY" 
   (	SCOPE FOR ("PPC") IS "PARCHEGGIO"."PPC" , 
	SCOPE FOR ("UTENTE") IS "PARCHEGGIO"."UTENTE" 
   ) ;
--------------------------------------------------------
--  DDL for Table UTENTE
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."UTENTE" OF "PARCHEGGIO"."UTENTE_TY" 
 ;
--------------------------------------------------------
--  DDL for Table UTENTEABBONATO
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."UTENTEABBONATO" OF "PARCHEGGIO"."UTENTEABBONATO_TY" 
 ;
--------------------------------------------------------
--  DDL for Table UTENTEPREMIUM
--------------------------------------------------------

  CREATE TABLE "PARCHEGGIO"."UTENTEPREMIUM" OF "PARCHEGGIO"."UTENTEPREMIUM_TY" 
 ;
--------------------------------------------------------
--  Constraints for Table PL
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."PL" MODIFY ("DURATAMAXSOSTA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PL" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table PARCHEGGIO
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."PARCHEGGIO" MODIFY ("VIA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PARCHEGGIO" MODIFY ("LATITUDINE" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PARCHEGGIO" MODIFY ("LONGITUDINE" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PARCHEGGIO" ADD PRIMARY KEY ("NOME") ENABLE;
 
  ALTER TABLE "PARCHEGGIO"."PARCHEGGIO" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table PPC
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."PPC" MODIFY ("TELEFONO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PPC" MODIFY ("MAIL" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PPC" MODIFY ("SOCIETÀ" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PPC" MODIFY ("POSTIAUTO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PPC" ADD PRIMARY KEY ("NOME") ENABLE;
 
  ALTER TABLE "PARCHEGGIO"."PPC" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table PASS
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."PASS" MODIFY ("DATARILASCIO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PASS" MODIFY ("SCADENZA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PASS" MODIFY ("NOMEZONA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PASS" MODIFY ("TARGAAUTO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."PASS" ADD PRIMARY KEY ("CODICE") ENABLE;
 
  ALTER TABLE "PARCHEGGIO"."PASS" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table POSTOAUTO
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."POSTOAUTO" MODIFY ("LARGHEZZA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."POSTOAUTO" MODIFY ("LUNGHEZZA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."POSTOAUTO" MODIFY ("LIBERO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."POSTOAUTO" ADD PRIMARY KEY ("NUMERO", "PPC") ENABLE;
 
  ALTER TABLE "PARCHEGGIO"."POSTOAUTO" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table UTENTEABBONATO
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."UTENTEABBONATO" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table SOSTA
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."SOSTA" MODIFY ("DATAINIZIO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."SOSTA" MODIFY ("DATAFINE" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."SOSTA" MODIFY ("TARGAAUTO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."SOSTA" ADD PRIMARY KEY ("CODICE") ENABLE;
 
  ALTER TABLE "PARCHEGGIO"."SOSTA" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table UTENTE
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."UTENTE" MODIFY ("NOME" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."UTENTE" MODIFY ("COGNOME" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."UTENTE" MODIFY ("ANNO_NASCITA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."UTENTE" MODIFY ("NUMERO_PATENTE" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."UTENTE" ADD PRIMARY KEY ("CF") ENABLE;
 
  ALTER TABLE "PARCHEGGIO"."UTENTE" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table UTENTEPREMIUM
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."UTENTEPREMIUM" MODIFY ("NICKNAME" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."UTENTEPREMIUM" MODIFY ("PASSWD" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."UTENTEPREMIUM" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table SENSORE
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."SENSORE" MODIFY ("MODELLO" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."SENSORE" MODIFY ("AZIENDA" NOT NULL ENABLE);
 
  ALTER TABLE "PARCHEGGIO"."SENSORE" ADD PRIMARY KEY ("CODICE") ENABLE;
 
  ALTER TABLE "PARCHEGGIO"."SENSORE" ADD UNIQUE ("SYS_NC_OID$") ENABLE;



--------------------------------------------------------
--  Ref Constraints for Table POSTOAUTO
--------------------------------------------------------

  ALTER TABLE "PARCHEGGIO"."POSTOAUTO" ADD CONSTRAINT "PA_FK1" FOREIGN KEY ("PPC")
	  REFERENCES "PARCHEGGIO"."PPC" ("NOME") ENABLE;






--------------------------------------------------------
--  DDL for Trigger AGGIORNADIPENDENZEUTENTE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PARCHEGGIO"."AGGIORNADIPENDENZEUTENTE" 
after delete on utente
for each row
BEGIN
DECLARE
n number;
BEGIN
SELECT COUNT(*) INTO n FROM utenteabbonato WHERE cf = :old.cf;
IF (n>0) then 
  DELETE from utenteabbonato WHERE cf = :old.cf;
END IF;
SELECT COUNT(*) INTO n FROM utentepremium WHERE cf = :old.cf;
IF (n>0) then
  DELETE from utentepremium WHERE cf = :old.cf;
END IF;
END;
END;
/
ALTER TRIGGER "PARCHEGGIO"."AGGIORNADIPENDENZEUTENTE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AGGIORNATABELLAUTENTE1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PARCHEGGIO"."AGGIORNATABELLAUTENTE1" 
after insert on utentepremium
for each row
BEGIN
INSERT INTO UTENTE VALUES(:new.cf,:new.nome,:new.cognome,:new.anno_nascita,:new.numero_patente);
END;
/
ALTER TRIGGER "PARCHEGGIO"."AGGIORNATABELLAUTENTE1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AGGIORNATABELLAUTENTE2
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PARCHEGGIO"."AGGIORNATABELLAUTENTE2" 
after insert on utenteabbonato
for each row
BEGIN
INSERT INTO UTENTE VALUES(:new.cf,:new.nome,:new.cognome,:new.anno_nascita,:new.numero_patente);
END;
/
ALTER TRIGGER "PARCHEGGIO"."AGGIORNATABELLAUTENTE2" ENABLE;
--------------------------------------------------------
--  DDL for Trigger CALCOLACOSTOSOSTA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PARCHEGGIO"."CALCOLACOSTOSOSTA" 
after insert on sosta
BEGIN 
update sosta s set costo = s.calcolacosto() where codice = codice;
END;

/
ALTER TRIGGER "PARCHEGGIO"."CALCOLACOSTOSOSTA" ENABLE;
--------------------------------------------------------
--  DDL for Procedure ACQUISTAPASS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."ACQUISTAPASS" (ppc_nome ppc.nome%TYPE, utente_cf utente.cf%TYPE, dataScadenza pass.scadenza%TYPE, nomezona pass.nomeZona%TYPE, targaauto pass.targaAuto%TYPE) IS
BEGIN
DECLARE
utente_nome utente.nome%TYPE;
BEGIN
SELECT nome INTO utente_nome FROM utente u WHERE u.cf = utente_cf;
INSERT INTO pass select pass_ty(
dbms_random.string('X', 5),
SYSDATE,
dataScadenza,
nomeZona,
targaauto,
ref(p), 
ref(u)) from ppc p,utente u where p.nome = ppc_nome AND u.cf = utente_cf;
dbms_output.put_line('Acquisto pass riuscito');
dbms_output.put_line('Venduto da ppc ' || ppc_nome || ' ad utente ' || utente_nome);
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Acquisto pass non riuscito');
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure CANCELLAUTENTIINATTIVI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."CANCELLAUTENTIINATTIVI" IS
BEGIN
  FOR utenti IN (SELECT deref(utente).cf AS cf FROM sosta WHERE datafine<sysdate-(30*6))
  LOOP
    delete from pass WHERE deref(utente).cf = utenti.cf;
    delete from sosta WHERE deref(utente).cf = utenti.cf;
    delete from utente where cf = utenti.cf;
  END LOOP;
END;

/

--------------------------------------------------------
--  DDL for Procedure INSERISCIPPC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."INSERISCIPPC" (nome PPC.nome%TYPE, via PPC.via%TYPE,
lat ppc.latitudine%TYPE, lon ppc.longitudine%TYPE, tel ppc.telefono%TYPE, 
mail ppc.mail%TYPE, soc ppc.società%TYPE, posti ppc.postiauto%TYPE) IS
BEGIN 
INSERT INTO PPC VALUES(nome, via, lat, lon, tel, mail, soc, posti);
dbms_output.put_line('PPC correttamente inserito');
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('PPC non inserito');
END;

/

--------------------------------------------------------
--  DDL for Procedure INSERISCISOSTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."INSERISCISOSTA" (dataI sosta.datainizio%TYPE,
dataF sosta.datafine%TYPE, costo sosta.costo%TYPE, targaauto sosta.targaauto%TYPE, ppc_nome ppc.nome%TYPE, utente_cf utente.cf%TYPE) IS
BEGIN
INSERT INTO sosta select sosta_ty(
dbms_random.string('X',5),
dataI,
dataF,
costo,
targaauto,
ref(p), 
ref(u)) from ppc p,utente u where p.nome = ppc_nome AND u.cf = utente_cf;
dbms_output.put_line('Sosta correttamente inserita');
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Sosta non inserita');
END;

/

--------------------------------------------------------
--  DDL for Procedure INSERISCIUTENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."INSERISCIUTENTE" (cf utente.cf%TYPE, nome utente.nome%TYPE,
cognome utente.cognome%TYPE, annoNasc utente.anno_nascita%TYPE, numPat utente.numero_patente%TYPE) IS
BEGIN 
INSERT INTO utente VALUES(cf, nome, cognome, annoNasc, numPat);
dbms_output.put_line('Utente correttamente registrato');
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Utente non registrato');
END;

/

--------------------------------------------------------
--  DDL for Procedure MODIFICAPPCSENSORI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."MODIFICAPPCSENSORI" (nome ppc.nome%TYPE, sensoreCod sensore.codice%TYPE) IS
BEGIN
DECLARE 
n number;
m number;
BEGIN
n := 0;
SELECT count(*) INTO m FROM postoauto pa WHERE pa.ppc = nome;
WHILE n < m LOOP
update postoauto p set sensore = (SELECT ref(s) FROM sensore s WHERE s.codice = sensoreCod ) WHERE p.ppc = nome;
n := n + 1;
END LOOP;
dbms_output.put_line('Modifiche correttamente avvenute');
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Modifiche non riuscite');
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure POPOLAPASS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."POPOLAPASS" IS
BEGIN
DECLARE
n NUMBER;
ppc ref ppc_ty;
ppc_nome VARCHAR2(30);
utente ref utente_ty;
utente_cf VARCHAR2(16);
d date;
BEGIN
n := 0;
WHILE n < 10 LOOP
  SELECT nome INTO ppc_nome FROM (SELECT * FROM  ppc ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum<2;
  SELECT cf INTO utente_cf FROM (SELECT * FROM  utente ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum<2;
  d := TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J'),TO_CHAR(DATE '9999-12-31','J'))),'J');
INSERT INTO pass select pass_ty(
dbms_random.string('X', 5),
d,
d + 60,
dbms_random.string('L', 15),
dbms_random.string('X', 7),
ref(p), 
ref(u)) from ppc p,utente u where p.nome = ppc_nome AND u.cf = utente_cf;
n := n + 1;
END LOOP;
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure POPOLAPOSTOAUTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."POPOLAPOSTOAUTO" IS
BEGIN
DECLARE
n NUMBER;
m NUMBER;
ppc_nome VARCHAR2(30);
sensore ref utente_ty;
sensore_codice VARCHAR2(16);
BEGIN
n := 0;
WHILE n < 10 LOOP
  SELECT nome INTO ppc_nome FROM (SELECT * FROM  ppc ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum<2;
  SELECT codice INTO sensore_codice FROM (SELECT * FROM  sensore ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum<2;
  SELECT count(*) INTO m FROM postoauto WHERE ppc = ppc_nome;
INSERT INTO postoauto select postoauto_ty(
m+1,
round(dbms_random.value(3,5)),
round(dbms_random.value(3,5)),
'1',
ppc_nome,
ref(s)) from sensore s where s.codice = sensore_codice;
n := n + 1;
END LOOP;
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure POPOLAPPC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."POPOLAPPC" IS
BEGIN
DECLARE
n NUMBER;
BEGIN
n := 0;
WHILE n < 100 LOOP
INSERT INTO ppc VALUES(
  ppc_ty(dbms_random.string('U', 10), dbms_random.string('L',15), 
  round(dbms_random.value(1, 100),2),round(dbms_random.value(1, 100),2), 
  round(dbms_random.value(1,99999999)), dbms_random.string('L',15), dbms_random.string('L',15), 
  round(dbms_random.value(50,150))));
n := n + 1;
END LOOP;
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure POPOLASENSORE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."POPOLASENSORE" IS
BEGIN
DECLARE
n NUMBER;
BEGIN
n := 0;
WHILE n < 50 LOOP
INSERT INTO Sensore VALUES(
  sensore_ty(dbms_random.string('X', 5), dbms_random.string('L',15), dbms_random.string('L',15)));
n := n + 1;
END LOOP;
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure POPOLASOSTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."POPOLASOSTA" IS
BEGIN
DECLARE
n NUMBER;
ppc ref ppc_ty;
ppc_nome VARCHAR2(30);
utente ref utente_ty;
utente_cf VARCHAR2(16);
d date;
BEGIN
n := 0;
WHILE n < 10 LOOP
  SELECT nome INTO ppc_nome FROM (SELECT * FROM  ppc ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum<2;
  SELECT cf INTO utente_cf FROM (SELECT * FROM  utente ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum<2;
  d := TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '1900-01-01','J'),TO_CHAR(DATE '2017-12-31','J'))),'J');
INSERT INTO sosta select sosta_ty(
dbms_random.string('X', 8),
d,
d + 0.25,
0, 
dbms_random.string('X', 7),
ref(p), 
ref(u)) from ppc p,utente u where p.nome = ppc_nome AND u.cf = utente_cf;
n := n + 1;
END LOOP;
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure POPOLAUTENTEABBONATO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."POPOLAUTENTEABBONATO" IS
BEGIN
DECLARE
n NUMBER;
BEGIN
n := 0;
WHILE n < 300 LOOP
INSERT INTO UtenteAbbonato VALUES(
  utenteabbonato_ty(dbms_random.string('X', 16), dbms_random.string('L',8), dbms_random.string('L',8),
  round(dbms_random.value(1930, 1999)), dbms_random.string('X', 15)));
n := n + 1;
END LOOP;
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure POPOLAUTENTEPREMIUM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."POPOLAUTENTEPREMIUM" IS
BEGIN
DECLARE
n NUMBER;
BEGIN
n := 0;
WHILE n < 5 LOOP
INSERT INTO UtentePremium VALUES(
  utentepremium_ty(dbms_random.string('X', 16), dbms_random.string('L',8), dbms_random.string('L',8),
  round(dbms_random.value(1930, 1999)), dbms_random.string('X', 15), dbms_random.string('L',8), dbms_random.string('L',8)));
n := n + 1;
END LOOP;
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure STAMPAGUADAGNOGIORNALIEROPPC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."STAMPAGUADAGNOGIORNALIEROPPC" (nome ppc.nome%TYPE, dataF sosta.datafine%TYPE) IS
BEGIN
DECLARE 
n number;
BEGIN
SELECT sum(costo) INTO n FROM sosta s WHERE deref(s.ppc).nome = nome AND s.dataFine like dataF;
dbms_output.put_line('Guadagno ppc ' || nome || ' in data ' || to_date(dataF,'DD-Mon-YY') || ' uguale a ' || n);
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Stampa non riuscita');
END;
END;

/

--------------------------------------------------------
--  DDL for Procedure STAMPAPOSTIDISPONIBILIPPC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PARCHEGGIO"."STAMPAPOSTIDISPONIBILIPPC" (nome ppc.nome%TYPE) IS
BEGIN
DECLARE 
n number;
BEGIN
SELECT count(*) INTO n FROM postoauto p WHERE p.ppc = nome AND libero = '1';
dbms_output.put_line('Posti disponibili nel ppc ' || nome || ' : ' || n); 
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Stampa non riuscita');
END;
END;

/


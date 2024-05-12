-- 
--                                         				                                   
--        		               
--                                        					                                   
-- 
--  																		     
--    Nazwisko i imię Jakub Mazurek
--  																		     
-- 
--  																		     
--    
--  																		     
-- 
-- 
--  																		     
--    Temat projektu Motel
--  																		     
-- 




-- -------------------------------------------------------------------------------
-- TWORZENIE STRUKTURY BAZY DANYCH                                            
-- -------------------------------------------------------------------------------


-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at        2024-03-26 153722 CET
--   site      Oracle Database 11g
--   type      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE


CREATE TABLE klienci (
    klient_id    NUMBER(5) NOT NULL,
    imie         VARCHAR2(255),
    nazwisko     VARCHAR2(255),
    miasto       VARCHAR2(255),
    ulica        VARCHAR2(255),
    kod_pocztowy VARCHAR2(6),
    nr_budynku   VARCHAR2(5),
    nr_lokalu    VARCHAR2(5),
    email        VARCHAR2(255),
    telefon      VARCHAR2(30)
);

ALTER TABLE klienci ADD CONSTRAINT hale_sportowe_pk PRIMARY KEY ( klient_id );

CREATE TABLE miejsca_parkingowe (
    miejsce_parkingowe_id        NUMBER(2) NOT NULL,
    miejsce_parkingowe_rodzaj_id NUMBER(2) NOT NULL,
    ozn                          VARCHAR2(255),
    cena_netto                   NUMBER(6, 2),
    cena_brutto                  NUMBER(6, 2)
);

COMMENT ON COLUMN miejsca_parkingowe.ozn IS
    'kuchniaaneks kuchenny

prywatna łazienka

widok na morze

balkon

klimatyzacja

pralka

lodówka

prywatny basen

kuchnia

łóżka  łóżeczka dla dzieci

taras

itp';

ALTER TABLE miejsca_parkingowe ADD CONSTRAINT stanowiskav1_pk PRIMARY KEY ( miejsce_parkingowe_id );

CREATE TABLE miejsca_parkingowe_rodzaje (
    miejsce_parkingowe_rodzaj_id NUMBER(2) NOT NULL,
    nazwa                        VARCHAR2(255)
);

COMMENT ON COLUMN miejsca_parkingowe_rodzaje.nazwa IS
    'auto osobowe
autobus
osoby niepełnosprawne
motor
';

ALTER TABLE miejsca_parkingowe_rodzaje ADD CONSTRAINT miejsca_parkingowev1_pk PRIMARY KEY ( miejsce_parkingowe_rodzaj_id );

CREATE TABLE platnosci (
    platnosc_id      NUMBER(10) NOT NULL,
    klient_id        NUMBER(5) NOT NULL,
    rezerwacja_id    NUMBER(10),
    kwota_brutto     NUMBER(7, 2),
    data_wplaty      DATE,
    data_ksiegowania DATE
);

ALTER TABLE platnosci ADD CONSTRAINT platnosci_pk PRIMARY KEY ( platnosc_id );

CREATE TABLE pokoje (
    pokoj_id    NUMBER(4) NOT NULL,
    numer       VARCHAR2(4),
    pietro      NUMBER(2),
    ile_osob    NUMBER(2),
    cena_netto  NUMBER(6, 2),
    cena_brutto NUMBER(6, 2)
);

ALTER TABLE pokoje ADD CONSTRAINT pokoje_pk PRIMARY KEY ( pokoj_id );

CREATE TABLE pokoje_udogodnienia (
    pokoje_pokoj_id              NUMBER(4) NOT NULL,
    udogodnienia_udogodnienie_id NUMBER(2) NOT NULL
);

ALTER TABLE pokoje_udogodnienia ADD CONSTRAINT pokoje_udogodnienia_pk PRIMARY KEY ( udogodnienia_udogodnienie_id,
                                                                                    pokoje_pokoj_id );

CREATE TABLE pracownicy (
    pracownik_id      NUMBER(5) NOT NULL,
    imie              VARCHAR2(255),
    nazwisko          VARCHAR2(255),
    email             VARCHAR2(255),
    telefon           VARCHAR2(30),
    data_zatrudnienia DATE,
    data_zwolnienia   DATE
);

ALTER TABLE pracownicy ADD CONSTRAINT klienciv1_pk PRIMARY KEY ( pracownik_id );

CREATE TABLE pracownicy_harmonogram (
    pracownik_harmonogram_id NUMBER(10),
    data                     DATE,
    pracownik_id             NUMBER(5) NOT NULL,
    zmina_id                 NUMBER(4) NOT NULL
);

CREATE TABLE pracownicy_stanowiska (
    stanowisko_id    NUMBER(2) NOT NULL,
    pracownik_id     NUMBER(5) NOT NULL,
    data_rozpoczecia DATE NOT NULL,
    data_zakonczenia DATE
);

ALTER TABLE pracownicy_stanowiska
    ADD CONSTRAINT pracownicy_stanowiska_pk PRIMARY KEY ( stanowisko_id,
                                                          pracownik_id,
                                                          data_rozpoczecia );

CREATE TABLE rezerwacja_parkingi (
    rezerwacja_parking_id NUMBER(10) NOT NULL,
    rezerwacja_id         NUMBER(10) NOT NULL,
    miejsca_parkingowe_id NUMBER(2) NOT NULL,
    cena_netto            NUMBER(6, 2),
    cena_brutto           NUMBER(6, 2),
    data_rozpoczecia      DATE,
    data_zakonczenia      DATE
);

ALTER TABLE rezerwacja_parkingi ADD CONSTRAINT rezerwacja_parkingi_pk PRIMARY KEY ( rezerwacja_parking_id );

CREATE TABLE rezerwacje (
    rezerwacja_id        NUMBER(10) NOT NULL,
    klient_id            NUMBER(5) NOT NULL,
    pracownik_id         NUMBER(5) NOT NULL,
    rezerwacja_status_id NUMBER(2) NOT NULL,
    data_utworzenia      DATE,
    data_rozpoczecia     DATE,
    data_zakonczenia     DATE,
    koszt_netto          NUMBER(6, 2),
    koszt_brutto         NUMBER(6, 2),
    czas_zameldowania    TIMESTAMP WITH LOCAL TIME ZONE,
    czas_wymeldowania    TIMESTAMP WITH LOCAL TIME ZONE
);

ALTER TABLE rezerwacje ADD CONSTRAINT rezerwacje_pk PRIMARY KEY ( rezerwacja_id );

CREATE TABLE rezerwacje_statusy (
    rezerwacja_status_id NUMBER(2) NOT NULL,
    nazwa                VARCHAR2(255)
);

COMMENT ON COLUMN rezerwacje_statusy.nazwa IS
    'kuchniaaneks kuchenny

prywatna łazienka

widok na morze

balkon

klimatyzacja

pralka

lodówka

prywatny basen

kuchnia

łóżka  łóżeczka dla dzieci

taras

itp';

ALTER TABLE rezerwacje_statusy ADD CONSTRAINT udogodnieniav1_pkv1 PRIMARY KEY ( rezerwacja_status_id );

CREATE TABLE rezerwacje_szczegoly (
    rezerwacja_szczegol_id   NUMBER(10) NOT NULL,
    rezerwacje_rezerwacja_id NUMBER(10) NOT NULL,
    pokoje_pokoj_id          NUMBER(4) NOT NULL,
    koszt_netto              NUMBER(6, 2),
    koszt_brutto             NUMBER(6, 2)
);

ALTER TABLE rezerwacje_szczegoly ADD CONSTRAINT rezerwacje_szczegoly_pk PRIMARY KEY ( rezerwacja_szczegol_id );

CREATE TABLE rezerwacje_uslugi (
    rezerwacja_usluga_id   NUMBER(8) NOT NULL,
    rezerwacja_id          NUMBER(10) NOT NULL,
    rezerwacja_szczegol_id NUMBER(10) NOT NULL,
    usluga_id              NUMBER(2) NOT NULL,
    cena_netto             NUMBER(6, 2),
    cena_brutto            NUMBER(6, 2)
);

ALTER TABLE rezerwacje_uslugi ADD CONSTRAINT rezerwacje_uslugi_pk PRIMARY KEY ( rezerwacja_usluga_id );

CREATE TABLE stanowiska (
    stanowisko_id NUMBER(2) NOT NULL,
    nazwa         VARCHAR2(255)
);

COMMENT ON COLUMN stanowiska.nazwa IS
    'kuchniaaneks kuchenny

prywatna łazienka

widok na morze

balkon

klimatyzacja

pralka

lodówka

prywatny basen

kuchnia

łóżka  łóżeczka dla dzieci

taras

itp';

ALTER TABLE stanowiska ADD CONSTRAINT udogodnieniav1_pk PRIMARY KEY ( stanowisko_id );

CREATE TABLE udogodnienia (
    udogodnienie_id NUMBER(2) NOT NULL,
    nazwa           VARCHAR2(255)
);

COMMENT ON COLUMN udogodnienia.nazwa IS
    'kuchniaaneks kuchenny

prywatna łazienka

widok na morze

balkon

klimatyzacja

pralka

lodówka

prywatny basen

kuchnia

łóżka  łóżeczka dla dzieci

taras

itp';

ALTER TABLE udogodnienia ADD CONSTRAINT udogodnienia_pk PRIMARY KEY ( udogodnienie_id );

CREATE TABLE uslugi (
    usluga_id   NUMBER(2) NOT NULL,
    nazwa       VARCHAR2(255),
    cena_netto  NUMBER(6, 2),
    cena_brutto NUMBER(6, 2)
);

COMMENT ON COLUMN uslugi.nazwa IS
    'kuchniaaneks kuchenny

prywatna łazienka

widok na morze

balkon

klimatyzacja

pralka

lodówka

prywatny basen

kuchnia

łóżka  łóżeczka dla dzieci

taras

itp';

ALTER TABLE uslugi ADD CONSTRAINT udogodnieniav1_pkv2 PRIMARY KEY ( usluga_id );

CREATE TABLE zmiany (
    zmina_id            NUMBER(4) NOT NULL,
    godzina_rozpoczecia VARCHAR2(5),
    godzina_zakonczenia VARCHAR2(5)
);

ALTER TABLE zmiany ADD CONSTRAINT zmiany_pk PRIMARY KEY ( zmina_id );

ALTER TABLE pracownicy_harmonogram
    ADD CONSTRAINT harmonogram_pracownicy_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownicy ( pracownik_id );

ALTER TABLE pracownicy_harmonogram
    ADD CONSTRAINT harmonogram_zmiany_fk FOREIGN KEY ( zmina_id )
        REFERENCES zmiany ( zmina_id );

ALTER TABLE miejsca_parkingowe
    ADD CONSTRAINT miejsca_parkingowe_rodzaje_fk FOREIGN KEY ( miejsce_parkingowe_rodzaj_id )
        REFERENCES miejsca_parkingowe_rodzaje ( miejsce_parkingowe_rodzaj_id );

ALTER TABLE rezerwacja_parkingi
    ADD CONSTRAINT parkingi_miejsca_parkingowe_fk FOREIGN KEY ( miejsca_parkingowe_id )
        REFERENCES miejsca_parkingowe ( miejsce_parkingowe_id );

ALTER TABLE rezerwacja_parkingi
    ADD CONSTRAINT parkingi_rezerwacje_fk FOREIGN KEY ( rezerwacja_id )
        REFERENCES rezerwacje ( rezerwacja_id );

ALTER TABLE platnosci
    ADD CONSTRAINT platnosci_klienci_fk FOREIGN KEY ( klient_id )
        REFERENCES klienci ( klient_id );

ALTER TABLE platnosci
    ADD CONSTRAINT platnosci_rezerwacje_fk FOREIGN KEY ( rezerwacja_id )
        REFERENCES rezerwacje ( rezerwacja_id );

ALTER TABLE pokoje_udogodnienia
    ADD CONSTRAINT pokoje_udogodnienia_fk FOREIGN KEY ( udogodnienia_udogodnienie_id )
        REFERENCES udogodnienia ( udogodnienie_id );

ALTER TABLE pokoje_udogodnienia
    ADD CONSTRAINT pokoje_udogodnienia_pokoje_fk FOREIGN KEY ( pokoje_pokoj_id )
        REFERENCES pokoje ( pokoj_id );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_klienci_fk FOREIGN KEY ( klient_id )
        REFERENCES klienci ( klient_id );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_pracownicy_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownicy ( pracownik_id );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_statusy_fk FOREIGN KEY ( rezerwacja_status_id )
        REFERENCES rezerwacje_statusy ( rezerwacja_status_id );

ALTER TABLE rezerwacje_uslugi
    ADD CONSTRAINT rezerwacje_szczegoly_fk FOREIGN KEY ( rezerwacja_szczegol_id )
        REFERENCES rezerwacje_szczegoly ( rezerwacja_szczegol_id );

ALTER TABLE rezerwacje_uslugi
    ADD CONSTRAINT rezerwacje_uslugi_fk FOREIGN KEY ( usluga_id )
        REFERENCES uslugi ( usluga_id );

ALTER TABLE pracownicy_stanowiska
    ADD CONSTRAINT stanowiska_pracownicy_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownicy ( pracownik_id );

ALTER TABLE pracownicy_stanowiska
    ADD CONSTRAINT stanowiska_stanowiska_fk FOREIGN KEY ( stanowisko_id )
        REFERENCES stanowiska ( stanowisko_id );

ALTER TABLE rezerwacje_szczegoly
    ADD CONSTRAINT szczegoly_pokoje_fk FOREIGN KEY ( pokoje_pokoj_id )
        REFERENCES pokoje ( pokoj_id );

ALTER TABLE rezerwacje_szczegoly
    ADD CONSTRAINT szczegoly_rezerwacje_fk FOREIGN KEY ( rezerwacje_rezerwacja_id )
        REFERENCES rezerwacje ( rezerwacja_id );

ALTER TABLE rezerwacje_uslugi
    ADD CONSTRAINT uslugi_rezerwacje_fk FOREIGN KEY ( rezerwacja_id )
        REFERENCES rezerwacje ( rezerwacja_id );

CREATE SEQUENCE klienci_klient_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER klienci_klient_id_trg BEFORE
    INSERT ON klienci
    FOR EACH ROW
    WHEN ( new.klient_id IS NULL )
BEGIN
    :new.klient_id := klienci_klient_id_seq.nextval;
END;
/

CREATE SEQUENCE miejsca_parkingowe_miejsce_par START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER miejsca_parkingowe_miejsce_par BEFORE
    INSERT ON miejsca_parkingowe
    FOR EACH ROW
    WHEN ( new.miejsce_parkingowe_id IS NULL )
BEGIN
    :new.miejsce_parkingowe_id := miejsca_parkingowe_miejsce_par.nextval;
END;
/

CREATE SEQUENCE miejsca_parkingowe_rodzaje_mie START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER miejsca_parkingowe_rodzaje_mie BEFORE
    INSERT ON miejsca_parkingowe_rodzaje
    FOR EACH ROW
    WHEN ( new.miejsce_parkingowe_rodzaj_id IS NULL )
BEGIN
    :new.miejsce_parkingowe_rodzaj_id := miejsca_parkingowe_rodzaje_mie.nextval;
END;
/

CREATE SEQUENCE platnosci_platnosc_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER platnosci_platnosc_id_trg BEFORE
    INSERT ON platnosci
    FOR EACH ROW
    WHEN ( new.platnosc_id IS NULL )
BEGIN
    :new.platnosc_id := platnosci_platnosc_id_seq.nextval;
END;
/

CREATE SEQUENCE pokoje_pokoj_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pokoje_pokoj_id_trg BEFORE
    INSERT ON pokoje
    FOR EACH ROW
    WHEN ( new.pokoj_id IS NULL )
BEGIN
    :new.pokoj_id := pokoje_pokoj_id_seq.nextval;
END;
/

CREATE SEQUENCE pokoje_udogodnienia_pokoje_pok START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pokoje_udogodnienia_pokoje_pok BEFORE
    INSERT ON pokoje_udogodnienia
    FOR EACH ROW
    WHEN ( new.pokoje_pokoj_id IS NULL )
BEGIN
    :new.pokoje_pokoj_id := pokoje_udogodnienia_pokoje_pok.nextval;
END;
/

CREATE SEQUENCE pracownicy_pracownik_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownicy_pracownik_id_trg BEFORE
    INSERT ON pracownicy
    FOR EACH ROW
    WHEN ( new.pracownik_id IS NULL )
BEGIN
    :new.pracownik_id := pracownicy_pracownik_id_seq.nextval;
END;
/

CREATE SEQUENCE pracownicy_harmonogram_pracown START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownicy_harmonogram_pracown BEFORE
    INSERT ON pracownicy_harmonogram
    FOR EACH ROW
    WHEN ( new.pracownik_harmonogram_id IS NULL )
BEGIN
    :new.pracownik_harmonogram_id := pracownicy_harmonogram_pracown.nextval;
END;
/

CREATE SEQUENCE pracownicy_stanowiska_stanowis START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownicy_stanowiska_stanowis BEFORE
    INSERT ON pracownicy_stanowiska
    FOR EACH ROW
    WHEN ( new.stanowisko_id IS NULL )
BEGIN
    :new.stanowisko_id := pracownicy_stanowiska_stanowis.nextval;
END;
/

CREATE SEQUENCE rezerwacja_parkingi_rezerwacja START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER rezerwacja_parkingi_rezerwacja BEFORE
    INSERT ON rezerwacja_parkingi
    FOR EACH ROW
    WHEN ( new.rezerwacja_parking_id IS NULL )
BEGIN
    :new.rezerwacja_parking_id := rezerwacja_parkingi_rezerwacja.nextval;
END;
/

CREATE SEQUENCE rezerwacje_rezerwacja_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER rezerwacje_rezerwacja_id_trg BEFORE
    INSERT ON rezerwacje
    FOR EACH ROW
    WHEN ( new.rezerwacja_id IS NULL )
BEGIN
    :new.rezerwacja_id := rezerwacje_rezerwacja_id_seq.nextval;
END;
/

CREATE SEQUENCE rezerwacje_statusy_rezerwacja_ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER rezerwacje_statusy_rezerwacja_ BEFORE
    INSERT ON rezerwacje_statusy
    FOR EACH ROW
    WHEN ( new.rezerwacja_status_id IS NULL )
BEGIN
    :new.rezerwacja_status_id := rezerwacje_statusy_rezerwacja_.nextval;
END;
/

CREATE SEQUENCE rezerwacje_szczegoly_rezerwacj START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER rezerwacje_szczegoly_rezerwacj BEFORE
    INSERT ON rezerwacje_szczegoly
    FOR EACH ROW
    WHEN ( new.rezerwacja_szczegol_id IS NULL )
BEGIN
    :new.rezerwacja_szczegol_id := rezerwacje_szczegoly_rezerwacj.nextval;
END;
/

CREATE SEQUENCE rezerwacje_uslugi_rezerwacja_u START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER rezerwacje_uslugi_rezerwacja_u BEFORE
    INSERT ON rezerwacje_uslugi
    FOR EACH ROW
    WHEN ( new.rezerwacja_usluga_id IS NULL )
BEGIN
    :new.rezerwacja_usluga_id := rezerwacje_uslugi_rezerwacja_u.nextval;
END;
/

CREATE SEQUENCE stanowiska_stanowisko_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER stanowiska_stanowisko_id_trg BEFORE
    INSERT ON stanowiska
    FOR EACH ROW
    WHEN ( new.stanowisko_id IS NULL )
BEGIN
    :new.stanowisko_id := stanowiska_stanowisko_id_seq.nextval;
END;
/

CREATE SEQUENCE udogodnienia_udogodnienie_id START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER udogodnienia_udogodnienie_id BEFORE
    INSERT ON udogodnienia
    FOR EACH ROW
    WHEN ( new.udogodnienie_id IS NULL )
BEGIN
    :new.udogodnienie_id := udogodnienia_udogodnienie_id.nextval;
END;
/

CREATE SEQUENCE uslugi_usluga_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER uslugi_usluga_id_trg BEFORE
    INSERT ON uslugi
    FOR EACH ROW
    WHEN ( new.usluga_id IS NULL )
BEGIN
    :new.usluga_id := uslugi_usluga_id_seq.nextval;
END;
/

CREATE SEQUENCE zmiany_zmina_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER zmiany_zmina_id_trg BEFORE
    INSERT ON zmiany
    FOR EACH ROW
    WHEN ( new.zmina_id IS NULL )
BEGIN
    :new.zmina_id := zmiany_zmina_id_seq.nextval;
END;
/




-- -------------------------------------------------------------------------------
-- POLECENIA   5 X INSERT  DO WSZYSTKICH TABEL                                               
-- -------------------------------------------------------------------------------


INSERT INTO udogodnienia (udogodnienie_id, nazwa) VALUES (1, 'kuchniaaneks kuchenny');
INSERT INTO udogodnienia (udogodnienie_id, nazwa) VALUES (2, 'prywatna łazienka');
INSERT INTO udogodnienia (udogodnienie_id, nazwa) VALUES (3, 'widok na morze');
INSERT INTO udogodnienia (udogodnienie_id, nazwa) VALUES (4, 'balkon');
INSERT INTO udogodnienia (udogodnienie_id, nazwa) VALUES (5, 'klimatyzacja');


INSERT INTO miejsca_parkingowe_rodzaje (miejsce_parkingowe_rodzaj_id, nazwa) VALUES (1, 'inne');
INSERT INTO miejsca_parkingowe_rodzaje (miejsce_parkingowe_rodzaj_id, nazwa) VALUES (2, 'przyczepa kempingowa');
INSERT INTO miejsca_parkingowe_rodzaje (miejsce_parkingowe_rodzaj_id, nazwa) VALUES (3, 'rower');
INSERT INTO miejsca_parkingowe_rodzaje (miejsce_parkingowe_rodzaj_id, nazwa) VALUES (4, 'motorower');
INSERT INTO miejsca_parkingowe_rodzaje (miejsce_parkingowe_rodzaj_id, nazwa) VALUES (5, 'inne pojazdy');


INSERT INTO klienci (klient_id, imie, nazwisko, miasto, ulica, kod_pocztowy, nr_budynku, nr_lokalu, email, telefon) 
VALUES (1, 'Jan', 'Kowalski', 'Warszawa', 'Kwiatowa', '00-001', '10', NULL, 'jan.kowalski@example.com', '123456789');
INSERT INTO klienci (klient_id, imie, nazwisko, miasto, ulica, kod_pocztowy, nr_budynku, nr_lokalu, email, telefon) 
VALUES (2, 'Anna', 'Nowak', 'Kraków', 'Miodowa', '30-002', '5', '3', 'anna.nowak@example.com', '987654321');
INSERT INTO klienci (klient_id, imie, nazwisko, miasto, ulica, kod_pocztowy, nr_budynku, nr_lokalu, email, telefon) 
VALUES (3, 'Piotr', 'Wiśniewski', 'Gdańsk', 'Słoneczna', '80-003', '8', NULL, 'piotr.wisniewski@example.com', '111222333');
INSERT INTO klienci (klient_id, imie, nazwisko, miasto, ulica, kod_pocztowy, nr_budynku, nr_lokalu, email, telefon) 
VALUES (4, 'Maria', 'Dąbrowska', 'Poznań', 'Żurawia', '60-004', '20', NULL, 'maria.dabrowska@example.com', '444555666');
INSERT INTO klienci (klient_id, imie, nazwisko, miasto, ulica, kod_pocztowy, nr_budynku, nr_lokalu, email, telefon) 
VALUES (5, 'Adam', 'Lis', 'Wrocław', 'Lipowa', '50-005', '3', '5', 'adam.lis@example.com', '777888999');

INSERT INTO pracownicy (pracownik_id, imie, nazwisko, email, telefon, data_zatrudnienia, data_zwolnienia) 
VALUES (1, 'Jan', 'Kowalski', 'jan.kowalski@example.com', '111222333', TO_DATE('2024-03-01', 'YYYY-MM-DD'), NULL);
INSERT INTO pracownicy (pracownik_id, imie, nazwisko, email, telefon, data_zatrudnienia, data_zwolnienia) 
VALUES (2, 'Anna', 'Nowak', 'anna.nowak@example.com', '222333444', TO_DATE('2024-03-02', 'YYYY-MM-DD'), NULL);
INSERT INTO pracownicy (pracownik_id, imie, nazwisko, email, telefon, data_zatrudnienia, data_zwolnienia) 
VALUES (3, 'Piotr', 'Wiśniewski', 'piotr.wisniewski@example.com', '333444555', TO_DATE('2024-03-03', 'YYYY-MM-DD'), NULL);
INSERT INTO pracownicy (pracownik_id, imie, nazwisko, email, telefon, data_zatrudnienia, data_zwolnienia) 
VALUES (4, 'Maria', 'Dąbrowska', 'maria.dabrowska@example.com', '444555666', TO_DATE('2024-03-04', 'YYYY-MM-DD'), NULL);
INSERT INTO pracownicy (pracownik_id, imie, nazwisko, email, telefon, data_zatrudnienia, data_zwolnienia) 
VALUES (5, 'Adam', 'Lis', 'adam.lis@example.com', '555666777', TO_DATE('2024-03-05', 'YYYY-MM-DD'), NULL);

INSERT INTO stanowiska (stanowisko_id, nazwa) VALUES (1, 'Recepcjonista');
INSERT INTO stanowiska (stanowisko_id, nazwa) VALUES (2, 'Sprzątacz');
INSERT INTO stanowiska (stanowisko_id, nazwa) VALUES (3, 'Kucharz');
INSERT INTO stanowiska (stanowisko_id, nazwa) VALUES (4, 'Kelner');
INSERT INTO stanowiska (stanowisko_id, nazwa) VALUES (5, 'Manager');

INSERT INTO rezerwacje_statusy (rezerwacja_status_id, nazwa) VALUES (1, 'Złożona');
INSERT INTO rezerwacje_statusy (rezerwacja_status_id, nazwa) VALUES (2, 'Potwierdzona');
INSERT INTO rezerwacje_statusy (rezerwacja_status_id, nazwa) VALUES (3, 'Anulowana');
INSERT INTO rezerwacje_statusy (rezerwacja_status_id, nazwa) VALUES (4, 'Zakończona');
INSERT INTO rezerwacje_statusy (rezerwacja_status_id, nazwa) VALUES (5, 'W trakcie');

INSERT INTO zmiany (zmina_id, godzina_rozpoczecia, godzina_zakonczenia) VALUES (1, '0800', '1600');
INSERT INTO zmiany (zmina_id, godzina_rozpoczecia, godzina_zakonczenia) VALUES (2, '1600', '0000');
INSERT INTO zmiany (zmina_id, godzina_rozpoczecia, godzina_zakonczenia) VALUES (3, '0000', '0800');

INSERT INTO uslugi (usluga_id, nazwa, cena_netto, cena_brutto) VALUES (1, 'Śniadanie', 20.00, 24.60);
INSERT INTO uslugi (usluga_id, nazwa, cena_netto, cena_brutto) VALUES (2, 'Basen', 30.00, 36.90);
INSERT INTO uslugi (usluga_id, nazwa, cena_netto, cena_brutto) VALUES (3, 'Siłownia', 40.00, 49.20);
INSERT INTO uslugi (usluga_id, nazwa, cena_netto, cena_brutto) VALUES (4, 'Masaż', 50.00, 61.50);
INSERT INTO uslugi (usluga_id, nazwa, cena_netto, cena_brutto) VALUES (5, 'Sauna', 25.00, 30.75);

INSERT INTO pokoje (pokoj_id, numer, pietro, ile_osob, cena_netto, cena_brutto) VALUES (1, '101', 1, 2, 150.00, 184.50);
INSERT INTO pokoje (pokoj_id, numer, pietro, ile_osob, cena_netto, cena_brutto) VALUES (2, '102', 1, 3, 200.00, 246.00);
INSERT INTO pokoje (pokoj_id, numer, pietro, ile_osob, cena_netto, cena_brutto) VALUES (3, '201', 2, 2, 180.00, 221.40);
INSERT INTO pokoje (pokoj_id, numer, pietro, ile_osob, cena_netto, cena_brutto) VALUES (4, '202', 2, 4, 250.00, 307.50);
INSERT INTO pokoje (pokoj_id, numer, pietro, ile_osob, cena_netto, cena_brutto) VALUES (5, '301', 3, 2, 170.00, 209.10);


INSERT INTO rezerwacje (rezerwacja_id, klient_id, pracownik_id, data_utworzenia, data_rozpoczecia, data_zakonczenia, rezerwacja_status_id, koszt_netto, koszt_brutto, czas_zameldowania, czas_wymeldowania) VALUES (1, 1, 1, TO_DATE('2024-03-26', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'), 1, 500.00, 615.00, TIMESTAMP '2024-04-01 14:00:00', TIMESTAMP '2024-04-05 10:00:00');
INSERT INTO rezerwacje (rezerwacja_id, klient_id, pracownik_id, data_utworzenia, data_rozpoczecia, data_zakonczenia, rezerwacja_status_id, koszt_netto, koszt_brutto, czas_zameldowania, czas_wymeldowania) VALUES (2, 2, 2, TO_DATE('2024-03-27', 'YYYY-MM-DD'), TO_DATE('2024-04-02', 'YYYY-MM-DD'), TO_DATE('2024-04-07', 'YYYY-MM-DD'), 1, 600.00, 738.00, TIMESTAMP '2024-04-02 15:00:00', TIMESTAMP '2024-04-07 11:00:00');
INSERT INTO rezerwacje (rezerwacja_id, klient_id, pracownik_id, data_utworzenia, data_rozpoczecia, data_zakonczenia, rezerwacja_status_id, koszt_netto, koszt_brutto, czas_zameldowania, czas_wymeldowania) VALUES (3, 3, 3, TO_DATE('2024-03-28', 'YYYY-MM-DD'), TO_DATE('2024-04-03', 'YYYY-MM-DD'), TO_DATE('2024-04-09', 'YYYY-MM-DD'), 2, 700.00, 861.00, TIMESTAMP '2024-04-03 12:00:00', TIMESTAMP '2024-04-09 10:30:00');
INSERT INTO rezerwacje (rezerwacja_id, klient_id, pracownik_id, data_utworzenia, data_rozpoczecia, data_zakonczenia, rezerwacja_status_id, koszt_netto, koszt_brutto, czas_zameldowania, czas_wymeldowania) VALUES (4, 4, 4, TO_DATE('2024-03-29', 'YYYY-MM-DD'), TO_DATE('2024-04-04', 'YYYY-MM-DD'), TO_DATE('2024-04-10', 'YYYY-MM-DD'), 2, 550.00, 676.50, TIMESTAMP '2024-04-04 13:30:00', TIMESTAMP '2024-04-10 09:45:00');
INSERT INTO rezerwacje (rezerwacja_id, klient_id, pracownik_id, data_utworzenia, data_rozpoczecia, data_zakonczenia, rezerwacja_status_id, koszt_netto, koszt_brutto, czas_zameldowania, czas_wymeldowania) VALUES (5, 5, 5, TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2024-04-11', 'YYYY-MM-DD'), 3, 450.00, 553.50, TIMESTAMP '2024-04-05 10:00:00', TIMESTAMP '2024-04-11 12:00:00');

INSERT INTO platnosci (platnosc_id, klient_id, rezerwacja_id, kwota_brutto, data_wplaty, data_ksiegowania) VALUES (1, 1, 1, 150.00, TO_DATE('2024-03-26', 'YYYY-MM-DD'), TO_DATE('2024-03-26', 'YYYY-MM-DD'));
INSERT INTO platnosci (platnosc_id, klient_id, rezerwacja_id, kwota_brutto, data_wplaty, data_ksiegowania) VALUES (2, 2, 2, 200.00, TO_DATE('2024-03-27', 'YYYY-MM-DD'), TO_DATE('2024-03-27', 'YYYY-MM-DD'));
INSERT INTO platnosci (platnosc_id, klient_id, rezerwacja_id, kwota_brutto, data_wplaty, data_ksiegowania) VALUES (3, 3, 3, 300.00, TO_DATE('2024-03-28', 'YYYY-MM-DD'), TO_DATE('2024-03-28', 'YYYY-MM-DD'));
INSERT INTO platnosci (platnosc_id, klient_id, rezerwacja_id, kwota_brutto, data_wplaty, data_ksiegowania) VALUES (4, 4, 4, 250.00, TO_DATE('2024-03-29', 'YYYY-MM-DD'), TO_DATE('2024-03-29', 'YYYY-MM-DD'));
INSERT INTO platnosci (platnosc_id, klient_id, rezerwacja_id, kwota_brutto, data_wplaty, data_ksiegowania) VALUES (5, 5, 5, 180.00, TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-03-30', 'YYYY-MM-DD'));

INSERT INTO pracownicy_stanowiska (stanowisko_id, pracownik_id, data_rozpoczecia, data_zakonczenia) VALUES (1, 1, TO_DATE('2024-03-26', 'YYYY-MM-DD'), NULL);
INSERT INTO pracownicy_stanowiska (stanowisko_id, pracownik_id, data_rozpoczecia, data_zakonczenia) VALUES (2, 2, TO_DATE('2024-03-27', 'YYYY-MM-DD'), TO_DATE('2024-03-29', 'YYYY-MM-DD'));
INSERT INTO pracownicy_stanowiska (stanowisko_id, pracownik_id, data_rozpoczecia, data_zakonczenia) VALUES (3, 3, TO_DATE('2024-03-28', 'YYYY-MM-DD'), TO_DATE('2024-03-30', 'YYYY-MM-DD'));
INSERT INTO pracownicy_stanowiska (stanowisko_id, pracownik_id, data_rozpoczecia, data_zakonczenia) VALUES (4, 4, TO_DATE('2024-03-29', 'YYYY-MM-DD'), NULL);
INSERT INTO pracownicy_stanowiska (stanowisko_id, pracownik_id, data_rozpoczecia, data_zakonczenia) VALUES (5, 5, TO_DATE('2024-03-30', 'YYYY-MM-DD'), NULL);

INSERT INTO pracownicy_harmonogram (pracownik_harmonogram_id, data, pracownik_id, zmina_id) VALUES (1, TO_DATE('2024-03-26', 'YYYY-MM-DD'), 1, 1);
INSERT INTO pracownicy_harmonogram (pracownik_harmonogram_id, data, pracownik_id, zmina_id) VALUES (2, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 2, 2);
INSERT INTO pracownicy_harmonogram (pracownik_harmonogram_id, data, pracownik_id, zmina_id) VALUES (3, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 3, 3);
INSERT INTO pracownicy_harmonogram (pracownik_harmonogram_id, data, pracownik_id, zmina_id) VALUES (4, TO_DATE('2024-03-29', 'YYYY-MM-DD'), 4, 1);
INSERT INTO pracownicy_harmonogram (pracownik_harmonogram_id, data, pracownik_id, zmina_id) VALUES (5, TO_DATE('2024-03-30', 'YYYY-MM-DD'), 5, 2);

INSERT INTO pokoje_udogodnienia (pokoje_pokoj_id, udogodnienia_udogodnienie_id) VALUES (1, 1);
INSERT INTO pokoje_udogodnienia (pokoje_pokoj_id, udogodnienia_udogodnienie_id) VALUES (2, 2);
INSERT INTO pokoje_udogodnienia (pokoje_pokoj_id, udogodnienia_udogodnienie_id) VALUES (3, 3);
INSERT INTO pokoje_udogodnienia (pokoje_pokoj_id, udogodnienia_udogodnienie_id) VALUES (4, 1);
INSERT INTO pokoje_udogodnienia (pokoje_pokoj_id, udogodnienia_udogodnienie_id) VALUES (5, 2);

INSERT INTO miejsca_parkingowe (miejsce_parkingowe_id, ozn, miejsce_parkingowe_rodzaj_id, cena_netto, cena_brutto) VALUES (6, 'miejsce6', 1, 50.00, 60.00);
INSERT INTO miejsca_parkingowe (miejsce_parkingowe_id, ozn, miejsce_parkingowe_rodzaj_id, cena_netto, cena_brutto) VALUES (7, 'miejsce7', 1, 50.00, 60.00);
INSERT INTO miejsca_parkingowe (miejsce_parkingowe_id, ozn, miejsce_parkingowe_rodzaj_id, cena_netto, cena_brutto) VALUES (8, 'miejsce8', 1, 50.00, 60.00);
INSERT INTO miejsca_parkingowe (miejsce_parkingowe_id, ozn, miejsce_parkingowe_rodzaj_id, cena_netto, cena_brutto) VALUES (9, 'miejsce9', 1, 50.00, 60.00);
INSERT INTO miejsca_parkingowe (miejsce_parkingowe_id, ozn, miejsce_parkingowe_rodzaj_id, cena_netto, cena_brutto) VALUES (10, 'miejsce10', 1, 50.00, 60.00);




INSERT INTO rezerwacje_szczegoly (rezerwacja_szczegol_id, rezerwacje_rezerwacja_id, pokoje_pokoj_id, koszt_netto, koszt_brutto) VALUES (1, 1, 1, 200.00, 246.00);
INSERT INTO rezerwacje_szczegoly (rezerwacja_szczegol_id, rezerwacje_rezerwacja_id, pokoje_pokoj_id, koszt_netto, koszt_brutto) VALUES (2, 2, 2, 250.00, 307.50);
INSERT INTO rezerwacje_szczegoly (rezerwacja_szczegol_id, rezerwacje_rezerwacja_id, pokoje_pokoj_id, koszt_netto, koszt_brutto) VALUES (3, 3, 3, 300.00, 369.00);
INSERT INTO rezerwacje_szczegoly (rezerwacja_szczegol_id, rezerwacje_rezerwacja_id, pokoje_pokoj_id, koszt_netto, koszt_brutto) VALUES (4, 4, 4, 220.00, 270.60);
INSERT INTO rezerwacje_szczegoly (rezerwacja_szczegol_id, rezerwacje_rezerwacja_id, pokoje_pokoj_id, koszt_netto, koszt_brutto) VALUES (5, 5, 5, 180.00, 221.40);

INSERT INTO rezerwacje_uslugi (rezerwacja_usluga_id, rezerwacja_id, rezerwacja_szczegol_id, usluga_id, cena_netto, cena_brutto) VALUES (1, 1, 1, 1, 50.00, 61.50);
INSERT INTO rezerwacje_uslugi (rezerwacja_usluga_id, rezerwacja_id, rezerwacja_szczegol_id, usluga_id, cena_netto, cena_brutto) VALUES (2, 2, 2, 2, 70.00, 86.10);
INSERT INTO rezerwacje_uslugi (rezerwacja_usluga_id, rezerwacja_id, rezerwacja_szczegol_id, usluga_id, cena_netto, cena_brutto) VALUES (3, 3, 3, 3, 100.00, 123.00);
INSERT INTO rezerwacje_uslugi (rezerwacja_usluga_id, rezerwacja_id, rezerwacja_szczegol_id, usluga_id, cena_netto, cena_brutto) VALUES (4, 4, 4, 4, 80.00, 98.40);
INSERT INTO rezerwacje_uslugi (rezerwacja_usluga_id, rezerwacja_id, rezerwacja_szczegol_id, usluga_id, cena_netto, cena_brutto) VALUES (5, 5, 5, 5, 60.00, 73.80);

INSERT INTO rezerwacja_parkingi (rezerwacja_parking_id, rezerwacja_id, miejsca_parkingowe_id, cena_netto, cena_brutto, data_rozpoczecia, data_zakonczenia) VALUES (1, 1, 6, 50.00, 60.00, TO_DATE('2024-03-26', 'YYYY-MM-DD'), TO_DATE('2024-03-28', 'YYYY-MM-DD'));
INSERT INTO rezerwacja_parkingi (rezerwacja_parking_id, rezerwacja_id, miejsca_parkingowe_id, cena_netto, cena_brutto, data_rozpoczecia, data_zakonczenia) VALUES (2, 2, 7, 70.00, 80.00, TO_DATE('2024-03-27', 'YYYY-MM-DD'), TO_DATE('2024-03-29', 'YYYY-MM-DD'));
INSERT INTO rezerwacja_parkingi (rezerwacja_parking_id, rezerwacja_id, miejsca_parkingowe_id, cena_netto, cena_brutto, data_rozpoczecia, data_zakonczenia) VALUES (3, 3, 8, 40.00, 50.00, TO_DATE('2024-03-28', 'YYYY-MM-DD'), TO_DATE('2024-03-30', 'YYYY-MM-DD'));
INSERT INTO rezerwacja_parkingi (rezerwacja_parking_id, rezerwacja_id, miejsca_parkingowe_id, cena_netto, cena_brutto, data_rozpoczecia, data_zakonczenia) VALUES (4, 4, 9, 50.00, 60.00, TO_DATE('2024-03-29', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'));
INSERT INTO rezerwacja_parkingi (rezerwacja_parking_id, rezerwacja_id, miejsca_parkingowe_id, cena_netto, cena_brutto, data_rozpoczecia, data_zakonczenia) VALUES (5, 5, 10, 70.00, 80.00, TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'));


-- -------------------------------------------------------------------------------
-- POLECENIA   3 X SELECT  ( PRZYKŁADY Z JOIN NA MIN. 3 TABELACH)                                                   
-- -------------------------------------------------------------------------------


SELECT r.rezerwacja_id, k.imie, k.nazwisko, p.numer FROM rezerwacje r
JOIN klienci k ON r.klient_id = k.klient_id
JOIN rezerwacje_szczegoly rs ON r.rezerwacja_id = rs.rezerwacje_rezerwacja_id
JOIN pokoje p ON rs.pokoje_pokoj_id = p.pokoj_id;

SELECT r.rezerwacja_id, COUNT(u.usluga_id) AS ilosc_uslug, SUM(u.cena_brutto) AS suma_cen
FROM rezerwacje r
JOIN rezerwacje_uslugi ru ON r.rezerwacja_id = ru.rezerwacja_id
JOIN uslugi u ON ru.usluga_id = u.usluga_id
GROUP BY r.rezerwacja_id;

SELECT r.rezerwacja_id, p.imie, p.nazwisko, s.nazwa
FROM rezerwacje r
JOIN pracownicy_stanowiska ps ON r.pracownik_id = ps.pracownik_id
JOIN pracownicy p ON ps.pracownik_id = p.pracownik_id
JOIN stanowiska s ON ps.stanowisko_id = s.stanowisko_id
WHERE r.rezerwacja_status_id = 1
ORDER BY r.data_utworzenia DESC;


-- -------------------------------------------------------------------------------
-- POLECENIA   3 X UPDATE                                                      
-- -------------------------------------------------------------------------------


UPDATE klienci
SET telefon = '555555555'
WHERE klient_id = 1;


UPDATE rezerwacje
SET koszt_brutto = koszt_brutto * 1.1
WHERE data_utworzenia = TO_DATE('2024-03-28', 'YYYY-MM-DD');


UPDATE pokoje
SET cena_brutto = cena_brutto * 1.05
WHERE ile_osob = 2;


-- -------------------------------------------------------------------------------
-- POLECENIA   3 X DELETE                                                       
-- -------------------------------------------------------------------------------

DELETE FROM rezerwacje_uslugi
WHERE cena_brutto = 100.00;

DELETE FROM platnosci WHERE klient_id = 4;

DELETE FROM pracownicy_stanowiska WHERE pracownik_id = 3;



-- -------------------------------------------------------------------------------
-- USUWANIE STRUKTURY BAZY DANYCH                                            
-- -------------------------------------------------------------------------------
DROP TABLE rezerwacje_uslugi;
DROP TABLE rezerwacje_szczegoly;
DROP TABLE rezerwacja_parkingi;
DROP TABLE platnosci;
DROP TABLE rezerwacje;
DROP TABLE pracownicy_harmonogram;
DROP TABLE pracownicy_stanowiska;
DROP TABLE pracownicy;
DROP TABLE klienci;
DROP TABLE pokoje_udogodnienia;
DROP TABLE miejsca_parkingowe;
DROP TABLE miejsca_parkingowe_rodzaje;
DROP TABLE pokoje;
DROP TABLE rezerwacje_statusy;
DROP TABLE stanowiska;
DROP TABLE udogodnienia;
DROP TABLE uslugi;
DROP TABLE zmiany;



-- Drop sequences
DROP SEQUENCE klienci_klient_id_seq;
DROP SEQUENCE miejsca_parkingowe_miejsce_par;
DROP SEQUENCE miejsca_parkingowe_rodzaje_mie;
DROP SEQUENCE platnosci_platnosc_id_seq;
DROP SEQUENCE pokoje_pokoj_id_seq;
DROP SEQUENCE pokoje_udogodnienia_pokoje_pok;
DROP SEQUENCE pracownicy_pracownik_id_seq;
DROP SEQUENCE pracownicy_harmonogram_pracown;
DROP SEQUENCE pracownicy_stanowiska_stanowis;
DROP SEQUENCE rezerwacja_parkingi_rezerwacja;
DROP SEQUENCE rezerwacje_rezerwacja_id_seq;
DROP SEQUENCE rezerwacje_statusy_rezerwacja_;
DROP SEQUENCE rezerwacje_szczegoly_rezerwacj;
DROP SEQUENCE rezerwacje_uslugi_rezerwacja_u;
DROP SEQUENCE stanowiska_stanowisko_id_seq;
DROP SEQUENCE udogodnienia_udogodnienie_id;
DROP SEQUENCE uslugi_usluga_id_seq;
DROP SEQUENCE zmiany_zmina_id_seq;



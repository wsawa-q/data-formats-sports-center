//// OBJEKTY

// LOKACE
CREATE (HlavniLok:Lokace {nazev:'Velká hala', plocha:420, kapacita:69})
CREATE (MalaLok:Lokace {nazev:'Malá hala', plocha:100, kapacita:40})
CREATE (HrLok:Lokace {nazev:'Hřiště', plocha:500, kapacita:120})

// KRYTI
CREATE (UplKryt:Kryti {nazev:'Úplna střecha', popis:'Nejlepší střecha na světě', urovenKryti:1})
CREATE (PoloKryt:Kryti {nazev:'Poloviční střecha', popis:'Nejlepší střecha na světě', urovenKryti:0.5})
CREATE (MagiKryt:Kryti {nazev:'Magická střecha', popis:'Je to magie no...', urovenKryti:0})

// POVRCH
CREATE (ParPovrch:Povrch {nazev:'Parket'})
CREATE (UmtPovrch:Povrch {nazev:'Uměla trava'})
CREATE (TrPovrch:Povrch {nazev:'Trava'})

// ROZVRCH
// Nedele
CREATE (NeARozvrch:Rozvrch {den:0, od:localtime({hour:0, minute:0}), do:localtime({hour:23, minute:59})})
// Pondeli
CREATE (PoARozvrch:Rozvrch {den:1, od:localtime({hour:7, minute:0}), do:localtime({hour:18, minute:0})})
// Utery
CREATE (UtARozvrch:Rozvrch {den:2, od:localtime({hour:7, minute:0}), do:localtime({hour:18, minute:0})})
// Streda
CREATE (StARozvrch:Rozvrch {den:3, od:localtime({hour:7, minute:0}), do:localtime({hour:18, minute:0})})
CREATE (StBRozvrch:Rozvrch {den:3, od:localtime({hour:9, minute:0}), do:localtime({hour:21, minute:0})})
// Ctvrtek
CREATE (CtARozvrch:Rozvrch {den:4, od:localtime({hour:7, minute:0}), do:localtime({hour:18, minute:0})})
// Patek
CREATE (PaARozvrch:Rozvrch {den:5, od:localtime({hour:7, minute:0}), do:localtime({hour:18, minute:0})})
CREATE (PaBRozvrch:Rozvrch {den:5, od:localtime({hour:9, minute:0}), do:localtime({hour:21, minute:0})})
// Sobota
CREATE (SoARozvrch:Rozvrch {den:6, od:localtime({hour:0, minute:0}), do:localtime({hour:6, minute:0})})

// UDALOST
CREATE (AUdalost:Udalost {nazev:'Hustá událost', datum:date('2077-07-07'), od:localtime({hour:18, minute:0}), do:localtime({hour:21, minute:0})})
CREATE (BUdalost:Udalost {nazev:'Velká událost 1', datum:date('2022-02-28'), od:localtime({hour:15, minute:0}), do:localtime({hour:23, minute:59})})
CREATE (CUdalost:Udalost {nazev:'Velká událost 2', datum:date('2022-03-01'), od:localtime({hour:0, minute:0}), do:localtime({hour:18, minute:0})})
CREATE (DUdalost:Udalost {nazev:'Malá událost', datum:date('2077-07-07'), od:localtime({hour:0, minute:0}), do:localtime({hour:6, minute:0})})
CREATE (EUdalost:Udalost {nazev:'Turnaj - Futsal', datum:date('2022-10-10'), od:localtime({hour:7, minute:0}), do:localtime({hour:12, minute:0})})
CREATE (FUdalost:Udalost {nazev:'Turnaj - Tenis', datum:date('2022-10-10'), od:localtime({hour:7, minute:0}), do:localtime({hour:12, minute:0})})
CREATE (GUdalost:Udalost {nazev:'Basketbal', datum:date('2017-12-10'), od:localtime({hour:7, minute:0}), do:localtime({hour:12, minute:0})})

// ZAMESTNANCE
CREATE (ValerieZam:Zamestnance {givenName:'Valerie', familyName:'Kurinnaya', pracovniTelefon:'+380 97 514 63 00', mzda:400, aktivni:true})
CREATE (JeanZam:Zamestnance {givenName:'Jean', familyName:'Gunnhildr', pracovniTelefon:'+420 123 321 000', mzda:450, aktivni:true})
CREATE (KleeZam:Zamestnance {givenName:'Klee', familyName:'Dodoco', pracovniTelefon:'+380 97 514 63 00', mzda:50, aktivni:false})
CREATE (JanZam:Zamestnance {givenName:'Jan', familyName:'Lenivý', pracovniTelefon:'+420 774 066 035', mzda:150, aktivni:true})

// SPORTOVEC
CREATE (TomasSport:Sportovec {givenName:'Tomáš', familyName:'Strnad', osobniTelefon:'+420 753 159 789'})
CREATE (JakubSport:Sportovec {givenName:'Jakub', familyName:'Hroník', osobniTelefon:'+420 951 357 456'})
CREATE (YervandSport:Sportovec {givenName:'Yervand', familyName:'Arzumanyan', osobniTelefon:'+420 159 753 123'})


//// RELACE

// LOKACE -> (KRYTI, POVRCH, ROZVRCH, SPORTOVEC)
CREATE
    (HlavniLok)-[:JE_POKRYVANA]->(UplKryt),
    (MalaLok)-[:JE_POKRYVANA]->(PoloKryt),
    (HrLok)-[:JE_POKRYVANA]->(MagiKryt)

CREATE
    (MalaLok)-[:MA]->(ParPovrch),
    (HlavniLok)-[:MA]->(UmtPovrch),
    (HrLok)-[:MA]->(TrPovrch)

CREATE
    (HlavniLok)-[:OTEVRENA_DLE]->(NeARozvrch),
    (HlavniLok)-[:OTEVRENA_DLE]->(PoARozvrch),
    (HlavniLok)-[:OTEVRENA_DLE]->(UtARozvrch),
    (HlavniLok)-[:OTEVRENA_DLE]->(StARozvrch),
    (HlavniLok)-[:OTEVRENA_DLE]->(CtARozvrch),
    (HlavniLok)-[:OTEVRENA_DLE]->(PaARozvrch),
    (HlavniLok)-[:OTEVRENA_DLE]->(SoARozvrch),
    (MalaLok)-[:OTEVRENA_DLE]->(NeARozvrch),
    (MalaLok)-[:OTEVRENA_DLE]->(PoARozvrch),
    (MalaLok)-[:OTEVRENA_DLE]->(UtARozvrch),
    (MalaLok)-[:OTEVRENA_DLE]->(StBRozvrch),
    (MalaLok)-[:OTEVRENA_DLE]->(CtARozvrch),
    (MalaLok)-[:OTEVRENA_DLE]->(PaBRozvrch),
    (MalaLok)-[:OTEVRENA_DLE]->(SoARozvrch)

CREATE
    (HlavniLok)-[:JE_PRISTUPNA]->(TomasSport),
    (HlavniLok)-[:JE_PRISTUPNA]->(YervandSport),
    (MalaLok)-[:JE_PRISTUPNA]->(JakubSport),
    (MalaLok)-[:JE_PRISTUPNA]->(YervandSport),
    (HrLok)-[:JE_PRISTUPNA]->(TomasSport),
    (HrLok)-[:JE_PRISTUPNA]->(JakubSport)

// UDALOST -> (LOKACE, ZAMESTNANEC)
CREATE
    (AUdalost)-[:SE_KONA]->(HrLok),
    (BUdalost)-[:SE_KONA]->(MalaLok),
    (CUdalost)-[:SE_KONA]->(MalaLok),
    (DUdalost)-[:SE_KONA]->(HlavniLok),
    (EUdalost)-[:SE_KONA]->(HlavniLok),
    (FUdalost)-[:SE_KONA]->(MalaLok),
    (GUdalost)-[:SE_KONA]->(MalaLok)

CREATE
    (AUdalost)-[:JE_ORGANIZOVAN]->(ValerieZam),
    (AUdalost)-[:JE_ORGANIZOVAN]->(JeanZam),
    (BUdalost)-[:JE_ORGANIZOVAN]->(ValerieZam),
    (BUdalost)-[:JE_ORGANIZOVAN]->(KleeZam),
    (CUdalost)-[:JE_ORGANIZOVAN]->(ValerieZam),
    (CUdalost)-[:JE_ORGANIZOVAN]->(JeanZam),
    (CUdalost)-[:JE_ORGANIZOVAN]->(JanZam),
    (DUdalost)-[:JE_ORGANIZOVAN]->(JeanZam),
    (EUdalost)-[:JE_ORGANIZOVAN]->(ValerieZam),
    (FUdalost)-[:JE_ORGANIZOVAN]->(KleeZam),
    (GUdalost)-[:JE_ORGANIZOVAN]->(JanZam)
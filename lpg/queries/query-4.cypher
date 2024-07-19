// Výpis celkových nákladů na jednotlivé události
MATCH (u:Udalost)-[:JE_ORGANIZOVAN]-(zam:Zamestnance) 
WITH u, sum(zam.mzda*duration.between(u.od, u.do).minutes/60) AS naklady 
RETURN u.nazev, u.datum, naklady
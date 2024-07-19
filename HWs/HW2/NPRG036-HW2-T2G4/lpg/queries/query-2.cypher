// Výpis lokací, které mají pravidelně otevřeno více než 85 hodin týdně
MATCH (lok:Lokace)-[:OTEVRENA_DLE]-(r:Rozvrch) 
WITH lok, sum(duration.between(r.od, r.do).hours) AS dur 
WHERE dur > 85 
RETURN lok.nazev
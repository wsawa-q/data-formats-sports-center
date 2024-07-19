// Výpis počet sportovců, kteří mají přístup do lokací otevřených ve středu od 08։00
MATCH (sp:Sportovec)-[:JE_PRISTUPNA]-(lok:Lokace)-[:OTEVRENA_DLE]-(roz:Rozvrch) 
WHERE roz.den = 3 AND roz.od.hour >= 8
RETURN count(sp)
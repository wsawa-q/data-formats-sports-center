// Výpis kontaktů na zaměstnance organizující události 2022-10-10, které se konají v lokaci s krytím < 1. (rušení událostí z důvodu počasí)
MATCH (zam:Zamestnance)-[:JE_ORGANIZOVAN]-(u:Udalost {datum:'2022-10-10'})-[:SE_KONA]-(lok:Lokace)-[:JE_POKRYVANA]-(kr:Kryti) 
WHERE kr.urovenKryti < 1 
RETURN zam.givenName, zam.pracovniTelefon
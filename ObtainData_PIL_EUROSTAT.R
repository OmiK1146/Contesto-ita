# In questo primo progetto creaimo una panoramica del ruolo dello Stato 
# nell'economia italiana

# Partiamo usando il pacchetto di eurostat per trovare i primi dati 
library(eurostat)

# Per primo, cerchiamo la serie storica del PIL, cerchiamo le tabelle 
# che contengono "GDP" tramite la seguente funzione
search_eurostat("GDP main aggregates")

# Altrimenti possiamo anche scaricare l'elenco di TUTTE le tabelle
toc <- get_eurostat_toc()

# Avendo tutti i dati a disposizione è necessario cercare quello che ci interessa
# Usiamo la funzione subset 
# Filtra il 'toc' per trovare le righe dove il 'title' contiene
# SIA "GDP" CHE "main aggregates"
# grepl serve a cercare testo nella colonna title di toc, inoltre ignoriamo la distinzione maiuscole/minuscole con ignore.case = TRUE
gdp_tables <- subset(toc, grepl("GDP", title, ignore.case = TRUE) & grepl("main aggregates", title, ignore.case = TRUE))
gdp_tables

# Dalla tabella possiamo vedere che abbiamo alcuni risultati con stesso simile ma
# codice diverso. E' necessario capire in cosa differiscono
get_eurostat_dic("enps_nama_gdp", "geo") #Ci permette di scaricare il "dizionario" 
# di una specifica colonna
get_eurostat_dic("enpe_nama_gdp", "geo")
get_eurostat_dic("naida_10_gdp", "geo")
get_eurostat_dic("naidq_10_gdp", "geo")

# Visto che ottengo un errore 404 provo in un'altro modo
# Scarica il dataset 'naida_10_gdp', filtrando solo per l'Italia ('IT')
gdp_ita <- get_eurostat(id = "naida_10_gdp", 
                        filters = list(geo = "IT"))
head(gdp_ita)
# Ottengo come value NA perchè non ho specificato quale dato voglio
# Allora vediamo tutti gli AGGREGATI disponibili
unique(gdp_ita$na_item)

# E vediamo tutte le UNITÀ DI MISURA disponibili
unique(gdp_ita$unit)

# Filtriamo il nostro dataset 'gdp_ita'
# e teniamo solo le righe dove 'na_item' è ESATTAMENTE 'B1GQ'
# La funzione subset filtra il dataset, come argomenti ho il dataset da filtrare
# e la colonna da filtrare con la condizione
gdp_ita_pil <- subset(gdp_ita, na_item == "B1GQ")

# Ora, guardiamo le unità di misura SOLO per questo nuovo oggetto
unique(gdp_ita_pil$unit)

# Quelli che ci interessano sono "CP-MEUR" (milioni di euro a prezzi correnti)
# e "CLV_MEUR" (milioni di euro a prezzi costanti)

# Filtriamo ancora, prendendo solo l'unità 'CP_MEUR'
pil_nominale_ita <- subset(gdp_ita_pil, unit == "CP_MEUR")
pil_nominale_ita

#Ripetiamo con il PIL reale
pil_reale_ita <- subset(gdp_ita_pil, unit == "CLV_I10")
pil_reale_ita


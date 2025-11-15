# Carica il pacchetto
library(eurostat)

# Scarica l'elenco di tutte le tabelle
toc <- get_eurostat_toc()

# Filtra il 'toc' per trovare le tabelle sull'istruzione terziaria
edu_tables <- subset(toc, grepl("tertiary education", title, ignore.case = TRUE))

# Ora stampa il risultato per vederlo
edu_tables

# Ottengo i dati che ci interessano
laureati_ita_pc <- get_eurostat( id = "yth_educ_020", filters = list(geo = "IT"))
laureati_ita <- get_eurostat( id = "sdg_04_20", filters = list(geo = "IT"))

#Divido i dataframe
laureati_ita_tot <- laureati_ita[1:25,]
laureati_ita_m <- laureati_ita[26:50,]
laureati_ita_f <- laureati_ita[51:75,]

#Pulisco i tre dataframe
laureati_ita_tot <- laureati_ita_tot[,c("sex","values")]
rownames(laureati_ita_tot) <- 2000:2024


laureati_ita_m <- laureati_ita_m[,c("sex","values")]
rownames(laureati_ita_m) <- 2000:2024

laureati_ita_f <- laureati_ita_f[,c("sex","values")]
rownames(laureati_ita_f) <- 2000:2024





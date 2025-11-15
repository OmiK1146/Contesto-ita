# Usiamo il pacchetto di eurostat
library(eurostat)

# Scarichiamo tutti i dati di eurostat
toc <- get_eurostat_toc()

# Cerchiamo il dataset sulla produttività, subset serve a filtrare i dati
# grepl cerca la parola "prod" nel titolo del dataset, ignore.case = TRUE 
# rende la ricerca non sensibile alle maiuscole/minuscole
prod_search <- subset(toc, grepl("productivity", title, ignore.case = TRUE))
prod_search

# Ci sono diversi dati interessanti, il primo è 
# Labour and capital productivity for total economy by industry, che è una folder
prod_folder <- get_eurostat_folder("nama_10_lpc", env = NULL)

# Vediamo i dataset contenuti nella folder
names(prod_folder)

# Creiamo un glossario dei dataset contenuti nella folder
# Usiamo sempre subset per filtrare i dati del toc, usando i nomi dei dataset
glossario <- subset(toc, code %in% names(prod_folder))

# Creiamo i dataset di interesse
# Labour productivity and unit labour costs by industry (NACE Rev.2)
lplci <- get_eurostat("nama_10_lp_a21", filter = list(geo = "IT"))

#Ho tanti codici che devo leggere e capire dal dizionario eurostat
dizionario_settore <- get_eurostat_dic("nace_r2", lang = "en")
dizionario <- get_eurostat_dic("na_item", lang = "en")

# Guardando i dizionari, ho tantissimi filtri da poter mettere. Attualmente è meglio
# rimanere su qualcosa di più generale. Cerco l'aggregato di tutta l'economia

# Cerchiamo la total factor produtivity
tfp_search <- subset(toc, grepl("total factor productivity", title, ignore.case = TRUE))

# Non esisto dataset nel toc. Ho recuperato il dataset sul sito
library(readxl)
tfp_excel <- read_excel("TFP.xlsx") # Lettura del file
tfp_data <- read_excel("TFP.xlsx", sheet = "Italy") # Lettura del foglio Italia

# Qui ho eseguito diverse manovre di pulizia dei dati
tfp_data <- tfp_data[6:33,] 
tfp_data <- tfp_data[-1,]
colnames(tfp_data) <- tfp_data[1,]
tfp_data <- tfp_data[-1,]
tfp_data <- tfp_data[-23:-26,]
rownames(tfp_data) <- 2001:2022
tfp_data <- tfp_data[,-1]
rownames(tfp_data) <- 2001:2022
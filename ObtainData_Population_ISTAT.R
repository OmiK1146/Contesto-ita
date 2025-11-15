#In questo script cerchiamo i dati della popolazione italina dai dataset di ISTAT

# Carica il pacchetto proprietario
library(rjstat)

# In questo caso conviene prima cercare i dati sul rispettivo sito
#https://esploradati.istat.it/databrowser/#/it

library(readxl)
# Leggiamo il file excel scaricato dal sito ISTAT
nomi_schede <- excel_sheets("Bilancio_91_01.xlsx")
nomi_schede
# Carichiamo il contenuto della prima scheda, "A IT 1"
# e lo salviamo in un nuovo oggetto
dati_scheda1 <- read_excel("Bilancio_91_01.xlsx", sheet = "A IT 1")
dati_scheda2 <- read_excel("Bilancio_91_01.xlsx", sheet = "A IT 2")
dati_scheda3 <- read_excel("Bilancio_91_01.xlsx", sheet = "A IT 9")
# Ora, diamo un'occhiata alle prime righe di questa tabella
# per capire cosa contiene
head(dati_scheda1)
head(dati_scheda2)
head(dati_scheda3)

# Uniamo i tre dataset in un unico dataset con rbind
popolazione_ita <- rbind(dati_scheda1, dati_scheda2, dati_scheda3)
popolazione_ita

# Devo eliminare alcune righe e colonne inutili, lo faccio selezionando le righe
# che mi interessano
popolazione_ita <- popolazione_ita[c(5,7,14,21),]

# Traspostiamo righe e colonne
popolazione_ita <- t(popolazione_ita)

# Rinomiano i nomi dlle righe
rownames(popolazione_ita) <- popolazione_ita[,1]

# Eliminiamo la prima colonna che ora è inutile
popolazione_ita <- popolazione_ita[,-1]

# Rinominiamo le colonne
colnames(popolazione_ita) <- c("Maschi al 31/12","Femmine al 31/12","Totale al 31/12")

# Elimino la prima riga che ora è inutile
popolazione_ita <- popolazione_ita[-1,]

# Visualizziamo il dataset finale
popolazione_ita

# Ora devo aggiungere i dati dei successivi 10 anni
nomi_fogli <- excel_sheets("Bilancio_02_18.xlsx")
foglio1 <- read_excel("Bilancio_02_18.xlsx", sheet = "A IT 1 TOTAL")
foglio2 <- read_excel("Bilancio_02_18.xlsx", sheet = "A IT 2 TOTAL")
foglio3 <- read_excel("Bilancio_02_18.xlsx", sheet = "A IT 9 TOTAL")

# Uniamo i tre dataset in un unico dataset con rbind
popolazione_ita_2 <- rbind(foglio1, foglio2, foglio3)
popolazione_ita_2 <- popolazione_ita_2[c(6,8,16,24),]

# Traspostiamo righe e colonne
popolazione_ita_2 <- t(popolazione_ita_2)

# Rinomiano i nomi delle righe e delle colonne
rownames(popolazione_ita_2) <- popolazione_ita_2[,1]
popolazione_ita_2 <- popolazione_ita_2[,-1]
colnames(popolazione_ita_2) <- c("Maschi al 31/12","Femmine al 31/12","Totale al 31/12")
popolazione_ita_2 <- popolazione_ita_2[-1,]

# Ora devo unire le due tabelle che ho costruito
popolazione_ita_91_18 <- rbind(popolazione_ita, popolazione_ita_2)
popolazione_ita_91_18

# Riconvertiamo i dati in variabili numeriche, a causa della trasposizione
# Convertiamo prima in data frame perchè la trasposizione crea una matrice
# e le matrici possono contenere solo un tipo di dato
pop_91_18 <- as.data.frame(popolazione_ita_91_18)
pop_91_18$`Maschi al 31/12` <- as.numeric(pop_91_18$`Maschi al 31/12`)
pop_91_18$`Femmine al 31/12` <- as.numeric(pop_91_18$`Femmine al 31/12`)
pop_91_18$`Totale al 31/12` <- as.numeric(pop_91_18$`Totale al 31/12`)



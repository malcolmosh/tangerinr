# tangerinr
Librairie de base pour analyser des relevés de crédit exportés de tangerine

```r
# Installer et charger la librairie que nous venons de créer

library(devtools)
install_github("malcolmosh/tangerinr")
library(tangerinr)


# Test de la documentation
?tangimport
?tan_agreg
?tan_graphique

#' Test des fonctions
#' Chargeons d'abord les librairies requises
# Test de la fonction tangimport
setwd("/Users/osher/OneDrive/Hec MSc/3. Logiciels statistiques/Travail final")
importation = tangimport(importation)

# Test de la fonction tan_agreg
tan_agreg(tout=TRUE)
tan_agreg(tout=FALSE,mois=04)

# Test de la fonction tan_graphique
tan_graphique(tout=TRUE)
tan_graphique(tout=FALSE,choixannee=2020)

```


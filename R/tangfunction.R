
#' Importation de données bancaire en format CSV
#'
#' Vous devez d'abord télécharger vos relevés de dépenses de carte de crédit
#' en format CSV à partir du site web de Tangerine. Entreposez les ensuite dans un sous-dossier
#' de votre espace de travail que vous nommerez "tangerinecredit" (qui ne contiendra que ces fichiers et pas d'autres CSV) Cette fonction permet d'importer tous les fichiers
#' CSV contenus dans ce sous-dossier et les fusionne pour créer un seul tibble. Notez que pour conserver
#' le jeu de données généré par la fonction dans votre session vous devrez l'assigner à un vecteur.
#'
#' @param x Le nom que vous souhaitez donner au jeu de données créé
#' @return Un tibble comprenant toutes les données CSV des différents fichiers entroposés dans le sous-dossier
#' @export
#'
tangimport <- function(x) {
  x= list.files(path=".",pattern="/*.CSV",full.names = T) %>%
    map_df(~read_csv(., col_types = cols(`Date de l'opération` = col_date(format = "%m/%d/%Y"),
                                         Montant = col_number()), locale = locale(encoding = "latin1")))

 print(x)
}

#' Agrégation des données
#'
#' Cette fonction permet d'afficher une agrégation de vos dépenses par mois et par année.
#'
#'#' @param data Votre jeu de donnée importé par tangimport
#' @param tout Si vous souhaitez afficher toutes les dépenses, indiquez TRUE
#' @param mois Si vous souhaitez sélectionner un mois précis, faites-le ici à l'aide du numéro du mois (ex: 05)
#' @return Un tibble qui affiche l'agrégation souhaitée
#' @export
tan_agreg<- function(data, tout=TRUE,mois) {

  x=data
  x$moistr= month(x$`Date de l'opération`)
   x$jourtr=day(x$`Date de l'opération`)
   x$anneetr=year(x$`Date de l'opération`)

   if (tout==TRUE){
   x %>%
     filter(Transaction  =="DÉBIT") %>%
     group_by(moistr) %>%
     summarise(montant_tot=sum(-(Montant)))
   }
   else {
    x %>%
       filter(Transaction  =="DÉBIT") %>%
       filter(moistr == mois) %>%
       group_by(moistr) %>%
       summarise(montant_tot=sum(-(Montant)))
   }
}

#' Représentation graphique des dépenses mensuelles.
#'
#' Cette fonction permet d'afficher un graphique de vos dépenses mensuelles sur 12 mois, avec une couleur
#' différente par année

#' @param data Votre jeu de donnée importé par tangimport
#' @param tout Si vous souhaitez afficher les dépenses de toute la période, indiquez TRUE
#' @param annee Si vous souhaitez sélectionner une année précise, indiquez là ici en format numérique (ex: 2020)
#' @return Un graphique avec l'évolution mensuelle de vos dépenses sur 12 mois
#' @export
#histogramme de dépenses par année
tan_graphique<- function(data, tout=TRUE,annee) {

  x=data

  if (tout==TRUE){

    x2<- x %>%
      mutate (moisanneetr = as.yearmon(x$`Date de l'opération`)) %>%
      filter(Transaction  =="DÉBIT") %>%
      group_by(moisanneetr) %>%
      summarise(montant_tot=sum(-(Montant)))


    ggplot(x2, aes(month(moisanneetr, label=TRUE, abbr=TRUE),
                   montant_tot, group=factor(year(moisanneetr)), colour=factor(year(moisanneetr)))) +
      geom_line() +
      geom_point() +
      labs(x="Month", colour="Year") +
      theme_classic()
  }
  else {
    x3<- x %>%
      mutate (moisanneetr = as.yearmon(x$`Date de l'opération`)) %>%
      filter(Transaction  =="DÉBIT") %>%
      filter(year(moisanneetr)==annee) %>%
      group_by(moisanneetr) %>%
      summarise(montant_tot=sum(-(Montant)))

    ggplot(x3, aes(month(moisanneetr, label=TRUE, abbr=TRUE),
                   montant_tot, group=factor(year(moisanneetr)), colour=factor(year(moisanneetr)))) +
      geom_line() +
      geom_point() +
      labs(x="Month", colour="Year") +
      theme_classic()
  }
}


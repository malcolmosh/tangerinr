% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tangfunction.R
\name{tangimport}
\alias{tangimport}
\title{Importation de données bancaire en format CSV}
\usage{
tangimport(x)
}
\arguments{
\item{x}{Le nom que vous souhaitez donner au jeu de données créé}
}
\value{
Un tibble comprenant toutes les données CSV des différents fichiers entroposés dans le sous-dossier
}
\description{
Vous devez d'abord télécharger vos relevés de dépenses de carte de crédit
en format CSV à partir du site web de Tangerine. Entreposez les ensuite dans un sous-dossier
de votre espace de travail que vous nommerez "tangerinecredit" (qui ne contiendra que ces fichiers et pas d'autres CSV) Cette fonction permet d'importer tous les fichiers
CSV contenus dans ce sous-dossier et les fusionne pour créer un seul tibble. Notez que pour conserver
le jeu de données généré par la fonction dans votre session vous devrez l'assigner à un vecteur.
}

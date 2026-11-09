#' # EDA - skladby na Spotify podľa žánru
#'
#' Zdroj dát: https://github.com/rfordatascience/tidytuesday/tree/master/data/2020/2020-01-21
#' (priamy odkaz: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv)
#'
#' Dataset obsahuje skladby zo Spotify playlistov. Každý riadok je jedna skladba.
#' Číselné premenné sú napr. danceability (tanečnosť 0-1), energy, tempo, track_popularity (0-100)
#' a duration_ms. Kategorické premenné sú napr. playlist_genre (6 žánrov), playlist_subgenre a track_artist.

setwd("C:/PROGRAMOVANIE/masta/zadanie_2")

data <- read.csv("spotify_songs.csv")
dim(data)
str(data)

#' ## Čistenie dát

colSums(is.na(data))           # chýbajúce hodnoty
sum(duplicated(data))          # úplne rovnaké riadky
sum(duplicated(data$track_id)) # tá istá skladba viackrát

data <- na.omit(data)
data <- data[!duplicated(data$track_id), ]
data$playlist_genre <- as.factor(data$playlist_genre)
nrow(data)

#' Dataset má 32 833 riadkov a 23 premenných. 5 skladieb nemalo názov, interpreta ani album (NA), tie som odstránil.
#' Úplne rovnaké riadky v dátach nie sú, ale 4 477 riadkov má rovnaké track_id, teda tá istá skladba
#' je vo viacerých playlistoch. Každú skladbu som nechal len raz. Po čistení ostalo 28 352 skladieb.
#' Dátové typy sú v poriadku: čísla sú num/int a texty chr. Žáner som zmenil na faktor (kategorická premenná).
#' Dátum vydania je uložený ako text, ale v analýze ho nepoužívam.

#' ## Porovnanie žánrov (tanečnosť)

table(data$playlist_genre)
tapply(data$danceability, data$playlist_genre, mean)
tapply(data$danceability, data$playlist_genre, median)
tapply(data$danceability, data$playlist_genre, var)
tapply(data$danceability, data$playlist_genre, sd)

#' Najtanečnejšie sú rap (priemer 0.716, medián 0.734) a latin (0.711, 0.727). Najmenej tanečný je rock
#' (priemer 0.519, medián 0.522). EDM, R&B a pop sú v strede (priemer 0.64-0.67).
#' Rozptyl je vo všetkých žánroch podobný (0.014-0.020, smerodajná odchýlka 0.12-0.14).
#' Najväčší rozptyl má rock a najmenší latin. Medián je vo väčšine žánrov trochu vyšší ako priemer,
#' lebo v nich je aj pár veľmi netanečných skladieb.

#' ## Grafy

boxplot(danceability ~ playlist_genre, data = data, col = "lightblue",
        main = "Tanečnosť skladieb podľa žánru", xlab = "Žáner", ylab = "Tanečnosť (0-1)")

#' Boxplot ukazuje, že krabica rocku je výrazne nižšie ako pri ostatných žánroch. Najvyššie sú rap a latin.
#' Krabice ostatných žánrov sa dosť prekrývajú. Odľahlé hodnoty sú hlavne dole, sú to veľmi netanečné skladby. Pri rocku sú aj hore.

hist(data$danceability[data$playlist_genre == "rap"], breaks = seq(0, 1, 0.05), col = "orange",
     main = "Rap", xlab = "Tanečnosť", ylab = "Počet skladieb")
hist(data$danceability[data$playlist_genre == "rock"], breaks = seq(0, 1, 0.05), col = "lightgreen",
     main = "Rock", xlab = "Tanečnosť", ylab = "Počet skladieb")

#' Histogramy porovnávajú rap a rock, teda žánre s najväčším rozdielom. Rap je posunutý doprava,
#' väčšina skladieb má tanečnosť 0.6-0.9 a rozdelenie je zošikmené doľava. Rock má stred okolo 0.5
#' a je skoro symetrický.

barplot(tapply(data$track_popularity, data$playlist_genre, mean), col = "lightblue",
        main = "Priemerná popularita podľa žánru", xlab = "Žáner", ylab = "Popularita (0-100)")

#' Najpopulárnejší je pop (priemer 45.9) a najmenej populárne je EDM (30.7). Ostatné žánre majú 36-42.

#' ## Záver
#' Žánre sa najviac líšia v tanečnosti. Rap a latin sú najtanečnejšie a rock najmenej.
#' Variabilita tanečnosti je vo všetkých žánroch podobná. Najpopulárnejšie sú popové skladby
#' a najmenej populárne EDM.

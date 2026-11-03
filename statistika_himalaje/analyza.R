#' # Analýza dát - vek ľudí na Mount Everest
#'
#' Zdroj dát: The Himalayan Database, súbor members.csv
#' (https://github.com/rfordatascience/tidytuesday/tree/master/data/2020/2020-09-22)

data <- read.csv("members.csv")
dim(data)
str(data)

#' Dataset má 76 519 riadkov a 21 stĺpcov. Každý riadok je jeden človek na jednej horolezeckej
#' výprave v Himalájach (1905-2019). Dôležité premenné: peak_name (vrchol), year (rok), age (vek),
#' sex (pohlavie), hired (TRUE = najatý personál, šerpovia), success (vystúpil na vrchol).

#' ## Podskupiny
#' Vybral som len Mount Everest od roku 1980 a rozdelil ľudí na 3 skupiny:
#' klienti 1980-1999, klienti 2000-2019 a najatý personál (šerpovia) 2000-2019.

everest <- subset(data, peak_name == "Everest" & year >= 1980 & !is.na(age))

klienti1 <- subset(everest, hired == FALSE & year <= 1999)
klienti2 <- subset(everest, hired == FALSE & year >= 2000)
personal <- subset(everest, hired == TRUE & year >= 2000)

nrow(klienti1)
nrow(klienti2)
nrow(personal)

summary(klienti1$age)
summary(klienti2$age)
summary(personal$age)

#' ## Histogram

hist(klienti1$age, breaks = seq(10, 90, 5), col = "lightblue",
     main = "Vek klientov 1980-1999", xlab = "Vek", ylab = "Počet ľudí")
hist(klienti2$age, breaks = seq(10, 90, 5), col = "orange",
     main = "Vek klientov 2000-2019", xlab = "Vek", ylab = "Počet ľudí")
hist(personal$age, breaks = seq(10, 90, 5), col = "lightgreen",
     main = "Vek najatého personálu 2000-2019", xlab = "Vek", ylab = "Počet ľudí")

#' Histogram ukazuje, koľko ľudí je v jednotlivých vekových intervaloch (po 5 rokov).
#' Klienti v rokoch 1980-1999 mali väčšinou 25-40 rokov. Klienti po roku 2000 sú starší
#' a vekovo rozptýlenejší. Histogram je posunutý doprava a je širší a pomerne veľa ľudí má aj 50-60 rokov.
#' Personál je najmladší, väčšina má 20-40 rokov. Všetky tri histogramy sú mierne zošikmené doprava.

#' ## Boxplot

boxplot(klienti1$age, klienti2$age, personal$age,
        names = c("Klienti 1980-1999", "Klienti 2000-2019", "Personál 2000-2019"),
        col = c("lightblue", "orange", "lightgreen"),
        main = "Vek ľudí na Mount Everest podľa skupín", ylab = "Vek")

#' Čiara v krabici je medián, krabica obsahuje stredných 50 % hodnôt a body sú odľahlé hodnoty.
#' Najvyšší medián majú klienti po roku 2000 (40 rokov), potom klienti 1980-1999 (35 rokov)
#' a najnižší personál (32 rokov). Klienti po roku 2000 majú aj najväčší rozptyl, lebo ich krabica je najväčšia.
#' Odľahlé hodnoty sú len pri vyššom veku a najstarší človek mal 85 rokov.

#' ## Záver
#' Po roku 2000 chodia na Everest starší klienti ako predtým (medián 40 vs. 35 rokov) a ich vek je
#' rôznorodejší. Je to kvôli komerčným výpravám, na ktoré sa dostanú aj starší ľudia.
#' Najatý personál (šerpovia) je najmladšia skupina.

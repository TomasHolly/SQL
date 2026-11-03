#' ---
#' title: "Vek horolezcov na Mount Everest"
#' subtitle: "Analýza a vizualizácia dát - Matematická štatistika"
#' author: "Tomáš Holly"
#' date: "3. 11. 2026"
#' ---

#' ## 1. Dataset a jeho štruktúra
#'
#' **Zdroj:** The Himalayan Database, súbor `members.csv`
#' (<https://github.com/rfordatascience/tidytuesday/tree/master/data/2020/2020-09-22>).
#' Obsahuje záznamy o členoch horolezeckých výprav v nepálskych Himalájach v rokoch 1905-2019.
#' Každý riadok predstavuje jedného človeka na jednej výprave.

# setwd("C:/PROGRAMOVANIE/masta")   # treba len pri ručnom spúšťaní, pri Compile Report nie
data <- read.csv("members.csv")

dim(data)    # počet riadkov a stĺpcov
str(data)    # názvy a typy premenných
head(data)   # prvých 6 riadkov

#' Dataset má **76 519 riadkov a 21 premenných**. Najdôležitejšie premenné:
#'
#' - `peak_name` - názov vrcholu (napr. Everest, Cho Oyu),
#' - `year` - rok výpravy,
#' - `sex` - pohlavie (M/F),
#' - `age` - **vek v rokoch (číselná premenná, ktorú budeme skúmať)**,
#' - `citizenship` - štátna príslušnosť,
#' - `hired` - TRUE = najatý personál (šerpovia, nosiči), FALSE = klient/horolezec,
#' - `success` - TRUE = človek vystúpil na vrchol,
#' - `oxygen_used`, `died`, `injured` - použitie kyslíka, úmrtie, zranenie.

#' ## 2. Podskupiny
#'
#' Vyberieme iba výpravy na **Mount Everest od roku 1980** so známym vekom.
#' Potom ich rozdelíme na tri podskupiny:
#'
#' - **A: Klienti 1980-1999** - ľudia, ktorí nie sú najatý personál, pred érou komerčných výprav,
#' - **B: Klienti 2000-2019** - ľudia, ktorí nie sú najatý personál, v ére komerčných výprav,
#' - **C: Personál 2000-2019** - najatí šerpovia a nosiči v tom istom období.

everest <- subset(data, peak_name == "Everest" & year >= 1980 & !is.na(age))

skupinaA <- subset(everest, hired == FALSE & year <= 1999)
skupinaB <- subset(everest, hired == FALSE & year >= 2000)
skupinaC <- subset(everest, hired == TRUE  & year >= 2000)

# počet ľudí v podskupinách
nrow(skupinaA)
nrow(skupinaB)
nrow(skupinaC)

# základné štatistiky veku
summary(skupinaA$age)
summary(skupinaB$age)
summary(skupinaC$age)

# smerodajná odchýlka
sd(skupinaA$age)
sd(skupinaB$age)
sd(skupinaC$age)

#' ## 3. Histogram

#+ histogram, fig.width = 8, fig.height = 9
farby <- c("#2a78d6", "#eb6834", "#1baf7a")
par(mfrow = c(3, 1))   # 3 grafy pod sebou

hist(skupinaA$age, breaks = seq(10, 90, by = 5), freq = FALSE, ylim = c(0, 0.05),
     col = farby[1], border = "white",
     main = "A: Klienti 1980-1999", xlab = "Vek (roky)", ylab = "Hustota")
abline(v = median(skupinaA$age), lwd = 2, lty = 2)

hist(skupinaB$age, breaks = seq(10, 90, by = 5), freq = FALSE, ylim = c(0, 0.05),
     col = farby[2], border = "white",
     main = "B: Klienti 2000-2019", xlab = "Vek (roky)", ylab = "Hustota")
abline(v = median(skupinaB$age), lwd = 2, lty = 2)

hist(skupinaC$age, breaks = seq(10, 90, by = 5), freq = FALSE, ylim = c(0, 0.05),
     col = farby[3], border = "white",
     main = "C: Najatý personál 2000-2019", xlab = "Vek (roky)", ylab = "Hustota")
abline(v = median(skupinaC$age), lwd = 2, lty = 2)

par(mfrow = c(1, 1))   # návrat na 1 graf

#' **Interpretácia histogramu:**
#' Histogramy ukazujú rozdelenie veku v troch podskupinách. Všetky majú rovnaké 5-ročné intervaly
#' a rovnakú mierku osí, aby sa dali porovnať. Na osi y je hustota (nie počet), lebo podskupiny majú
#' rôzny počet ľudí. Plocha stĺpca udáva podiel ľudí v danom intervale. Prerušovaná čiara je medián.
#'
#' Všetky tri rozdelenia sú jednovrcholové a mierne zošikmené doprava. Väčšina ľudí je v strednom veku
#' a menšia časť je výrazne staršia.
#'
#' - **A (klienti 1980-1999):** najviac ľudí má 25-40 rokov, medián je 35 rokov.
#'   Ľudí nad 50 rokov je len asi 7,5 %.
#' - **B (klienti 2000-2019):** celé rozdelenie je posunuté doprava (medián 40 rokov)
#'   a je širšie a plochejšie. Ľudia nad 50 rokov tvoria asi 21 % a najstarší mal 85 rokov.
#'   Na komerčné výpravy chodí oveľa viac starších ľudí.
#' - **C (personál 2000-2019):** rozdelenie je najviac vľavo a najužšie, medián je iba 32 rokov.
#'   Asi 40 % personálu má menej ako 30 rokov. Je to fyzicky najnáročnejšia práca, preto ju robia
#'   hlavne mladí ľudia (94 % sú Nepálci, teda prevažne šerpovia).

#' ## 4. Krabicový graf (boxplot)

#+ boxplot, fig.width = 8, fig.height = 6
boxplot(skupinaA$age, skupinaB$age, skupinaC$age,
        names = c("A: Klienti 1980-1999", "B: Klienti 2000-2019", "C: Personál 2000-2019"),
        col = farby,
        main = "Vek členov výprav na Mount Everest podľa podskupín",
        xlab = "Podskupina", ylab = "Vek (roky)")
points(1:3, c(mean(skupinaA$age), mean(skupinaB$age), mean(skupinaC$age)),
       pch = 23, bg = "white", cex = 1.5)   # priemer ako biely kosoštvorec

#' **Interpretácia krabicového grafu:**
#' Hrubá čiara v krabici je medián, okraje krabice sú 1. a 3. kvartil (Q1, Q3), teda v krabici
#' je stredných 50 % ľudí. Fúzy ukazujú rozsah bežných hodnôt a body nad nimi sú odľahlé hodnoty.
#' Biely kosoštvorec je priemer.
#'
#' - **Poloha:** najvyššie je skupina B (medián 40, priemer 40,5 roka), potom A (medián 35,
#'   priemer 35,8) a najnižšie C (medián 32, priemer 32,3). Horný kvartil personálu (38 rokov) je nižší
#'   ako medián klientov po roku 2000 (40 rokov). Aspoň polovica klientov je teda staršia ako tri štvrtiny šerpov.
#' - **Variabilita:** skupina B má najvyššiu krabicu aj najdlhšie fúzy (IQR = 48 - 33 = 15 rokov,
#'   smerodajná odchýlka 10,8). Skupiny A a C sú homogénnejšie (IQR = 12 rokov, smerodajná odchýlka
#'   8,6 a 7,8). Klienti v komerčnej ére sú vekovo veľmi rôznorodí.
#' - **Odľahlé hodnoty** sú vo všetkých skupinách iba smerom hore (starší ľudia), čo zodpovedá
#'   šikmosti doprava z histogramu. Priemer je preto všade o niečo vyšší ako medián.
#'
#' ## 5. Záver
#'
#' Po roku 2000 sú klienti na Mount Evereste približne o 5 rokov starší (medián 40 vs. 35 rokov) a vekovo rôznorodejší
#' ako v rokoch 1980-1999. Je to dôsledok komerčných výprav, na ktoré sa dostanú aj starší ľudia.
#' Najatý personál (šerpovia) je najmladšou a najhomogénnejšou skupinou.

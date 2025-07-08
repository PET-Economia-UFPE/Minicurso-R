#para utilizar o ipeadata
install.packages("insight")
library(ipeadatar)

#para juntar os dados
install.packages("dplyr")
library(dplyr)

#para imprimir os gráficos
install.packages("ggplot2")
library(ggplot2)


# Buscar palavras-chave, ex: "selic"
search_series("Selic")

dados_selic <- ipeadata("PAN12_TJOVER12")
head(dados_selic)

names(dados_selic)[3] <- "selic"

dados_selic

dados_investimento <- ipeadata("SCN104_PIBFBKFAS104")
names(dados_investimento)[3] <- "FBCF"
dados_investimento

df <- inner_join(dados_selic,dados_investimento, by="date")
View(df)

ggplot(df, aes(x =selic, y = FBCF))+
geom_point() +
geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(
    title = "Relação entre investimento e taxa de juros no Brasil",
    x = "TAXA DE JUROS (% a.a.)",
    y = "INVESTIMENTO (índice)" )+
  theme_minimal()

lm(FBCF ~ selic, df)

reg_linear <- lm(FBCF ~ selic, df)
summary(reg_linear)
confint(reg_linear, lvel = 0.95)

#aplicando ln nas duas variáveis
df$lnselic <- log(df$selic)
df$lnFBCF <- log(df$FBCF)

#log-log
lm(lnFBCF ~ lnselic, df)
reg_n_linear <- lm(lnFBCF ~ lnselic, df)
summary(reg_n_linear)

#log-linear
lm(lnFBCF ~ selic, df)
reg_n_linear_2 <- lm(lnFBCF ~ selic, df)
summary(reg_n_linear_2)

#linear-log
lm(FBCF ~ lnselic, df)
reg_n_linear_3 <- lm(FBCF ~ lnselic, df)
summary(reg_n_linear_3)

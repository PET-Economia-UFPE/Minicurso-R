#para puxar os dados das ações 
install.packages("quantmod")
library(quantmod)

#para puxar os dados do ipeadata
install.packages("ipeadatar")
library(ipeadatar)

#para juntar os dados
install.packages("dplyr")
library(dplyr)

#para imprimir os gráficos
install.packages("ggplot2")
library(ggplot2)

#para fazer o teste de heterocedasticidade
install.packages("lmtest")  
library(lmtest)

#para regressão robusta
library(MASS)

#______________________________________________________

#selecionando os dados do ibovespa de 2015 para 2025
getSymbols("^BVSP", from = "2015-04-01", to = "2025-04-30")
getQuote("^BVSP")

#selecionando os dados de ajuste fechado (valores descontando os dividendos)
indice_mercado <- data.frame(BVSP$BVSP.Adjusted)
indice_mercado$date <- index(BVSP)
View(indice_mercado)

#dados diários da selic
dados_selic <- ipeadata("PAN12_TJOVER12")
names(dados_selic)[3] <- "selic"
dados_selic

#juntando dados do ibovespa e da selic
df <- inner_join(dados_selic,indice_mercado, by="date")

#regressão
modelo <- lm(BVSP.Adjusted ~ selic, df)
summary(modelo)
confint(modelo, lvel = 0.95)


ggplot(df, aes(x = selic, y = BVSP.Adjusted)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relação entre SELIC e Ibovespa", x = "SELIC (% a.a.)", y = "ibov") +
  theme_minimal()


#teste de homocedasticidade
#H0: homocedasticidade (variância constante dos resíduos).
#H1: Heterocedasticidade (variância não constante dos resíduos).

#se p-valor < 0.05, há heterocedasticidade
bptest(modelo)


#regressão robusta
model_rlm <- rlm(BVSP.Adjusted ~ selic, data = df)
summary(model_rlm)

ggplot(df, aes(x = selic, y = BVSP.Adjusted)) +
  geom_point(color = "red") +
  geom_smooth(method = "rlm", se = FALSE, color = "blue") +
  labs(title = "Relação entre SELIC e Ibovespa", x = "SELIC (% a.a.)", y = "ibov") +
  theme_minimal()

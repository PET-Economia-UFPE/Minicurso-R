#para puxar os dados do ipeadata
install.packages("ipeadatar")
library(ipeadatar)

#para juntar os dados
install.packages("dplyr")
library(dplyr)

#para imprimir os gráficos
install.packages("ggplot2")
library(ggplot2)

#Pacote para puxar os dados da PNAD contínua
install.packages("PNADcIBGE")
library(PNADcIBGE)

#para regressão robusta
library(MASS)

dados_pnad <- get_pnadc(year = 2024, 
                        quarter = 4, 
                        vars = c("V2007", "V2010", "VD3005", "VD4020"),
                        design = FALSE)

#dicionário de códigos da pnad contínua 
# https://www.econ.puc-rio.br/datazoom/english/files/pnadc/dicionario_das_variaveis_microdados_PNADC_maio_2015.xls


#códigos
#V2007: sexo 
#V2010: cor ou raça
#VD3005: anos de estudo
#VD4020: rendimento mensal

#criando um data frame apenas com as variáveis que eu quero
df <- data.frame(dados_pnad$V2007,dados_pnad$V2010, dados_pnad$VD3005, dados_pnad$VD4020)
View(head(df))

#alterando os códigos para os nomes das variáveis
names(df) <- c("sexo", "cor", "anos_estudo", "renda_mensal")
View(head(df))

#eliminando as células vazias
df_limpo <- na.omit(df)
View(df_limpo)

#fazendo uma cópia do data frame
copia_df <-data.frame(df_limpo)

#transformando dado de texto em número (variável sexo)
#mulher = 1 e homem = 0
df_limpo$sexo <- ifelse(df_limpo$sexo == "Mulher", 1, 0)

#transformando dado de texto em número (variável anos de estudo)
df_limpo$anos_estudo <- gsub("\\D", "", df_limpo$anos_estudo)

#transformando caractere em numérico
df_limpo$anos_estudo <- as.double(df_limpo$anos_estudo)

#transformando dado de texto em número (variável cor)
#Preta = 1, não preta = 0
df_limpo$cor <- ifelse(df_limpo$cor == "Preta", 1, 0)

head(df_limpo)

lm(renda_mensal ~ anos_estudo, df_limpo)

lm(renda_mensal ~ anos_estudo + sexo, df_limpo)

lm(renda_mensal ~ anos_estudo + sexo + cor, df_limpo)

#verificando viés de variável omitida:
# se o coeficiente angular for diferente de zero, há viés

lm(anos_estudo ~ sexo, df_limpo)

lm(anos_estudo ~ cor, df_limpo)

#Salvando resultados da regressão
reg_multipla <- lm(renda_mensal ~ anos_estudo + sexo + cor, df_limpo)
summary(reg_multipla)
confint(reg_multipla, lvel = 0.95)


#pegando os 100 primeiros valores para plotar no gráfico
df_simples <- head(df_limpo, 100)

#regressão linear simples
reg_simples <- lm(renda_mensal ~ anos_estudo, df_simples)
summary(reg_simples)
rd1<- summary(reg_simples)$r.squared

#linear log
linear_log_reg_simples <- lm(renda_mensal ~ log(anos_estudo), df_simples)
summary(linear_log_reg_simples)
rd2<- summary(linear_log_reg_simples)$r.squared

#log log
log_log_reg_simples <- lm(log(renda_mensal) ~ log(anos_estudo), df_simples)
summary(log_log_reg_simples)
rd3<- summary(log_log_reg_simples)$r.squared

log_linear_reg_simples <-lm(log(renda_mensal) ~ anos_estudo, df_simples)
summary(log_linear_reg_simples)
rd4 <-summary(log_linear_reg_simples)$r.squared


#gráfico 1 simples
ggplot(df_simples, aes(x =anos_estudo, y = renda_mensal))+
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  annotate("text",
           x = max(df_simples$anos_estudo) * 0.6,
           y = max(df_simples$renda_mensal) * 0.9,
           label =paste("R² =", round(rd1, 3)),  # Apenas o valor
           size = 5,
           color = "red") +
  labs(
    title = "Relação entre educação e Renda no Brasil 2024",
    x = "Anos de estudo",
    y = "Renda mensal (R$)" )+
  theme_minimal()


#gráfico 2 linear log
ggplot(df_simples, aes(x =anos_estudo, y = renda_mensal))+
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ log(x), se = FALSE, color = "blue") +
  annotate("text",
           x = max(df_simples$anos_estudo) * 0.6,
           y = max(df_simples$renda_mensal) * 0.9,
           label =paste("R² =", round(rd2, 3)),  # Apenas o valor
           size = 5,
           color = "blue") +
  labs(
    title = "Relação entre educação e Renda no Brasil 2024",
    x = "Anos de estudo",
    y = "Renda mensal (R$)" )+
  theme_minimal()

#gráfico 3 log linear
ggplot(df_simples, aes(x =anos_estudo, y = renda_mensal))+
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ exp(x), se = FALSE, color = "green") +
  annotate("text",
           x = max(df_simples$anos_estudo) * 0.6,
           y = max(df_simples$renda_mensal) * 0.9,
           label =paste("R² =", round(rd4, 4)),  # Apenas o valor
           size = 5,
           color = "darkgreen") +
  labs(
    title = "Relação entre educação e Renda no Brasil 2024",
    x = "Anos de estudo",
    y = "Renda mensal (R$)" )+
  theme_minimal()


#teste de heterocedasticidade
bptest(reg_multipla)

#regressão robusta
rlm(renda_mensal ~ anos_estudo + sexo + cor, df_limpo)

#comparando com regressão simples
lm(renda_mensal ~ anos_estudo + sexo + cor, df_limpo)
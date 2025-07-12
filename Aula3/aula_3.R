# Minicurso de Introdução ao R - 2025 - PET Economia UFPE
# Aula 2: Aplicações Intermediárias e Gráficos
# Ministrante: Julia Moura de Lima, Bolsista do PET Economia UFPE

# Observações importantes: 
# Depois que terminar alguma análise, lembre-se de limpar o seu enviroment para evitar problemas com variáveis duplicadas
# Sempre coloque o seu setwd()

setwd('C:/Users/julia/OneDrive/Documentos/Faculdade/PET/minicurso_r_2025')

# 1. Revisão: Vetores e Dataframes ####################################################################

# Vetores no R

# Um vetor é uma lista de itens do mesmo tipo:
# Vetor de texto (strings)
nomes <- c("Julia", "Luiz", "Pedro", "Brunna", "Thayssa")

# Vetor númerico
idades <- c(21, 22, 22, 20, 21)

# Vetor lógico 
natural_recife <- c(TRUE, FALSE, TRUE, TRUE, FALSE)

# Sequência (outro vetor númerico)
sequencia <- 1:10

sequencia2 <- seq(from = 2, to = 10, by = 2)

# Verificando
print(nomes)
print(idades)
print(natural_recife)
print(sequencia)
print(sequencia2)

# Acessando elementos de vetores
print(nomes[1])       # Acessa o primeiro elemento
print(idades[2:4])    # Acessa do segundo ao quarto elemento
print(idades[c(1, 4)]) # Acessa o primeiro e o quarto elemento

# Operações com Vetores
numeros <- c(10, 20, 30)

print(numeros * 2)   # Resultado: 20, 40, 60
print(numeros + 5)   # Resultado: 15, 25, 35

# Dataframes no R

# Os dataframes são como tabelas: tem uma estrutura de linhas e colunas, em que cada coluna é um vetor

# Boas práticas com dataframes/bases de dados: nomes em snake case (nome, nome_completo)

# Criando um df de exemplo
pets_julia <- data.frame(
  nome = c("Dora", "Chuchu", "Batata", "Linguiça"),
  cidade_nascimento = c("Recife", "Salvador", "Salvador", "Paudalho"),
  origem = c("Pet Shop", "Feira de Adoção", "Feira de Adoção", "Lixeira"),
  eh_gato = c(FALSE, TRUE, TRUE, TRUE)
)

print(pets_julia)

# Operações relevantes

names(pets_julia) # Nomes de colunas
str(pets_julia) # Estrutura do dataframe
head(pets_julia) # Primeiras linhas
tail(pets_julia) # últimas linhas
dim(pets_julia) # Dimensão do df
summary(pets_julia) # Resumo estatístico

# Acessando elementos

print(pets_julia$nome)
print(pets_julia$eh_gato)

# Selecionando linhas/colunas 
print(pets_julia[1, 2])      # Elemento da primeira linha, segunda coluna: "Recife"
print(pets_julia[1, ])       # Primeira linha, todas as colunas
print(pets_julia[, 1])       # Todas as linhas, primeira coluna (retorna um vetor)
print(pets_julia[, "nome"])  # Todas as linhas, coluna "Nome"
print(pets_julia[c(1, 3), c("nome", "eh_gato")]) # Linhas 1 e 3

# Extrair colunas como vetores
print(pets_julia[["cidade_nascimento"]]) # Similar a pets_julia$nome, retorna um vetor
print(meu_df[[1]])      # Primeira coluna como vetor

# 2. Instalação e Carregamento de Pacotes ####################################################################################

# Para instalar quaisquer pacotes, usamos o seguinte comando:
install.packages("ggplot2")

# Para instalar mais de um pacote, podemos criar um vetor:
install.packages(c("dplyr", "sidrar", "ipeadatar"))

# Depois de instalados, precisamos carregar os pacotes em todas as sessões
library(dplyr)
library(ggplot2)
library(sidrar)
library(ipeadatar)

# 3. Coleta de Dados com Pacotes (sidrar e ipeadatar) ###################################################

# 3.1. Pacote sidrar ########################################################################################################

# Função get_sidra
  # Parametros: Número da tabela, número da váriavel, período, classificação (opcional), categoria (opcional) 

# Como achar os parametros: Opções avançadas (no fim da página, botão de engrenagem) -> Listar identificadores

# Exemplo: taxa de participação na força de trabalho (tabela 5944)
tx_participacao <- get_sidra(5944, variable = 4096, period = c("last" = 12))

# Outra opção é usar os parâmetros da API
df2 <- get_sidra(api = "/t/5944/n1/all/v/4096/p/last%2013/d/v4096%201")

# Função search_sidra
pesquisa <- search_sidra("Ocupação")
print(pesquisa)

# Função info_sidra
info <- info_sidra(905, wb = TRUE)

df3 <- get_sidra(905, variable = 2164, period = '2014', classific = 'c12685', category = list(114607))

# Link para a documentação do sidrar: https://cran.r-project.org/web/packages/sidrar/vignettes/Introduction_to_sidrar.html
# Link para o SIDRA: https://sidra.ibge.gov.br/home

# 3.2. Pacote ipeadatar ################################################################################################################

# Função search_series
search <- search_series(terms = "PIB")

print(search)

# Função ipeadata
df <- ipeadata("PIBPMCE", language = 'br')

# Link para o site ipeadata: https://www.ipeadata.gov.br/Default.aspx
# Link para a documentação do ipeadatar (que não é muito útil): 

# 4. Leitura de .csv e .xlsx no R ###############################################################################################################

setwd("C:/Users/julia/OneDrive/Documentos/Faculdade/PET/minicurso_r_2025")

# Para ler .csv: read.csv
csv <- read.csv("gini.csv", sep = ";")

# Para ler .xls: 
xls <- readxl::read_excel("gini.xls")

# 5. Manipulação de Dados com o dplyr ###################################################################

# Operador pipe (%>%): permite encadear múltiplas operações de forma legível, passando o resultado da operação anterior como o primeiro argumento da próxima


# 5.1. select(): Selecionando e removendo colunas ---------------------------------------------------------------------------------------------------------------------
# Selecionando colunas

df <- get_sidra(5944, variable = 4096, period = c("last" = 12))
head(df)

df <- get_sidra(5944, variable = 4096, period = c("last" = 12))

df <- select(df, "Valor", "Unidade de Medida", "Trimestre Móvel (Código)")

df <- get_sidra(5944, variable = 4096, period = c("last" = 12)) %>%
  select(starts_with("Trimestre"), "Valor")

# Outros operadores: ends_with, contains, colX:colY, !, &, c()

# Removendo colunas
df <- get_sidra(5944, variable = 4096, period = c("last" = 12)) %>%
  select(!"Nível Territorial")

df <- get_sidra(5944, variable = 4096, period = c("last" = 12)) %>%
  select(!contains(c("Nível Territorial", "Brasil")))

#  5.2.filter(): filtrando dataframes pelas linhas --------------------------------------------------------------------------------------

# Por expressões (strings)
pib_estadual <- ipeadata("PIBPMCE", language = 'br')
head(pib_estadual)

pib_estadual <- ipeadata("PIBPMCE", language = 'br') %>%
  filter(uname == 'Regiões')

# Por números
gini <- readxl::read_excel("gini.xls")
head(gini)

summary(gini)

# Extra: mudando o nome das colunas com o colnames
colnames(gini)[2] <- "coef_gini"

gini_high <- filter(gini, coef_gini >= 0.55)

gini_mean <- filter(gini, coef_gini >= mean(coef_gini))

# 5.3. arrange() -----------------------------------------------------------------------------------------------------
gini_sorted <- arrange(gini, desc(coef_gini))

# 5.4. joins -----------------------------------------------------------------------------------------------------------------------------

# Vamos adicionar uma coluna indicando cada estado no df do PIB estadual

# Importando a tabela do pib estadual e filtrando as linhas com os estados
pib_estadual <- ipeadata("PIBPMCE", language = 'br') %>%
  filter(uname == 'Estados')

# Importando a tabela com os códigos de cada estado e selecionando só a coluna UF e Nome_UF
codigos <- readxl::read_excel("codigos_estados.xls")
codigos <- select(codigos, "UF", "Nome_UF")
codigos <- distinct(codigos)


colnames(codigos)[1] <- "tcode"

codigos$tcode <- as.integer(codigos$tcode)

pib_estados <- left_join(pib_estadual, codigos, by = "tcode")

# 5.1. mutate() -----------------------------------------------------------------

# Para exemplificar, vamos calcular a proporção do PIB total que cada estado representa

# Vamos selecionar só o ano de 2021

pib_estados <- pib_estados %>% select("date", "value", "Nome_UF")
                     
pib_estados <- pib_estados[grepl("2021", pib_estados$date), ]

pib_estados <- pib_estados %>% mutate(total = sum(value))

pib_estados <- pib_estados %>% mutate(proporcao = value/total)

pib_estados <- pib_estados %>% mutate(porcentagem = proporcao*100)

# 6. Vizualização de Dados com o ggplot2 ################################################################

plot(gini)
# Estrutura básica de um comando ggplot:
# ggplot(data = <DATA_FRAME>, mapping = aes(<MAPEAMENTOS_ESTÉTICOS>)) + <CAMADA_GEOMÉTRICA>()

# plot(gini) # Esta é a função base do R para gráficos, vamos usar ggplot2

# Filtra NAs e ordena os dados pela coluna 'Data'
gini_clean <- gini %>%
  filter(!is.na(coef_gini) & !is.na(Data)) %>%
  mutate(Data = as.numeric(Data)) %>% # Garante que 'Data' é numérica
  arrange(Data) # Ordena os dados pelo ano

# Passo 1: Gráfico básico com pontos e linhas
grafico_gini_basico <- ggplot(data = gini_clean, aes(x = Data, y = coef_gini)) +
  geom_line() + # Adiciona a camada de linha
  geom_point()  # Adiciona pontos nos dados observados
print(grafico_gini_basico)

# Passo 2: Melhorando o gráfico - adicionando cor, espessura da linha
grafico_gini_melhorado1 <- ggplot(data = gini_clean, aes(x = Data, y = coef_gini)) +
  geom_line(color = "blue", linewidth = 1) + # Linha azul e mais espessa
  geom_point(color = "darkblue", size = 2)   # Pontos azul escuro e maiores
print(grafico_gini_melhorado1)

# Passo 3: Adicionando Títulos e Rótulos aos Eixos
grafico_gini_final <- grafico_gini_melhorado1 +
  labs(title = "Evolução do Coeficiente de Gini no Brasil",
       subtitle = "Fonte: Ipea",
       x = "Ano",
       y = "Coeficiente de Gini")
print(grafico_gini_final)

# Passo 4: Customizando o tema (opcional)
grafico_gini_com_tema <- grafico_gini_final +
  theme_minimal() + # Um tema limpo
  theme(plot.title = element_text(hjust = 0.5), # Centraliza o título
        plot.subtitle = element_text(hjust = 0.5)) # Centraliza o subtítulo
print(grafico_gini_com_tema)

#---
## Gráfico de barras: participação de cada estado no PIB em 2021 
### Usaremos o dataframe `pib_estados`

# Passo 1: Gráfico de barras básico
# geom_col é usado quando você tem os valores y diretamente (uma barra por categoria)
# geom_bar é usado para contar ocorrências (histograma) ou se você precisa que o ggplot calcule a altura da barra
grafico_pib_basico <- ggplot(data = pib_estados, aes(x = Nome_UF, y = porcentagem)) +
  geom_col()
print(grafico_pib_basico)

# Passo 2: Melhorando a estética - preenchimento das barras
grafico_pib_melhorado1 <- ggplot(data = pib_estados, aes(x = Nome_UF, y = porcentagem)) +
  geom_col(fill = "steelblue") # Preenche as barras com uma cor
print(grafico_pib_melhorado1)

# Passo 3: Adicionando valores (rótulos) nas barras e títulos

grafico_pib_final <- ggplot(data = pib_estados, aes(x = Nome_UF, y = porcentagem)) +
  geom_col(fill = "skyblue", color = "black") + # Adiciona borda preta às colunas
  labs(title = "Participação das Macrorregiões no PIB Nominal",
       subtitle = "Ano de 2021 (Fonte: IPEADATA)",
       x = "Estado",
       y = "Participação no PIB (%)")
print(grafico_pib_final)

# Passo 4: Tema e ajustes finais (opcional)
grafico_pib_com_tema <- grafico_pib_final +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(grafico_pib_com_tema)

# 7. Links úteis e documentações ------------------------------------------------------------------------------------------------------

# Documentação dplyr:
# Documentação ggplot2:
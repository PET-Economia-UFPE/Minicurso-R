# use # para comentar

# palavras-chave 

keywords = "if
else
repeat
while
function
for
in
next
break
TRUE
FALSE
NULL
Inf
NaN
NA
NA_integer_             
NA_real_
NA_complex_
NA_character_
..."


### Operações Matemáticas
5 + 5  
8 - 4  
9 * 3  
9 / 3  
5**2   
5^2  
225^(1/2)  
sqrt(225)
exp(1)

#Retorna o Logaritmo Natural
log(100)

#Retorna o Logaritmo na base 10
log10(100)

?log


log(100, base = 10)

32 %% 5 
32 %/% 5

32/ 5

### Declaração
a <- 25
print(a)
a

b = 5
print(b)

a / b
c <- a / b
print(c)

7 -> d


### Tipos de Variáveis
## Doubles, Integers, Characters e Logical

# --------------------------------
#Strings/Characters
# --------------------------------

nome <- 'Milton'
sobrenome <- 'Friedman'

nome_completo <- paste(nome, sobrenome)
nome_completo

frase_1 <- sprintf('Meu Nome é %s', nome_completo) 
frase_1
#Não é possível
#frase_2 <- "Meu nome é "+ nome_completo


#maneira alternativa
frase_3 <- paste("Meu nome é", nome_completo)
frase_3

#juntando string sem espaço
sufixo <- "ano"
frase_4 <- paste("Juli", "ano")
frase_4
frase_4 <- paste("Juli", "ano", sep="")
frase_4

nome_completo 
#número de caracteres em uma string
nchar(nome_completo)            

#substitui, mas não altera a string original
sub('i', 'W', nome_completo)    
sub("Friedman", "Nascimento", nome_completo)
nome_completo

frase_5 <- sub("Friedman", "Nascimento", nome_completo)
frase_5

#substituição global
gsub('i', 'W', nome_completo)   

#verifica se tem um caractere na string
grepl("Milt", nome_completo)

#divdir a string
strsplit(nome_completo, " ")

nomes <- "Maria, João, Carlos, Bruno"
nomes
#
nomes_s <- strsplit(nomes, ",")
nomes_s


nome_completo
#todos os caracteres mailúsculos
toupper(nome_completo)          

#todos os caracteres minúsculos
tolower(nome_completo)

#ler algo do prompt
readline(prompt = "Digite seu nome: ")

#salvar a leitura em uma variável
individuo <- readline(prompt = "Digite seu nome: ")
individuo

# --------------------------------
#Doubles/Integers
# --------------------------------


#inteiro
idade <- 20
typeof(idade)

idade2 <- 19L
typeof(idade2)
#class(idade2)

#double
nota <- 8.75
typeof(nota)

#notação científica
not_cie <- 3.12e15
#3.12×10^15

#transformando double em inteiro
nota
typeof(nota)
as.integer(nota)
nova_nota <- as.integer(nota)
typeof(nova_nota)

#arredondando valores
nota
round(nota, digits = 0)

#arredondando para o maior inteiro
ceiling(nota)

#arredondando para o menor inteiro
floor(nota)

# --------------------------------
# Logical
# --------------------------------

logico <- TRUE
NA
NULL
NaN

### Operações Lógicas
num <- 10

num == 10
num != 10
num > 10
num >= 10
num < 10
num <= 10
!(num != 10) # Negação

#e
num != 10 & num > 10
num == 10 & num >= 10
num == 10 & num > 10

#ou
num != 10 | num > 10
num == 10 | num >= 10
num == 10 | num > 10


### Estruturas de Dados
## Vectors, Lists, Factors

# --------------------------------
# Vectors
# --------------------------------

doubles <- c(-5.0, 5.0, -15.0, 35.0, -45.0)
doubles

35 %in% doubles

#organizar na ordem crescente
sort(doubles)

#organizar na ordem decrescente
sort(doubles, TRUE)

inteiros <- c(-5L, 5L, 15L, 25L, 35L, 45L)
inteiros

strings <- c('Minicurso', 'de', 'R','PET', 'Economia', 'UPE')
strings
strings[4]
strings[6] <- 'UFPE'
strings
strings[7] <- 'AULA 2'
strings

strings[-7]
strings <- strings[-7]
strings

logicos <- c(FALSE, FALSE, FALSE, TRUE, TRUE, TRUE)

#selecionando dados de um vetor
texto <- "Família não consegue embarcar pela 2ª vez com cão de serviço e criança autista sofre com a falta do animal"
texto
texto_string <- strsplit(texto, " ")[[1]]
texto_string

#os 5 primeiros valores
head(texto_string)

#os 5 últimos valores
tail(texto_string)

length(texto_string)


# --------------------------------
# Vetores Númericos
# --------------------------------

notas <- c(9.0, 8.5, 4.5, 5.0, 7.5, 8.5, 5.0, 9.0, 9.0)

#criar uma sequencia de x a y, contando de 0.1
seq(0, 100, 0.1)
sequencia <- seq(0, 100, 0.1)
sequencia
#deletar lista
rm(sequencia)

#sequencia de 100 a 200
100:200
sequencia2 <- 100:200
sequencia2
rm(sequencia2)

notas 
sum(notas)
max(notas)
min(notas)
mean(notas)
var(notas)
#desvio padrão amostral
sd(notas)

# Vetores de Strings
nomes <- c('Pedro', 'Luiz', 'Laís', 'Brunna')
nomes

numeros <- c(1, 2, 3, 5, "8")
numeros

# Lists
nome <- 'João'
idade <- 55
notas <- c(10, 8.5, 7, 5, 4.5)
aluno <- list(nome, idade, notas)
print(aluno)

aluno[1]
aluno[[1]]
aluno[3]
aluno[[3]][1]

aluno[2] <- 21
aluno

aluno[4] <- 'APROVADO'
aluno
aluno <- aluno[-4]
aluno

#dar nome aos elementos das listas
names(aluno) <- c('nome', 'idade', 'notas')

aluno

aluno$nome
aluno$notas
aluno$notas[1]

# --------------------------------
# Fatores
# --------------------------------
#são "listas" que colocam os valores em ordem

pet <- c('weena', 'pedro', 'brunna', 'lais')
ano <- c(2025, 2004, 2016, 2024)
fator_1 <- factor(pet)
fator_1
fator_2 <- factor(ano)
fator_2

levels(fator_1)
levels(fator_2)

typeof(fator_1)
typeof(fator_2)

as.numeric(fator_1)
as.numeric(fator_2)

# --------------------------------
### Loops
# --------------------------------

# --------------------------------
## For
# --------------------------------
for (variable in vector) {
  
}

for (i in seq(1:10)) {
  
  print(i)
  
}

nomes <- c('Pedro', 'Giulia', 'Hugo', 'Celso')
for (i in nomes) {
  
  print(sprintf('Meu nome é %s', i))
  
}

fibonacci <- c(1, 1)

for (i in 3:20) {
  
  fibonacci[i] <- fibonacci[i-1] + fibonacci[i-2]
}

fibonacci


# --------------------------------
## while
# --------------------------------

while (condition) {
  
}


j <- 0
while (j < 20) {
  
  j <- j + 1
  print(j)
}

#loop infinito
j <- 0
while (j < 20) {
  j <- j - 1
  
  print(j)
}

### Condicional
## If, Else e Else If

if (condition){
  
} else if(condition){
  
} else{
  
}

b
if(b < 10) {
  print('Olá Mundo')
}

if(b > 10) {
  print('Hello World')
} else{
  print('No speak English')
}


b <- 9
if(b > 10) {
  print('Hello World')
} else if(b == 8){
  print('tente novamente')
} else{
  print('Still no speak English')
}

#***************************
#criando um codigo para adivinhar um valor de zero a 10
#***************************

#criar uma variável aleatória de 1 a 10, qtd 1
aleatoria <- sample(10, 1)

chute <- 0
while (chute != aleatoria) {
  chute <- readline(prompt = 'Diga um Valor: ')
  
  chute <- as.numeric(chute)
  
  if(chute == aleatoria) {
    print('GANHOUU!!!!')
  } else if((chute == aleatoria - 1) | (chute == aleatoria + 1)){
    print('QUASEEE')
  } else{
    print('ERRADO')
  }
}

cachorro <- "REPETE"
continua <- TRUE
while (continua == TRUE){
  text <- readline(prompt="Tinha dois cachorros: pet e repete. \nO pet morreu, quem ficou vivo?")
  text <- toupper(text)
  if(grepl(cachorro, text)){
    continua <- TRUE
  }else{
    print(" hahaha")
    continua <- FALSE
  } 
} 


### Funções
nome_da_funcao <- function(atributos) {
  
}

# x² - 6x + 5 = 0
(-(-6) + (sqrt((-6)^2 - 4*1*5))) / 2*1
(-(-6) - (sqrt((-6)^2 - 4*1*5))) / 2*1

eq_seg_grau <- function(a, b, c){
  
  x_1 <- (-b + (sqrt((b^2) - 4*a*c))) / (2*a)
  x_2 <- (-b - (sqrt((b^2) - 4*a*c))) / (2*a)
  
  print(x_1)
  print(x_2)
}

#x² -6x + 5 = 0
eq_seg_grau(1, -6, 5)

#x² -6x + 9 =0
eq_seg_grau(1, -6, 9)

#-3x² -8x +9=0 
eq_seg_grau(-3, -8, +9)


set.seed(1998)
notas <- sample(0:10, 200, replace = TRUE)
notas

automacao <- function(...){
  x <- c(...)
  resultado <- c()
  for (nota in x) {
    if(nota >= 7){
      resultado <- c(resultado, 'Aprovado')
  
    } else if(nota >= 3){
      resultado <- c(resultado, 'Prova Final')
    } else{
      resultado <- c(resultado, 'Reprovado')
    }
  }
  return(resultado)
}

automacao(notas)
automacao(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)





#Automação certificado

nomes_minicurso <- c('Maria', 'João', 'Paulo', 'Pedro')
frequencia <- c(4, 1, 2, 4)
minicurso_r <- list(nomes_minicurso,frequencia)
names(minicurso_r) <- c('Nomes', 'Frequencia')
minicurso_r

automacao_certificado <- function(...){
  x <- ...$Frequencia
  resultado <- c()
  for (freq in x) {
    if(freq >= 4){
      resultado <- c(resultado, 'Recebe Certificado')
      
    } else{
      resultado <- c(resultado, 'Não Recebe Certificado')
    }
  }
  return(resultado)
}

minicurso_r$resultado <- automacao_certificado(minicurso_r)
minicurso_r



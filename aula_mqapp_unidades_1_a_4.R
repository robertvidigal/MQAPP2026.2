# =============================================================================
# MQAPP 2026.2 | Aula prática de R | Unidades 1 a 4
# Estatística descritiva, probabilidade, inferência, correlação e regressão
# =============================================================================
# Não é necessário instalar pacotes, baixar dados ou usar internet.
# Dados simulados: os resultados não representam uma política pública real.
# Referência: slides das Unidades 1 a 4 da disciplina MQAPP 2026.2.
#
# Não é necessário digitar cada linha do arquivo.
#
# COMO USAR NO RSTUDIO
# 1. Abra este arquivo em File > Open File. Salve suas anotações no script.
# 2. Execute uma linha/seleção com Ctrl+Enter (Windows/Linux) ou Cmd+Enter (Mac).
# 3. Veja resultados no Console, objetos em Environment e gráficos em Plots.
# 4. Siga a ordem: blocos posteriores dependem dos objetos anteriores.
# 5. Texto após # é comentário: explica o código e não é executado.
# 6. Se aparecer + no Console, há um comando incompleto: confira aspas/parênteses.
#    Esc cancela o comando incompleto. R diferencia maiúsculas de minúsculas.
#
# 0. Começando devagar: o R como calculadora ----
2 + 2 # adição
10 - 3 # subtração
4 * 5 # multiplicação
20 / 4 # divisão
2^3 # 2*2*2 potenciação
sqrt(25) # raíz-quadrada
(2 + 3) * 4  # parênteses definem a ordem
2 + 3 * 4

# Use ponto decimal: 2.5. Vírgulas separam argumentos, como em c(2, 5).
2.5 * 5 # 2,5 * 5
9000000
0.00001

# 0.1 Objetos: guardar um resultado para usar depois ----
idade <- 20
idade
print(idade)
?print

idade + 1

# O cálculo acima não muda o objeto. Para atualizá-lo, atribua novamente:
idade2 <- idade + 1
idade2

nome <- "Ana"   # texto entre aspas
nome

participou <- TRUE  # valor lógico: TRUE ou FALSE

# Função de classe 
class(idade)
class(nome)
class(participou)

# Use nomes como media_renda, sem espaços. <- guarda; == compara.
idade == 21 # é igual?
idade > 18
idade < 15
idade != 21 # != é diferente?

# 0.2 Vetores: várias observações em um objeto ----
notas_exemplo <- c(40, 50, 60, 70, 80)
notas_exemplo

length(notas_exemplo)
sum(notas_exemplo)

sum(notas_exemplo) / length(notas_exemplo)

mean(notas_exemplo)

min(notas_exemplo)
max(notas_exemplo)

nomes_exemplo <- c("Pedro", "João", "Antonio")
nomes_exemplo

sequencia <- c(1:9, 12:15, 20:34)
sequencia

vetor_exemplo <- c("Ana", 13, TRUE)
vetor_exemplo

# Uma função recebe argumentos entre parênteses e devolve um resultado.
# digits = 2 é um argumento nomeado. Para abrir a ajuda: ?mean (opcional).
mean(c(5, 7, 8))

round(mean(c(5, 7, 8)), digits = 1)
?mean
?round

### 0.3 Seleção e operações lógicas ----
notas_exemplo
notas_exemplo[1] # primeira observação; a contagem começa em 1
notas_exemplo[c(1, 3)]

notas_exemplo[2:4]     # 2:4 puxa elementos 2, 3, 4

notas_exemplo >= 50    # uma comparação para cada observação
!(notas_exemplo >= 50) # ! é igual NÃO: inverte a condição

notas_exemplo[notas_exemplo >= 50]

sum(notas_exemplo >= 50)   # TRUE vale 1; FALSE vale 0 na soma
mean(notas_exemplo >= 50)  # proporção que atende ao critério

notas_exemplo[notas_exemplo >= 50 & notas_exemplo <= 70]  # E: ambos verdadeiros

notas_exemplo[notas_exemplo < 50 | notas_exemplo > 70] # OU: pelo menos um verdadeiro

# 0.4 Pequena tabela/dataframes: linhas são pessoas, colunas são variáveis ----
turma <- data.frame(
  nome = c("Antônia", "Bruno", "Simone", "Diego", "Eva"),
  nota = notas_exemplo,
  presencas = c(8, 6, 9, 10, 7)
  )

print(turma)
turma
View(turma)

names(turma)
nrow(turma)
ncol(turma)

# $ seleciona uma coluna pelo nome
turma$nota                
turma$nome

turma[c(1,3), ] # [linhas, colunas]; vazio significa todas
turma[      ,"nome"]
turma[, c("nome", "presencas")]
turma[turma$nota >= 50, c("nome", "nota")]

# Criando uma coluna lógica
turma$aprovado <- turma$nota >= 50   
turma$extra <- NA
turma$extra <- 1
turma

# A notação y ~ x será usada mais adiante: 'y em função de x'.

# 0.5 Ausentes e um primeiro gráfico ----
rendas_exemplo <- c(1500, 1800, NA, 2200, 3000)
is.na(rendas_exemplo)
sum(is.na(rendas_exemplo))
mean(rendas_exemplo)                # retorna NA
mean(rendas_exemplo, na.rm = TRUE)  # usa apenas as rendas conhecidas

plot(x = turma$presencas, y = turma$nota, 
     pch = 19, cex = 4, col = "purple",
     xlab = "Presenças em sala", 
     ylab = "Nota final", 
     main = "Primeiro gráfico de exemplo: turma fictícia")
?plot

### Exercício: crie um vetor com 4 notas de 0 a 100. 
### Calcule a média e selecione as notas >= 50. 
### Use outro nome para preservar as notas originais.

notasteste <- c(30, 50, 100, 90, 80)
mean(notasteste[notasteste >= 50])

# 0.6 Amostragem, funções e repetição: ler antes das simulações ----
# set.seed() não faz todo sorteio ser igual: reinicia uma sequência reproduzível.
set.seed(70904970)  # torna os sorteios reproduzíveis ao executar na mesma ordem
sample(1:10, size = 4, replace = FALSE)  # sorteio sem reposição
sample(1:10, size = 4, replace = TRUE)   # com reposição: pode repetir valores

# FUNÇÃO: reúne comandos e permite reutilizá-los.
dobrar <- function(meu_numero) {
  2 * meu_numero
}
dobrar(3)
dobrar(c(2, 4, 6))

# for repete comandos, mudando i. É uma leitura guiada pelo docente.
for (i in 5:10) {
  print(i * 10)
}

# 0.7 Construindo e conhecendo a pesquisa ----
# Leitura: data.frame() monta a tabela; factor() registra categorias;
# levels() define seus níveis e ordered() registra uma ordem substantiva.

# rnorm() e rlnorm() são geradores aleatórios usados apenas para criar o exemplo.
# Criamos uma população FINITA fictícia de 10 mil pessoas elegíveis.

# No experimento simulado, a oferta de capacitação é aleatória.
# O resultado é um índice contínuo de conhecimento, em pontos.

# A população abaixo é conhecida porque nós construímos por simulação.
# Em uma pesquisa real, não conheceríamos a população nem os efeitos verdadeiros.
set.seed(20262)

N <- 10000
populacao <- data.frame(
  id = seq_len(N),
  escolaridade = sample(4:20, N, replace = TRUE),
  renda = round(rlnorm(N, meanlog = log(2200), sdlog = 0.65), 2),
  grupo = factor(sample(c("Controle", "Capacitacao"), N, replace = TRUE),
                 levels = c("Controle", "Capacitacao")),
  satisfacao = ordered(sample(c("Baixa", "Media", "Alta"), N, replace = TRUE),
                       levels = c("Baixa", "Media", "Alta"))
)

head(populacao); tail(populacao) # ; executa mais de uma função em uma linha só

View(populacao)  # opcional: abre uma aba de dados no RStudio

populacao$pontuacao <- 30 + 1.8 * populacao$escolaridade +
  5 * (populacao$grupo == "Capacitacao") + rnorm(N, mean = 0, sd = 8)

min(populacao$pontuacao)
max(populacao$pontuacao)
mean(populacao$pontuacao)

head(populacao$pontuacao)

# Uma amostra aleatória simples, sem reposição, é nossa base de análise.
n <- 180
dados <- populacao[sample.int(N, n, replace = FALSE), ]
dados
rownames(dados) <- NULL

head(dados)
str(dados) # strucutre
dim(dados) # dimension
ncol(dados); nrow(dados)

# Inserimos quatro rendas ausentes para aprender a reconhecer NAs.
dados$renda[sample.int(n, 4)] <- NA_real_

# Não usamos == NA: valores desconhecidos são identificados com is.na().
head(is.na(dados$renda))
table(is.na(dados$renda))

table(dados$satisfacao)

# Unidade de análise: indivíduos. 
# População: pessoas fictícias 10000; amostra: 180 pessoas.
# Grupo: nominal; satisfacao: ordinal; escolaridade: anos completos (discreta);
# Renda e pontuação: quantitativas contínuas (renda registrada em centavos).
# id é identificador: calcular sua média não tem interpretação substantiva.
# A satisfação foi gerada independentemente: não é avaliação da capacitação.

# # -----------------------------------------------------------------------
# UNIDADE 1. Mensuração, frequências e estatística descritiva ----
# # -----------------------------------------------------------------------
### 1.1 Frequências absolutas, relativas e acumuladas
frequencia_grupo <- table(dados$grupo)
frequencia_grupo

round(100 * prop.table(frequencia_grupo), 1)
frequencia_satisfacao <- table(dados$satisfacao)
frequencia_satisfacao

# Frequência acumulada exige uma ordem substantiva, como Baixa < Media < Alta.
cumsum(prop.table(frequencia_satisfacao))

### 1.2 Média, mediana e moda
mean(dados$pontuacao)
median(dados$pontuacao)

# mode() em R informa o modo de armazenamento, não a moda estatística.
# Podemos identificar todas as categorias que empatam na maior frequência:
nomes_modais <- names(frequencia_satisfacao)[frequencia_satisfacao == max(frequencia_satisfacao)]
nomes_modais

### 1.3 Dispersão: variância e desvio padrão amostrais, amplitude e quartis
var(dados$pontuacao)  # denominador n - 1
sd(dados$pontuacao)
# O desvio padrão está em pontos; a variância está em pontos ao quadrado.

range(dados$pontuacao)
diff(range(dados$pontuacao))
quantile(dados$pontuacao)

### 1.4 Ausentes e assimetria
sum(is.na(dados$renda))
mean(dados$renda)  # NA: há valores desconhecidos
mean(dados$renda, na.rm = TRUE)
median(dados$renda, na.rm = TRUE)
sum(!is.na(dados$renda))  # denominador efetivamente observado
# na.rm = TRUE exclui ausentes do cálculo, mas não corrige viés de não resposta.
# Aqui a ausência foi introduzida aleatoriamente; na prática, a ausência pode não ser aleatória.

### 1.5 Gráficos e comparação descritiva
barplot(frequencia_satisfacao, col = c("gray80", "skyblue", "steelblue"),
        main = "Satisfação na amostra simulada", ylab = "Número de pessoas")
hist(dados$renda, breaks = 15, col = "lightblue", border = "white",
     main = "Distribuição da renda simulada", xlab = "Renda mensal em reais")
boxplot(pontuacao ~ grupo, data = dados, col = c("gray85", "lightgreen"),
        main = "Conhecimento por grupo", ylab = "Pontuação")
aggregate(pontuacao ~ grupo, data = dados,
          FUN = function(x) c(n = length(x), media = mean(x), dp = sd(x)))

# PERGUNTA 1: por que a média da renda pode superar a mediana?

# 1.6 Frequência agrupada: da renda individual às faixas ----
# Retomada dos slides: intervalos com frequência, percentual e acumulada.
# Usamos somente rendas observadas e limites que cobrem todos os valores.
renda_observada <- dados$renda[!is.na(dados$renda)]
limites_renda <- seq(0, max(renda_observada) + 1000, by = 1000)
faixas_renda <- cut(renda_observada, breaks = limites_renda,
                   right = FALSE, include.lowest = TRUE)
# [0,1000) significa 0 <= renda < 1000. As faixas não se sobrepõem.
freq_renda <- table(faixas_renda)
tabela_renda <- data.frame(
  faixa = names(freq_renda),
  frequencia = as.numeric(freq_renda),
  percentual = 100 * as.numeric(prop.table(freq_renda)),
  percentual_acumulado = 100 * cumsum(as.numeric(prop.table(freq_renda)))
)
tabela_renda
# Denominador: 176 rendas observadas, não todas as 180 pessoas.
# Pergunta: qual percentual das rendas observadas está abaixo de R$ 3.000?
mean(renda_observada < 3000) * 100

# 1.7 Percentil e posição percentílica são perguntas diferentes ----
quantile(dados$pontuacao, probs = c(0.25, 0.50, 0.75, 0.90), type = 7)
# Aqui usamos a interpolação padrão do R, type = 7; outras convenções podem
# produzir resultados diferentes, principalmente em amostras pequenas.
percentual_ate_70 <- mean(dados$pontuacao <= 70) * 100
percentual_ate_70
# quantile: parte de uma porcentagem e encontra uma pontuação.
# mean(X <= 70): parte da pontuação e encontra a porcentagem acumulada até ela.
IQR(dados$pontuacao)  # distância entre os percentis 75 e 25

# 1.8 Valores extremos: demonstração em uma cópia ----
renda_com_extremo <- c(renda_observada, 1000000)
comparar_resumos <- function(x) {
  c(media = mean(x), mediana = median(x), dp = sd(x))
}
rbind(original = comparar_resumos(renda_observada),
      com_extremo = comparar_resumos(renda_com_extremo))
# A mediana é menos sensível a um valor muito alto. A base 'dados' não foi alterada.
# Valor extremo não significa erro: investigue o registro antes de excluí-lo.
# Exercício curto U1: faça uma tabela com faixas de escolaridade de 4 anos.
# Comece pelos limites c(4, 8, 12, 16, 21), para incluir os 20 anos.

# # -----------------------------------------------------------------------
# UNIDADE 2. Probabilidade e amostragem ----
# # -----------------------------------------------------------------------
### 2.1 Probabilidades empíricas e condicionais
# Definimos 'pontuação alta' como pontuação >= 65, para este exercício.
dados$alta <- dados$pontuacao >= 65
tabela <- table(Grupo = dados$grupo, Alta = dados$alta)
tabela

mean(dados$alta)                                  # P(alta) na amostra
prop.table(tabela)                                # probabilidades conjuntas
prop.table(tabela, margin = 1)                    # P(alta | grupo)
mean(dados$alta[dados$grupo == "Capacitacao"])
# Condicionar muda o denominador: o último comando considera só a capacitação.
# Sob independência, P(alta | capacitação) seria igual a P(alta) na população.
# Igualdade aproximada na amostra não prova independência; diferenças também
# podem refletir variação amostral. Esta comparação é descritiva.

### 2.2 Escore z e distribuição normal de referência
# Exemplo TEÓRICO separado: X ~ Normal(média = 60, desvio padrão = 10).
# Não assumimos que toda pontuação observada segue exatamente essa normal.
z_75 <- (75 - 60) / 10
z_75
pnorm(75, mean = 60, sd = 10)                     # P(X <= 75)
pnorm(75, mean = 60, sd = 10, lower.tail = FALSE) # P(X > 75)
pnorm(70, 60, 10) - pnorm(50, 60, 10)             # P(50 < X <= 70)
qnorm(0.95, mean = 60, sd = 10)                   # percentil 95
curve(dnorm(x, mean = 60, sd = 10), from = 20, to = 100,
      main = "Distribuição normal de referência", xlab = "X", ylab = "Densidade")
# dnorm fornece densidade, não a probabilidade de um valor pontual.

### 2.3 Distribuição amostral da média e Teorema do Limite Central
# A renda é assimétrica. Repetimos amostras COM reposição para representar
# sorteios independentes da distribuição empírica da população fictícia.
# Não são novas amostras da tabela 'dados': sorteamos da população conhecida.
set.seed(20263)
B <- 1500
tamanhos <- c(5, 30, 100)
medias_simuladas <- lapply(tamanhos, function(tamanho) {
  replicate(B, mean(sample(populacao$renda, tamanho, replace = TRUE)))
})
# sd(população) usa N-1; para o DP exato da distribuição finita usamos N.
media_pop <- mean(populacao$renda)
dp_pop <- sqrt(mean((populacao$renda - media_pop)^2))
resumo_tlc <- data.frame(
  n = tamanhos,
  media_das_medias = vapply(medias_simuladas, mean, numeric(1)),
  erro_padrao_simulado = vapply(medias_simuladas, sd, numeric(1)),
  erro_padrao_teorico = dp_pop / sqrt(tamanhos)
)
resumo_tlc
media_pop
# A média amostral varia. Seu erro padrão diminui aproximadamente com 1/sqrt(n).
# O TLC trata da distribuição das MÉDIAS; a renda individual continua assimétrica.
# Não existe garantia universal de normalidade só porque n chegou a 30.
mostrar_tlc <- function() {
  configuracao <- par(mfrow = c(1, 3))
  on.exit(par(configuracao))
  limites <- range(unlist(medias_simuladas))
  for (j in seq_along(tamanhos)) {
    hist(medias_simuladas[[j]], breaks = 25, xlim = limites,
         main = paste("Médias com n =", tamanhos[j]),
         xlab = "Média da renda", ylab = "Frequência",
         col = "lightblue", border = "white")
    abline(v = media_pop, col = "red", lwd = 2)
  }
}
mostrar_tlc()

# PERGUNTA 2: para reduzir o erro padrão à metade, como precisa mudar n?

# 2.4 Padronizar os próprios dados não é normalizá-los ----
dados$z_pontuacao <- as.numeric(scale(dados$pontuacao))
head(dados[c("id", "pontuacao", "z_pontuacao")])
c(media_z = mean(dados$z_pontuacao), dp_z = sd(dados$z_pontuacao))
dados[dados$z_pontuacao > 2, c("id", "pontuacao", "z_pontuacao")]
# scale() subtrai a média amostral e divide pelo DP amostral.
# Z positivo: acima da média. Z negativo: abaixo. |Z| > 2: mais de dois DPs.
# A transformação preserva a forma da distribuição; não cria normalidade.
# Não use automaticamente pnorm(z) como percentil empírico de qualquer variável.
# Também podemos voltar à escala original:
mean(dados$pontuacao) + 2 * sd(dados$pontuacao)

# Exercício curto U2: qual proporção tem z_pontuacao < -1?

# # -----------------------------------------------------------------------
# UNIDADE 3. Hipóteses, intervalos de confiança e testes t ----
# # -----------------------------------------------------------------------
### 3.1 Uma amostra: 
# H0: média populacional da pontuação = 60; 
# H1: diferente de 60.

# Referência de 60 pontos escolhida apenas para fins didáticos.
# Fixamos alfa antes de observar o teste; adotamos teste bilateral.
alfa <- 0.05
teste_uma <- t.test(dados$pontuacao, mu = 60, conf.level = 1 - alfa)
teste_uma

# Construção manual: estimativa +/- t crítico * erro padrão estimado.
#n_valido <- sum(!is.na(dados$pontuacao))
#media_amostral <- mean(dados$pontuacao)
#erro_padrao <- sd(dados$pontuacao) / sqrt(n_valido)
#t_observado <- (media_amostral - 60) / erro_padrao
#margem <- qt(1 - alfa / 2, df = n_valido - 1) * erro_padrao
#ic_manual <- media_amostral + c(-1, 1) * margem
#c(media = media_amostral, erro_padrao = erro_padrao, t = t_observado)
#ic_manual
#2 * pt(-abs(t_observado), df = n_valido - 1)

### 3.2 Duas amostras independentes: teste t de Welch
# H0: média da capacitação - média do controle = 0.
# H1: essa diferença é diferente de zero. 
capacitacao <- dados$pontuacao[dados$grupo == "Capacitacao"]
controle <- dados$pontuacao[dados$grupo == "Controle"]
teste_duas <- t.test(capacitacao, controle, 
                     var.equal = FALSE,
                     conf.level = 1 - alfa)
teste_duas

# Passar os vetores nesta ordem define a diferença: capacitação MENOS controle.
diferenca <- mean(capacitacao) - mean(controle)
c(diferenca_em_pontos = diferenca, p_valor = teste_duas$p.value)
teste_duas$conf.int
if (teste_duas$p.value <= alfa) {
  cat("Decisão: rejeitar H0 ao nível de 5%.\n")
} else {
  cat("Decisão: não rejeitar H0 ao nível de 5%.\n")
}

# O p-valor é a probabilidade, SOB H0 e os pressupostos, de uma estatística
# tão ou mais extrema que a observada. Não é a probabilidade de H0 ser verdadeira.

# Um IC de 95% vem de um procedimento que cobre o parâmetro em 95% das
# repetições sob os pressupostos. Não contém 95% dos resultados individuais.

# Significância não mede relevância.

# Erro tipo I: rejeitar H0 verdadeira (falso positivo). 
# Erro Tipo II: não rejeitar H0 falsa (falso negativo).

# PERGUNTA 3: escreva uma conclusão de duas frases com a diferença e IC.

# 3.3 Teste agrupado de Student: reproduzindo as contas dos slides ----
# Pressuposto adicional: mesmas variâncias populacionais nos dois grupos.

# Tamanhos amostrais diferentes são permitidos. A base tem pontuações completas.
n1 <- length(capacitacao)
n2 <- length(controle)
sq1 <- sum((capacitacao - mean(capacitacao))^2)
sq2 <- sum((controle - mean(controle))^2)
gl_agrupado <- n1 + n2 - 2
variancia_agrupada <- (sq1 + sq2) / gl_agrupado
# Forma equivalente: [(n1-1)*var(x1) + (n2-1)*var(x2)] / (n1+n2-2).
ep_diferenca <- sqrt(variancia_agrupada * (1/n1 + 1/n2))
t_agrupado <- diferenca / ep_diferenca
p_agrupado <- 2 * pt(-abs(t_agrupado), df = gl_agrupado)
t_critico <- qt(1 - alfa/2, df = gl_agrupado)
ic_agrupado <- diferenca + c(-1, 1) * t_critico * ep_diferenca
c(variancia_agrupada = variancia_agrupada, EP = ep_diferenca,
  t = t_agrupado, gl = gl_agrupado, p = p_agrupado)
ic_agrupado

# Conferência com a função pronta:
teste_student <- t.test(capacitacao, controle, var.equal = F)
teste_student

# 3.4 A pergunta define a cauda: unilateral e bilateral ----
# Exemplo direcional, definido antes da análise: a oferta aumenta a pontuação?
# H0: média_cap - média_cont <= 0; 
# H1: média_cap - média_cont > 0.

# Cálculo da distribuição de referência na fronteira: diferença = 0.
teste_direita <- t.test(capacitacao, controle, var.equal = TRUE,
                        alternative = "greater")
teste_direita

c(p_bilateral = teste_student$p.value, p_direita = teste_direita$p.value)

# Um teste unilateral na direção oposta pode produzir p próximo de 1.

# O IC de t.test(..., alternative = "greater") é unilateral; não o confunda
# com o IC bilateral de 95%. 

# 3.5 A hipótese nula pode estabelecer outra diferença ----
# Agora H0: média_cap - média_cont = 1 ponto; 
# H1: diferente de 1.
# É um EXEMPLO separado de hipótese bilateral, não uma nova busca por p pequeno.

# Em dois vetores, mu indica a diferença de referência, não a média de um grupo.
teste_delta_1 <- t.test(capacitacao, controle, mu = 1, var.equal = TRUE)
teste_delta_1
# O IC aqui continua sendo para a diferença entre as médias.

# 3.6 Desenhar os ICs de 95% e 99% com os mesmos dados ----
ic95 <- as.numeric(teste_student$conf.int)
ic99 <- as.numeric(t.test(capacitacao, controle, var.equal = TRUE,
                         conf.level = 0.99)$conf.int)
rbind(IC95 = ic95, IC99 = ic99)
c(largura95 = diff(ic95), largura99 = diff(ic99))
plot(rep(diferenca, 2), c(1, 2), xlim = range(c(ic95, ic99, 0)),
     ylim = c(0.5, 2.5), yaxt = "n", pch = 19,
     xlab = "Diferença: capacitação menos controle (pontos)", ylab = "",
     main = "Mesmos dados, níveis de confiança diferentes")
axis(2, at = c(1, 2), labels = c("95%", "99%"), las = 1)
segments(ic95[1], 1, ic95[2], 1, col = "steelblue", lwd = 3)
segments(ic99[1], 2, ic99[2], 2, col = "darkgreen", lwd = 3)
abline(v = 0, lty = 2)

# Mais confiança exige valor crítico maior e IC mais amplo, mantendo os dados.
# Aumentar n tende a estreitar o IC; aumentar a dispersão tende a ampliá-lo.

# Nos ICs bilaterais correspondentes ao mesmo teste, excluir zero equivale a
# rejeitar a hipótese de diferença zero ao nível alfa correspondente.

# 3.7 Poder estatístico: planejamento para um efeito de interesse ----
# Tipo I: rejeitar H0 verdadeira. 
# Tipo II: não rejeitar H0 falsa.

# Poder = 1 - beta, para um efeito ESPECÍFICO, desenho, alfa e tamanho amostral.

# Exemplo: detectar 5 pontos com D.P. de 12 em grupos independentes,
# teste bilateral com alfa = 0.05. São valores hipotéticos prévios.

# power.t.test() para type = "two.sample" usa n POR GRUPO e variância comum.
poder_30 <- power.t.test(n = 30, delta = 5, sd = 12, sig.level = 0.05,
                         type = "two.sample", alternative = "two.sided")
poder_100 <- power.t.test(n = 100, delta = 5, sd = 12, sig.level = 0.05,
                          type = "two.sample", alternative = "two.sided")

c(n30 = poder_30$power, n100 = poder_100$power)

# strict = TRUE inclui a rejeição nas duas caudas no cálculo do poder bilateral.
planejamento <- power.t.test(delta = 5, sd = 12, sig.level = 0.05,
                             power = 0.80, type = "two.sample",
                             alternative = "two.sided", strict = TRUE)
planejamento
ceiling(planejamento$n)      # arredondar para cima: pessoas POR GRUPO
2 * ceiling(planejamento$n)  # total em dois grupos

# Mantendo os demais elementos, mais n e maior efeito aumentam o poder;
# menor alfa torna a rejeição mais difícil e reduz o poder.

# A função é ferramenta de planejamento; não acrescenta evidência ao p observado.

# Exercício curto U3: reproduza o planejamento com poder de 90%.

# # -----------------------------------------------------------------------
# UNIDADE 4. Correlação e regressão simples e múltipla ----
# # -----------------------------------------------------------------------
### 4.1 Associação entre duas variáveis quantitativas
plot(pontuacao ~ escolaridade, data = dados, pch = 19, col = "darkgreen",
     xlab = "Escolaridade em anos", ylab = "Pontuação",
     main = "Escolaridade e conhecimento nos dados simulados")

# Covariância depende das unidades. 
cov(dados$escolaridade, dados$pontuacao)

# Pearson resume associação LINEAR, varia de -1 a 1 e não tem unidade.
r <- cor(dados$escolaridade, dados$pontuacao, method = "pearson")
r

cor.test(dados$escolaridade, dados$pontuacao, method = "pearson")

### 4.2 Reta de MQO: pontuação estimada (y) = b0 + b1 * escolaridade
# Antes da função pronta: somas de quadrados e produtos dos slides.
x <- dados$escolaridade
y <- dados$pontuacao
desvio_x <- x - mean(x)
desvio_y <- y - mean(y)
SP <- sum(desvio_x * desvio_y)
SQx <- sum(desvio_x^2)
SQy <- sum(desvio_y^2)
r_manual <- SP / sqrt(SQx * SQy)
b1_manual <- SP / SQx
b0_manual <- mean(y) - b1_manual * mean(x)
c(r_manual = r_manual, r_R = r, b0 = b0_manual, b1 = b1_manual)

# A reta com intercepto passa pelo ponto das médias de X e Y.
b0_manual + b1_manual * mean(x)
mean(y)

# Função lm()
modelo <- lm(pontuacao ~ escolaridade, data = dados)
summary(modelo)
coef(modelo)
confint(modelo)
abline(modelo, col = "darkred", lwd = 2)

# b1: mudança média estimada na pontuação associada a mais um ano de estudo.
# b0: pontuação estimada para zero anos. Zero está fora do intervalo observado:
range(dados$escolaridade)
# o intercepto não ganha interpretação substantiva automática.

# Escolaridade não foi aleatorizada. Seu coeficiente não demonstra efeito causal.

### 4.3 R quadrado e sua ligação com a correlação
r_quadrado <- summary(modelo)$r.squared
c(R2 = r_quadrado, correlacao_ao_quadrado = r^2)
# R2 é a proporção da variação amostral de Y explicada pelo ajuste linear.

### 4.4 Previsão da média e previsão de uma pessoa
novos <- data.frame(escolaridade = c(8, 12, 16))
predict(modelo, newdata = novos, interval = "confidence")
predict(modelo, newdata = novos, interval = "prediction")

# O primeiro intervalo é para a média condicional; o segundo, para uma nova pessoa.
# O segundo inclui variabilidade individual e tende a ser mais amplo.

### 4.5 Resíduos e limites do modelo
plot(fitted(modelo), residuals(modelo), pch = 19, col = "steelblue",
     xlab = "Valores ajustados", 
     ylab = "Resíduos", 
     main = "Resíduos e ajuste")
abline(h = 0, lty = 2)
qqnorm(residuals(modelo), main = "Gráfico quantil normal dos resíduos")
qqline(residuals(modelo), col = "darkred")

# Procure curvatura, variação da dispersão e observações extremas.
# Gráficos ajudam a avaliar pressupostos, mas não certificam sua validade.
# normalidade dos erros fundamenta os testes e intervalos exatos em amostras pequenas.

# 4.6 Regressão múltipla e categoria de referência ----
# Vamos usar a pontuação, escolaridade E grupo.
# Mantemos Controle como referência explicitamente.
dados$grupo <- relevel(dados$grupo, ref = "Controle")
modelo_multiplo <- lm(pontuacao ~ escolaridade + grupo, data = dados)
summary(modelo_multiplo)
confint(modelo_multiplo)
cbind(simples = c(coef(modelo), grupoCapacitacao = NA_real_),
      multiplo = coef(modelo_multiplo))

# No múltiplo: escolaridade é a associação com mais um ano, mantendo o grupo fixo.
# grupoCapacitacao é a diferença prevista em relação a grupoControle, com a mesma
# escolaridade. 

# Não é preciso criar manualmente uma variável 0/1: factor faz isso.

# A oferta foi aleatorizada: o desenho simulado sustenta a análise causal do curso.
# No modelo múltiplo, o R2 total não é o quadrado da correlação simples de um preditor.

# Dois perfis com a mesma escolaridade e grupos diferentes:
perfis <- data.frame(
  escolaridade = c(12, 12),
  grupo = factor(c("Controle", "Capacitacao"), levels = levels(dados$grupo))
)
predict(modelo_multiplo, newdata = perfis, interval = "confidence")

# Comparação descritiva dos ajustes:
c(R2_simples = summary(modelo)$r.squared,
  R2_multiplo = summary(modelo_multiplo)$r.squared)
# Acrescentar preditores não reduz R2.

# 4.7 Correlação geral, dentro dos grupos e parcial ----
# Primeiro, correlações separadas por grupo:
cor_controle <- cor(dados$escolaridade[dados$grupo == "Controle"], controle); cor_controle
cor_capacitacao <- cor(dados$escolaridade[dados$grupo == "Capacitacao"], capacitacao); cor_capacitacao
c(geral = r, controle = cor_controle, capacitacao = cor_capacitacao)

plot(pontuacao ~ escolaridade, data = dados,
     col = c("blue", "green")[as.integer(dados$grupo)], pch = 19,
     xlab = "Escolaridade em anos", ylab = "Pontuação",
     main = "Associação dentro dos grupos")
legend("topleft", legend = levels(dados$grupo),
       col = c("blue", "green"), pch = 19, bty = "n")

# Correlação parcial: ajustamos X e Y pelo grupo e correlacionamos os resíduos.
ajuste_x_grupo <- lm(escolaridade ~ grupo, data = dados)
ajuste_y_grupo <- lm(pontuacao ~ grupo, data = dados)
r_parcial <- cor(residuals(ajuste_x_grupo), residuals(ajuste_y_grupo))
c(correlacao_simples = r, parcial_por_grupo = r_parcial)

# Um ajuste remove diferenças lineares associadas ao grupo; não elimina todos
# as "terceiras" variáveis possíveis. 

# O grupo foi randomizado independentemente da escolaridade; não esperamos aqui
# uma grande mudança.


# BANCO DE EXERCÍCIOS. Todos usam comandos apresentados acima. ----
# Selecione atividades para prática em duplas ou continuação após a aula.

# 1. Calcule a proporção em cada grupo e o NÚMERO de rendas não ausentes.
# 2. Compare média e mediana da renda; relacione com o histograma.
# 3. Calcule P(pontuação >= 70 | Controle) e P(pontuação >= 70 | Capacitacao).
# 4. Para X normal com média 60 e DP 10, calcule P(X < 45) e o percentil 90.
# 5. Se n passar de 25 para 100, qual é a razão EP(100)/EP(25), com mesmo DP?
# 6. Teste H0: média da pontuação = 65, bilateral, alfa = 0,05. Relate IC e p.
# 7. Refaça o teste AGRUPADO entre grupos com IC de 99%; compare com o de 95%.
# 8. No modelo simples, informe b1, IC de 95% e R2 e interprete-os.
# 9. Preveja para 12 anos de escolaridade, com IC da média e intervalo individual.
# 10. Por que escolaridade não admite conclusão causal só por entrar no modelo?
# 11. Crie o vetor c(35, 55, 65, 85); calcule média e selecione valores >= 60.
# 12. Agrupe escolaridade com limites c(4, 8, 12, 16, 21), intervalos fechados
#     à esquerda. Calcule frequências e percentuais.
# 13. Ache o percentil 80 da pontuação e o percentual de pontuações <= 80.
#     Explique por que são respostas diferentes.
# 14. Compare os resumos da renda com e sem o valor extremo; discuta exclusão.
# 15. Qual proporção das pessoas tem z_pontuacao < -1?
# 16. Confira manualmente t, gl e IC do teste agrupado contra t.test().
# 17. Reproduza o teste unilateral à direita entre grupos. Enuncie H0 e H1.
# 18. Teste H0: a diferença entre capacitação e controle é de 2 pontos,
#     bilateral, usando Student. Qual argumento precisa mudar?
# 19. Planeje n por grupo para detectar 5 pontos, DP 12, alfa 5%, poder 90%,
#     teste bilateral independente. Compare com o planejamento de poder 80%.
# 20. Reproduza manualmente b0 e b1 do modelo simples e confira com coef().
# 21. Interprete escolaridade e grupo no modelo múltiplo; faça as previsões
#     para Controle e Capacitacao com 16 anos de escolaridade.
# 22. Calcule a correlação parcial entre escolaridade e pontuação, ajustada
#     pelo grupo. Por que ela não prova causalidade?
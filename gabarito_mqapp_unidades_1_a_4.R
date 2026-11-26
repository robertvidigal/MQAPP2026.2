# =============================================================================
# MQAPP 2026.2 | Gabarito da aula de R
# =============================================================================
# Execute aula_mqapp_unidades_1_a_4.R primeiro, na mesma sessão.
# O gabarito usa os dados e modelos da aula. Não recria nem altera o sorteio.
# Para ver os resultados, execute os blocos com Ctrl/Cmd+Enter no RStudio.
if (!exists("dados") || !exists("modelo_multiplo") || !exists("simpson")) {
  stop("Execute primeiro o script completo da aula.")
}

# Atividades curtas durante a aula ----
# Aquecimento: um vetor novo, sem alterar os exemplos.
minhas_notas <- c(45, 60, 75, 90)
mean(minhas_notas)
minhas_notas[minhas_notas >= 60]
# As atividades curtas das unidades 1, 2, 3 e 4 correspondem aos exercícios
# 12, 15, 19 e 21 abaixo (no exercício 21, o enunciado muda escolaridade para 16).

# 1. Proporções e número de rendas observadas ----
prop.table(table(dados$grupo))
sum(!is.na(dados$renda))  # 176
# Número de valores observados não é a soma dos valores monetários.

# 2. Média, mediana e assimetria ----
c(media = mean(dados$renda, na.rm = TRUE),
  mediana = median(dados$renda, na.rm = TRUE))
# A cauda à direita tende a elevar a média; a mediana é menos sensível a extremos.

# 3. Probabilidades condicionais ----
c(Controle = mean(controle >= 70), Capacitacao = mean(capacitacao >= 70))
# Cada denominador é o tamanho do respectivo grupo.

# 4. Distribuição normal ----
pnorm(45, mean = 60, sd = 10)    # aproximadamente 0,0668
qnorm(0.90, mean = 60, sd = 10)  # aproximadamente 72,82

# 5. Razão dos erros padrão ----
sqrt(25 / 100)  # 0,5: quadruplicar n reduz o EP à metade, com o mesmo DP.

# 6. Teste de uma média contra 65 ----
resposta_6 <- t.test(dados$pontuacao, mu = 65, conf.level = 0.95)
resposta_6
if (resposta_6$p.value <= 0.05) {
  cat("Ex. 6: rejeitamos H0 a 5%.\n")
} else {
  cat("Ex. 6: não rejeitamos H0 a 5%.\n")
}
# Reportar estimativa, IC de 95%, t, gl e p. Não rejeitar não comprova igualdade.

# 7. IC de 99% no teste agrupado de Student ----
resposta_7 <- t.test(capacitacao, controle, var.equal = TRUE, conf.level = 0.99)
resposta_7
rbind(IC95 = as.numeric(teste_student$conf.int),
      IC99 = as.numeric(resposta_7$conf.int))
# Maior confiança produz IC mais amplo, com os mesmos dados. A estimativa da
# diferença e o p-valor bilateral do mesmo teste continuam iguais.

# 8. Inclinação, IC e R2 do modelo simples ----
coef(modelo)["escolaridade"]
confint(modelo)["escolaridade", ]
summary(modelo)$r.squared
cat(sprintf(paste0("Um ano adicional de escolaridade está associado a %.2f ",
                   "pontos a mais, em média, no ajuste simples desta amostra.\n"),
            coef(modelo)["escolaridade"]))
# IC: incerteza sobre a inclinação sob os pressupostos do procedimento.
# R2: proporção da variação amostral de Y explicada pelo ajuste linear.
# Nenhuma dessas medidas, sozinha, estabelece causalidade.

# 9. Dois intervalos para 12 anos de escolaridade ----
predict(modelo, data.frame(escolaridade = 12), interval = "confidence")
predict(modelo, data.frame(escolaridade = 12), interval = "prediction")
# Mesma estimativa central, alvos diferentes. O individual é mais amplo.

# 10. Associação e causalidade ----
# Escolaridade não foi aleatorizada. Em uma pesquisa observacional real, fatores
# como origem familiar ou acesso prévio a serviços podem afetar X e Y.
# A fórmula geradora é conhecida nesta simulação; isso não transforma toda
# associação estimada por regressão em conclusão causal em outras pesquisas.
# A atribuição aleatória da oferta tem um desenho diferente da escolaridade.

# 11. Vetor e seleção ----
resposta_11 <- c(35, 55, 65, 85)
mean(resposta_11)  # 60
resposta_11[resposta_11 >= 60]  # 65 e 85

# 12. Frequência agrupada da escolaridade ----
faixas_escolaridade <- cut(dados$escolaridade,
                           breaks = c(4, 8, 12, 16, 21), right = FALSE)
frequencia_escolaridade <- table(faixas_escolaridade)
frequencia_escolaridade
100 * prop.table(frequencia_escolaridade)
# Os intervalos são [4,8), [8,12), [12,16), [16,21); os 20 anos estão incluídos.

# 13. Percentil e posição percentílica ----
quantile(dados$pontuacao, probs = 0.80, type = 7)
mean(dados$pontuacao <= 80) * 100
# A primeira resposta é em pontos; a segunda, em porcentagem de pessoas.
# Não são operações inversas com o mesmo '80': as entradas têm unidades diferentes.

# 14. Valor extremo ----
rbind(original = comparar_resumos(renda_observada),
      com_extremo = comparar_resumos(renda_com_extremo))
# A média e o DP reagem fortemente; a mediana muda menos.
# Investigue erro de registro e contexto. Um valor raro pode ser verdadeiro.

# 15. Padronização ----
mean(dados$z_pontuacao < -1)
# Proporção observada, não uma área normal assumida. Não precisa ser 15,9%.

# 16. Teste agrupado manual e conferência ----
resposta_16_sp2 <- ((n1 - 1) * var(capacitacao) +
                     (n2 - 1) * var(controle)) / (n1 + n2 - 2)
resposta_16_ep <- sqrt(resposta_16_sp2 * (1/n1 + 1/n2))
resposta_16_t <- (mean(capacitacao) - mean(controle)) / resposta_16_ep
resposta_16_gl <- n1 + n2 - 2
resposta_16_ic <- diferenca + c(-1, 1) *
  qt(0.975, df = resposta_16_gl) * resposta_16_ep
c(t_manual = resposta_16_t, t_R = unname(teste_student$statistic),
  gl_manual = resposta_16_gl, gl_R = unname(teste_student$parameter))
rbind(manual = resposta_16_ic, funcao = as.numeric(teste_student$conf.int))

# 17. Teste unilateral à direita ----
# H0: média_cap - média_cont <= 0; H1: média_cap - média_cont > 0.
# Direção definida pela pergunta antes da análise, cálculo na fronteira zero.
t.test(capacitacao, controle, var.equal = TRUE, alternative = "greater")

# 18. Hipótese de diferença de 2 pontos ----
t.test(capacitacao, controle, mu = 2, var.equal = TRUE,
       alternative = "two.sided")
# Altera mu. A diferença observada nos dados não muda; muda a referência de H0.

# 19. Planejamento com 90% de poder ----
resposta_19 <- power.t.test(delta = 5, sd = 12, sig.level = 0.05,
                           power = 0.90, type = "two.sample",
                           alternative = "two.sided", strict = TRUE)
resposta_19
c(n80_por_grupo = ceiling(planejamento$n),
  n90_por_grupo = ceiling(resposta_19$n),
  total90 = 2 * ceiling(resposta_19$n))
# Mais poder exige mais pessoas, mantidos efeito, variância, alfa e desenho.

# 20. Reta calculada manualmente ----
resposta_20_b1 <- sum((x - mean(x)) * (y - mean(y))) / sum((x - mean(x))^2)
resposta_20_b0 <- mean(y) - resposta_20_b1 * mean(x)
rbind(manual = c(resposta_20_b0, resposta_20_b1), funcao = coef(modelo))
# A reta passa por (média de X, média de Y). Usar valores completos no cálculo.

# 21. Regressão múltipla ----
coef(modelo_multiplo)
confint(modelo_multiplo)
perfis_16 <- data.frame(
  escolaridade = c(16, 16),
  grupo = factor(c("Controle", "Capacitacao"), levels = levels(dados$grupo))
)
resposta_21 <- predict(modelo_multiplo, newdata = perfis_16,
                       interval = "confidence")
resposta_21
resposta_21[2, "fit"] - resposta_21[1, "fit"]
coef(modelo_multiplo)["grupoCapacitacao"]
# Escolaridade: variação prevista por ano, com grupo constante.
# Grupo: diferença prevista Capacitacao - Controle, com escolaridade constante.
# Sem interação, a diferença prevista entre os grupos é constante em X.

# 22. Correlação parcial ----
residuos_x <- residuals(lm(escolaridade ~ grupo, data = dados))
residuos_y <- residuals(lm(pontuacao ~ grupo, data = dados))
cor(residuos_x, residuos_y)
# Remove associações lineares com o grupo; não resolve todos os confundidores.
# Não pressupõe nem demonstra que o grupo seja o único fator relevante.
# Não use o teste ingênuo cor.test(residuos_x, residuos_y) para inferência parcial.

# Chama pacotes a serem usados
library(xlsx)
library(FactoMineR)
library(factoextra)

# Importar dados do Excel
q_agua <- read.xlsx("C:/Users/User/Desktop/Lata/Quali_agua.xlsx", sheetIndex = 1)

# Visualizar os dados
View(q_agua)

# Remove qualquer dado nulo ou faltante presente nos dados 
q_agua <- na.omit(q_agua)

# Criar subconjuntos de individuos ativos(linhas) e vari�veis ativas(colunas) para a an�lise 
q_agua.active <- q_agua[1:12, 2:5]

# Visualizar os dados
View(q_agua.active)
head(q_agua.active[,1:4],3) 

# O FactoMineR j� faz a padroniza��o automaticamente na� sendo ncess�rio uso do scale.
q_agua.active <- scale(q_agua.active) 

# Gerar PCA
res.pca <- PCA(q_agua.active, graph = F)

# Extrair a proporcao de variancia dos valores de componentes principais
eig.val <- get_eigenvalue(res.pca)
eig.val

# Plotar no gr�fico mostrando a propor��o de variancia de cada vari�vel
fviz_eig(res.pca, addlabels = T, ylim = c(0,90))

#Extrair os resultados das variaveis do PCA par plotar no gr�fico
var <- get_pca_var(res.pca)
ind <- get_pca_ind(res.pca)

# Plotar o gr�fico de PCA
fviz_pca_var(res.pca, col.var = "blue")

# Criar grupo para cluster
grupo <- as.factor(q_agua[,1])

# Plotar novamente usando o gr�fico Biplot
fviz_pca_biplot(res.pca, habillage = grupo, title = "Gr�fio PCA Qualidade da Agua")


# Checar a qualidade da representa��o com Cos2 e gr�fico
var$cos2

library(corrplot)
corrplot(var$cos2, is.corr = F)

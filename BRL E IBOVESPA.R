# Instale e carregue as bibliotecas necessárias
install.packages(c("quantmod", "TTR"))
library(quantmod)
library(TTR)
library(ggplot2)

# Baixe os dados históricos do Dólar/Real
getSymbols("USDBRL=X", src = "yahoo", from = "2020-01-01", to = Sys.Date())

# Baixe os dados históricos do Índice Ibovespa
getSymbols("^BVSP", src = "yahoo", from = "2020-01-01", to = Sys.Date())

# Extraia os preços de fechamento ajustados
dolar_real <- Cl(get("USDBRL=X"))
ibovespa <- Ad(BVSP)

# Crie um dataframe com os dois conjuntos de dados
dados <- merge(dolar_real, ibovespa, join = "inner")

# Calcule a matriz de correlação
correlacao <- cor(dados)

# Exiba a matriz de correlação
print(correlacao)


# Renomeie as colunas para facilitar a interpretação
colnames(dados) <- c("Dolar_Real", "Ibovespa")

# Crie um gráfico de dispersão
ggplot ( dados, aes( x= dados$Dolar_Real, y= dados$Ibovespa))+
  geom_point()+
  geom_smooth( method = 'lm', se = FALSE, color = "red" )+
  theme_minimal()+
  theme(panel.background = element_rect(fill = "#00CED1"))+
  labs(
    title= "CORRELAÇÃO ENTRE USD/BRL E IBOVESPA",
    y= "INDICE IBOVESPA",
    x="PREÇO DO USD/BRL",
    caption  = "Dados: YAHOO FINANCE, USANDO PACOTE QUANTMOD| Elaboração: analista Juliano Dias")




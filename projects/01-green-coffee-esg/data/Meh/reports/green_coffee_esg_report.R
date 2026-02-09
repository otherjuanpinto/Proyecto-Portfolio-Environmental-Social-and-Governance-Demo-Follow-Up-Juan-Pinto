library(readr)

# Cargar los 3 archivos
full_data <- read_csv("data/processed/full_data.csv")
esg_score <- read_csv("data/processed/esg_score.csv")

# Mostrar nombres de columnas
cat("=== FULL_DATA ===\n")
names(full_data)

cat("\n=== ESG_SCORE ===\n")
names(esg_score)

cat("\n=== PRIMERAS 3 FILAS DE FULL_DATA ===\n")
head(full_data, 3)

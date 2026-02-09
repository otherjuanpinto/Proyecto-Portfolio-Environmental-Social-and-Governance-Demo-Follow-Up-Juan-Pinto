# ============================================================
# 01 - Build Dataset (Green Coffee ESG Intelligence)
# ============================================================

library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# ------------------------------------------------------------
# 0) Paths (CAMBIA SOLO ESTO)
# ------------------------------------------------------------
BASE <- "C:/Users/juanp/Documents/Meh"

RAW_FAOSTAT <- file.path(BASE, "REPO 1", "FAOSTAT.csv")

RAW_GDP     <- file.path(BASE, "REPO 1", "GDP", "API_NE.GDI.TOTL.ZS_DS2_en_csv_v2_2220.csv")
RAW_POV     <- file.path(BASE, "REPO 1", "POVERTY", "API_SL.AGR.EMPL.ZS_DS2_en_csv_v2_135.csv")
RAW_RURAL   <- file.path(BASE, "REPO 1", "RURAL", "API_SP.RUR.TOTL.ZG_DS2_en_csv_v2_725.csv")

PROCESSED <- file.path(BASE, "data", "processed")

dir.create(PROCESSED, recursive = TRUE, showWarnings = FALSE)

countries <- c("Brazil","Colombia","Peru","Honduras")

# ------------------------------------------------------------
# 1) FAOSTAT - Coffee production
# ------------------------------------------------------------
coffee <- read_csv(RAW_FAOSTAT, show_col_types = FALSE) %>%
  select(country = Area, year = Year, production_tonnes = Value) %>%
  filter(country %in% countries) %>%
  mutate(year = as.integer(year))

write_csv(coffee, file.path(PROCESSED, "coffee_clean.csv"))

# ------------------------------------------------------------
# 2) Helper function for World Bank datasets
# ------------------------------------------------------------
clean_worldbank <- function(path, value_name) {
  read_csv(path, skip = 4, show_col_types = FALSE) %>%
    filter(`Country Name` %in% countries) %>%
    pivot_longer(
      cols = matches("^[0-9]{4}$"),
      names_to = "year",
      values_to = value_name
    ) %>%
    mutate(year = as.integer(year)) %>%
    select(country = `Country Name`, year, all_of(value_name))
}

poverty_clean <- clean_worldbank(RAW_POV, "employment_agri_pct")
rural_clean   <- clean_worldbank(RAW_RURAL, "rural_pop_growth_pct")
gdp_clean     <- clean_worldbank(RAW_GDP, "gdp_gdi_pct")

write_csv(poverty_clean, file.path(PROCESSED, "poverty_clean.csv"))
write_csv(rural_clean,   file.path(PROCESSED, "rural_clean.csv"))
write_csv(gdp_clean,     file.path(PROCESSED, "gdp_clean.csv"))

# ------------------------------------------------------------
# 3) Merge master dataset
# ------------------------------------------------------------
full_data <- coffee %>%
  left_join(poverty_clean, by = c("country","year")) %>%
  left_join(rural_clean, by = c("country","year")) %>%
  left_join(gdp_clean, by = c("country","year"))

write_csv(full_data, file.path(PROCESSED, "full_data.csv"))

# ------------------------------------------------------------
# 4) ESG Score (simple, transparent)
# ------------------------------------------------------------
# Nota: esto NO es un score real ESG.
# Es un proxy para entrenamiento analítico.

library(scales)

esg_score <- full_data %>%
  group_by(country) %>%
  summarise(
    production_avg = mean(production_tonnes, na.rm = TRUE),
    employment_agri_avg = mean(employment_agri_pct, na.rm = TRUE),
    rural_growth_avg = mean(rural_pop_growth_pct, na.rm = TRUE),
    gdp_gdi_avg = mean(gdp_gdi_pct, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    prod_norm = rescale(production_avg),
    emp_norm  = rescale(employment_agri_avg),
    rur_norm  = rescale(rural_growth_avg),
    gdp_norm  = rescale(gdp_gdi_avg),
    esg_proxy_score = (prod_norm*0.40 + (1-emp_norm)*0.30 + (1-rur_norm)*0.20 + gdp_norm*0.10)
  ) %>%
  select(country, production_avg, employment_agri_avg, rural_growth_avg, gdp_gdi_avg, esg_proxy_score)

write_csv(esg_score, file.path(PROCESSED, "esg_score.csv"))

# ============================================================
# END
# ============================================================



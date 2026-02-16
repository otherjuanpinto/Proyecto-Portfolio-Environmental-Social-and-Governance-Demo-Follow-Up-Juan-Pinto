# ============================================================
# GREEN COFFEE ESG PIPELINE (Version profesional)
# Author: Juan Paulo Pinto Sandoval
# Purpose:
#   - Clean + harmonize FAOSTAT + World Bank indicators
#   - Produce processed datasets for Quarto report (.qmd)
# Outputs:
#   - data/processed/coffee_clean.csv
#   - data/processed/full_data.csv
#   - data/processed/esg_score.csv
# ============================================================

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(janitor)
})

# -----------------------------
# 1) SETTINGS
# -----------------------------
ORIGINS <- c("Brazil", "Colombia", "Peru", "Honduras")

BASE <- "C:/Users/juanp/Documents/PROYEESG 1"
RAW <- file.path(BASE, "data", "raw")
PROCESSED <- file.path(BASE, "data", "processed")

if (!dir.exists(PROCESSED)) dir.create(PROCESSED, recursive = TRUE)

# -----------------------------
# 2) UTILITIES
# -----------------------------
assert_file_exists <- function(path) {
  if (!file.exists(path)) {
    stop(paste0("\n❌ File not found:\n", path), call. = FALSE)
  }
}

read_worldbank <- function(path) {
  assert_file_exists(path)
  read_csv(path, skip = 4, show_col_types = FALSE) %>%
    clean_names()
}

wb_wide_to_long <- function(df, value_name) {
  df %>%
    pivot_longer(
      cols = matches("^x\\d{4}$"),
      names_to = "year",
      values_to = value_name
    ) %>%
    mutate(year = as.integer(str_remove(year, "^x")))
}

norm_01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  if (rng[1] == rng[2]) return(rep(0.5, length(x)))
  (x - rng[1]) / (rng[2] - rng[1])
}

# -----------------------------
# 3) INPUT FILES
# -----------------------------
FAOSTAT_FILE <- file.path(RAW, "FAOSTAT.csv")

WB_EMPLOYMENT_FILE <- file.path(RAW, "API_SL.AGR.EMPL.ZS_DS2_en_csv_v2_135.csv")
WB_RURAL_GROWTH_FILE <- file.path(RAW, "API_SP.RUR.TOTL.ZG_DS2_en_csv_v2_725.csv")
WB_INVESTMENT_FILE <- file.path(RAW, "API_NE.GDI.TOTL.ZS_DS2_en_csv_v2_2220.csv")

# -----------------------------
# 4) LOAD + CLEAN FAOSTAT
# -----------------------------
assert_file_exists(FAOSTAT_FILE)

coffee <- read_csv(FAOSTAT_FILE, show_col_types = FALSE) %>%
  clean_names()

coffee_clean <- coffee %>%
  mutate(
    country = area,
    year = as.integer(year),
    production_tonnes = as.numeric(value)
  ) %>%
  select(country, year, production_tonnes) %>%
  filter(country %in% ORIGINS) %>%
  filter(!is.na(year)) %>%
  arrange(country, year)

write_csv(coffee_clean, file.path(PROCESSED, "coffee_clean.csv"))
message("✅ coffee_clean.csv saved")

# -----------------------------
# 5) LOAD + CLEAN WORLD BANK
# -----------------------------
employment_long <- read_worldbank(WB_EMPLOYMENT_FILE) %>%
  select(country_name, starts_with("x")) %>%
  wb_wide_to_long("employment_agri_pct") %>%
  rename(country = country_name) %>%
  filter(country %in% ORIGINS)

rural_growth_long <- read_worldbank(WB_RURAL_GROWTH_FILE) %>%
  select(country_name, starts_with("x")) %>%
  wb_wide_to_long("rural_pop_growth_pct") %>%
  rename(country = country_name) %>%
  filter(country %in% ORIGINS)

investment_long <- read_worldbank(WB_INVESTMENT_FILE) %>%
  select(country_name, starts_with("x")) %>%
  wb_wide_to_long("investment_pct_gdp") %>%
  rename(country = country_name) %>%
  filter(country %in% ORIGINS)

# -----------------------------
# 6) MERGE FULL DATASET
# -----------------------------
full_data <- coffee_clean %>%
  left_join(employment_long, by = c("country", "year")) %>%
  left_join(rural_growth_long, by = c("country", "year")) %>%
  left_join(investment_long, by = c("country", "year"))

write_csv(full_data, file.path(PROCESSED, "full_data.csv"))
message("✅ full_data.csv saved")

# -----------------------------
# 7) ESG SCORE
# -----------------------------
max_year <- max(full_data$year, na.rm = TRUE)
window_start <- max_year - 4

summary_5y <- full_data %>%
  filter(year >= window_start) %>%
  group_by(country) %>%
  summarise(
    production_avg = mean(production_tonnes, na.rm = TRUE),
    employment_agri_avg = mean(employment_agri_pct, na.rm = TRUE),
    rural_growth_avg = mean(rural_pop_growth_pct, na.rm = TRUE),
    investment_avg = mean(investment_pct_gdp, na.rm = TRUE),
    .groups = "drop"
  )

esg_score <- summary_5y %>%
  mutate(
    prod_n = norm_01(production_avg),
    agri_n = norm_01(employment_agri_avg),
    rural_n = norm_01(rural_growth_avg),
    inv_n = norm_01(investment_avg),
    
    esg_score =
      (prod_n * 0.35) +
      ((1 - agri_n) * 0.30) +
      ((1 - rural_n) * 0.15) +
      (inv_n * 0.20)
  ) %>%
  select(
    country,
    production_avg,
    employment_agri_avg,
    rural_growth_avg,
    investment_avg,
    esg_score
  ) %>%
  arrange(desc(esg_score))

write_csv(esg_score, file.path(PROCESSED, "esg_score.csv"))
message("✅ esg_score.csv saved")

message("\n============================================================")
message("✅ PIPELINE COMPLETED SUCCESSFULLY")
message("Processed outputs in: ", PROCESSED)
message("============================================================\n")

# ESG Data Sources & Setup Instructions

## File Structure

```
data/raw/
├── faostat_coffee_template.csv          # Agricultural production & environment
├── worldbank_social_template.csv        # Socio-economic indicators  
└── gcp_benchmarks_reference.txt         # Global Coffee Platform reference
```

## How to Populate Real Data

### FAOSTAT Coffee Data
1. Visit: https://www.fao.org/faostat/
2. Select: "Crops and livestock products" → "Coffee, Green"
3. Download for: Brazil, Colombia, Peru, Honduras, Guatemala
4. Variables: Production, Fertilizer use, Area harvested
5. Years: 2015–2023 (or latest available)
6. Save as: `faostat_coffee.csv`

### World Bank Socio-Economic Data
1. Visit: https://data.worldbank.org/
2. Select indicators:
   - NY.GDP.PCAP.CD (GDP per capita, USD)
   - SI.POV.RURL (Rural poverty %)
   - NV.AGR.EMPL.ZS (Agricultural employment % of total)
3. Download for: Brazil, Colombia, Peru, Honduras, Guatemala
4. Years: 2015–2023
5. Save as: `worldbank_social.csv`

### Global Coffee Platform Benchmarks
1. Visit: https://www.globalcoffeeplatform.org/
2. Review: Country profiles & sustainability benchmarks
3. Note: Certifications, climate vulnerability scores
4. Save references as: `gcp_benchmarks_reference.txt`

## Data Validation Checklist

- [ ] No missing values for key countries (Brazil, Colombia, Peru)
- [ ] Production data in tonnes (not kg or '000 tonnes)
- [ ] Years align 2015–2023
- [ ] Economic indicators in USD and percentages
- [ ] All country names match exactly across files

## Once Data is Loaded

Run `notebooks/01_exploratory_esg_analysis.Rmd` to populate the analysis with real data.

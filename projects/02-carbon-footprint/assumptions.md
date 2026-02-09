# Project 02 – Carbon Footprint of Coffee
## Strategic Assumptions

---

## 🎯 Core Assumption

**"Coffee supply chain emissions are concentrated in Scope 3 (agriculture + logistics); decarbonization requires simultaneous supply-side innovation AND demand-side accountability."**

---

### Assumption 1: Scope 3 Dominates Total Emissions

| Level | Content |
|-------|---------|
| **Observación** | Ciclo de vida café: agricultura (55-65%), logística (15-20%), roasting (5-10%), otros (10-20%). |
| **Interpretación** | Importer/roaster controls solo 30% de emissions; 70% ocurre en sourcing + logistics = supply chain responsibility. |
| **Supuesto ESG** | Para alcanzar target 1.5°C/2°C (Science-Based Target), empregas deben reducir Scope 3 en 30-50%; imposible sin intervención en origen. |
| **Implicación** | **Acción:** Climate strategy = farmer support program + logistics optimization; no es reducción interna solamente. |

---

### Assumption 2: Agricultural Emissions = Fertilizer Intensity

| Level | Content |
|-------|---------|
| **Observación** | En Brasil y Vietnã, intensidad fertilizante aumentó 40% en 20 años; N2O emissions (298x GWP vs CO2) son principales driver. |
| **Interpretación** | Productividad creció, pero huella emitió más; no es trade-off real entre producción y clima si se innova en prácticas. |
| **Supuesto ESG** | Agroforestry + organic fertilizer + precision agriculture reducen emisiones agrícolas 20-30% sin sacrificar yields. BUT: requiere upfront capex + capacitación. Farmers sin acceso a crédito no pueden adoptar. |
| **Implicación** | **Acción:** Importer provee financing o premium para farmers que adopten climate-smart; esto es "climate finance" en origen. |

---

### Assumption 3: Logistics Emissions Are Opaque

| Level | Content |
|-------|---------|
| **Observación** | Mayoría de importadores usan carriers genéricos; no hay granularidad en ruta, modo (air vs sea), consolidación. |
| **Interpretación** | Asignar emissions a shipment level es técnicamente posible pero operativamente complejo; actualmente: black box. |
| **Supuesto ESG** | Si importador no mide emissions por shipment, tampoco puede optimizar; optimization floor es desconocido. Margen de mejora: 20-40% con ruta smarter + consolidation. |
| **Implicación** | **Acción:** Implementar logistics data system; negotiar con carriers para emissions reporting; rebalance cost vs. carbon. |

---

### Assumption 4: Decarbonization has Tradeoffs

| Level | Content |
|-------|---------|
| **Observación** | Sea freight = bajo carbono pero 45 días; air freight = alto carbono pero 3 días. |
| **Interpretación** | Speed vs. carbon; importes necesitan ambos (freshness demand, storage cost); optimal punto ≠ pure carbon minimization. |
| **Supuesto ESG** | Vraag correr: sea freight cuando posible (85% cases); air solo cuando fresh/quality necesario. Pero requiere supply chain redesign (forecasting, buffer stock). |
| **Implicación** | **Acción:** Modeling de scenario: supply chain resilience vs carbon cost; tradeoff visible a leadership. |

---

### Assumption 5: Carbon Pricing Will Accelerate Cost

| Level | Content |
|-------|---------|
| **Observación** | EU ETS expansion, potencial CBAM en café imports; carbon credit prices: €85-120/ton CO2e (2024). |
| **Interpretación** | En 2-3 años, carbon en supply chain = explicit financial cost, no solo ESG narrative. |
| **Supuesto ESG** | Importer que hoy emite 5,000 tons CO2e/año (típico mid-size) pagará €425K-600K/año si carbon pricing se genericiza. Reducción 30% = €127K-180K savings/año. |
| **Implicación** | **Acción:** Carbon reduction es NOW financial case, no futura; model ROI de inversiones climate. |

---

## 📊 Emissions Calculation Framework

| Scope | Category | Driver | Data Source | Uncertainty |
|-------|----------|--------|-------------|-------------|
| **Scope 1** | Farm operations | Fuel (machinery, drying) | FAOSTAT, farm surveys | ±30% |
| **Scope 2** | Processing | Electricity (wet mill, roasting) | IEA, grid mix | ±20% |
| **Scope 3a** | N2O/fertilizer | N application rate | FAOSTAT, Our World in Data | ±40% |
| **Scope 3b** | Transportation | Distance + mode + fuel mix | Shipping datasets, logistics partner | ±25% |
| **Scope 3c** | Packaging | Material + weight | Supplier data | ±15% |

---

## 🎯 Success Metrics

✅ **Assumption validated:** Scope 3 agriculture = 50%+ of total; logistics optimization = 20-30% reduction potential
✅ **Deliverable:** GHG Protocol-compliant model; emissions by Scope + pathway (origin, route, process)
✅ **Business outcome:** Client quantifies carbon cost + ROI for decarbonization; roadmap to 1.5°C alignment


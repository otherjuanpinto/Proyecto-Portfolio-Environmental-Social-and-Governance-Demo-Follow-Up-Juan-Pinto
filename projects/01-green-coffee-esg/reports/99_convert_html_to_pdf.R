# 99_convert_html_to_pdf.R

# install.packages("quarto") # NO
# install.packages("pagedown") # NO

# Lo que necesitas (según el paquete que tengas)
# Si tu función es html_to_pdf(), asegúrate de cargar la librería correcta.

library(webshot2)

# --- RUTAS (Windows) ---
html_files <- c(
  "C:/Users/juanp/Documents/PROYEESG 1/reports/01_green_coffee_esg_report_v2.html",
  "C:/Users/juanp/Documents/Meh/reports/green_coffee_esg_report.html"
)

# --- OUTPUT PDF ---
pdf_files <- gsub("\\.html$", ".pdf", html_files)

# --- CONVERTIR ---
for (i in seq_along(html_files)) {
  cat("\nConvirtiendo:\n", html_files[i], "\n")
  
  webshot(
    url = html_files[i],
    file = pdf_files[i],
    delay = 2,
    zoom = 1
  )
  
  cat("OK ->", pdf_files[i], "\n")
}

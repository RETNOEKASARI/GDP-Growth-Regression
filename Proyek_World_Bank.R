# ============================================
# PROYEK DATA WORLD BANK
# Analisis Pengaruh Inflasi dan Pengangguran
# terhadap Pertumbuhan Ekonomi (GDP Growth)
# ============================================

# ---- 1. LOAD LIBRARY ----
library(tidyverse)
library(ggplot2)
library(corrplot)
library(car)     # untuk VIF
library(lmtest)  # untuk bptest

# ---- 2. LOAD DATASET ----
df <- read.csv("world_bank_data_2025.csv")

# ---- 3. EKSPLORASI AWAL ----
dim(df)        # jumlah baris dan kolom
head(df)       # 6 baris pertama
str(df)        # struktur data
summary(df)    # statistik deskriptif

# ---- 4. CLEANING DATA ----
# Pilih kolom yang relevan
df_clean <- df %>%
  select(country_name, year,
         `GDP.Growth....Annual.`,
         `Inflation..CPI...`,
         `Unemployment.Rate....`,
         `GDP.per.Capita..Current.USD.`) %>%
  drop_na()  # hapus baris dengan nilai kosong

# Cek hasil cleaning
nrow(df)                      # jumlah baris sebelum cleaning
nrow(df_clean)                # jumlah baris setelah cleaning
summary(df_clean)             # statistik deskriptif data bersih
colSums(is.na(df_clean))      # pastikan tidak ada NA tersisa

# ---- 5. VISUALISASI DATA ----
# Histogram GDP Growth
ggplot(df_clean, aes(x = GDP.Growth....Annual.)) +
  geom_histogram(fill = "steelblue", bins = 30) +
  labs(title = "Distribusi GDP Growth", x = "GDP Growth (%)", y = "Frekuensi")

# Scatter plot: Inflasi vs GDP Growth
ggplot(df_clean, aes(x = Inflation..CPI..., y = GDP.Growth....Annual.)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Inflasi vs GDP Growth",
       x = "Inflasi (CPI %)", y = "GDP Growth (%)")

# Scatter plot: Pengangguran vs GDP Growth
ggplot(df_clean, aes(x = Unemployment.Rate...., y = GDP.Growth....Annual.)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", color = "darkgreen") +
  labs(title = "Pengangguran vs GDP Growth",
       x = "Unemployment Rate (%)", y = "GDP Growth (%)")

# Korelasi antar variabel numerik
df_num <- df_clean %>% select(-country_name, -year)
corrplot(cor(df_num, use = "complete.obs"), method = "color",
         title = "Korelasi Antar Variabel", mar = c(0,0,1,0))

# ---- 6. MODEL REGRESI LINEAR ----
model <- lm(GDP.Growth....Annual. ~
              Inflation..CPI... +
              Unemployment.Rate....,
            data = df_clean)

# Lihat hasil model
summary(model)
# Interpretasi:
# - R-squared: seberapa besar variabel independen menjelaskan GDP Growth
# - p-value < 0.05 berarti variabel tersebut signifikan
# - Koefisien positif = berpengaruh positif terhadap GDP Growth
# - Koefisien negatif = berpengaruh negatif terhadap GDP Growth

# ---- 7. UJI ASUMSI REGRESI ----
# Uji normalitas residual
shapiro.test(residuals(model))
# Interpretasi:
# - p-value > 0.05 = residual normal (asumsi terpenuhi)
# - p-value < 0.05 = asumsi normalitas tidak terpenuhi

# Uji multikolinearitas
vif(model)
# Interpretasi:
# - VIF < 10 = tidak ada multikolinearitas (asumsi terpenuhi)
# - VIF > 10 = ada multikolinearitas antar variabel independen

# Uji homoskedastisitas
bptest(model)
# Interpretasi:
# - p-value > 0.05 = varians residual konstan (asumsi terpenuhi)
# - p-value < 0.05 = ada heteroskedastisitas

# Plot diagnostik (4 plot asumsi regresi)
plot(model)
# Interpretasi:
# - Residuals vs Fitted: cek linearitas dan homoskedastisitas
# - Normal Q-Q: cek normalitas residual
# - Scale-Location: cek homoskedastisitas
# - Residuals vs Leverage: cek outlier berpengaruh

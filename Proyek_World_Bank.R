# ============================================
# PROYEK DATA WORLD BANK 
# ============================================

# Load dan Eksplorasi Data

# Load library
library(tidyverse)
library(ggplot2)
library(corrplot)

# Load dataset
df <- read.csv("world_bank_data_2025.csv")

# Eksplorasi awal
dim(df)          # jumlah baris dan kolom
head(df)         # 6 baris pertama
str(df)          # struktur data
summary(df)      # statistik deskriptif

# cleaning data
# Pilih kolom yang relevan
df_clean <- df %>%
  select(country_name, year,
         `GDP.Growth....Annual.`,
         `Inflation..CPI...`,
         `Unemployment.Rate....`,
         `GDP.per.Capita..Current.USD.`) %>%
  drop_na()   # hapus baris dengan nilai kosong

# Cek hasilnya
nrow(df)
nrow(df_clean)
summary(df_clean)
colSums(is.na(df_clean))

# Visualisasi data
# Histogram GDP Growth
ggplot(df_clean, aes(x = GDP.Growth....Annual.)) +
  geom_histogram(fill = "steelblue", bins = 30) +
  labs(title = "Distribusi GDP Growth", x = "GDP Growth (%)", y = "Frekuensi")

# Scatter plot: Inflasi vs GDP Growth
ggplot(df_clean, aes(x = Inflation..CPI..., y = GDP.Growth....Annual.)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Inflasi vs GDP Growth")

# Korelasi antar variabel
df_num <- df_clean %>% select(-country_name, -year)
corrplot(cor(df_num, use = "complete.obs"), method = "color")

# Model Regresi Linear
model <- lm(GDP.Growth....Annual. ~ 
              Inflation..CPI... + 
              Unemployment.Rate...., 
            data = df_clean)

# Lihat hasil
summary(model)

# Uji asumsi
plot(model)   # 4 plot diagnostik
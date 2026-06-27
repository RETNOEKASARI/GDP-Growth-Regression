# GDP Growth Regression

## Deskripsi Proyek

Proyek ini bertujuan untuk menganalisis faktor-faktor yang mempengaruhi pertumbuhan Produk Domestik Bruto (GDP Growth) menggunakan metode Regresi Linear. Analisis dilakukan menggunakan data World Bank dengan bahasa pemrograman R.

---

## Tujuan

Penelitian ini bertujuan untuk:

- Melakukan eksplorasi data World Bank.
- Membersihkan data (Data Cleaning).
- Membuat visualisasi data.
- Menganalisis hubungan antar variabel menggunakan korelasi.
- Membangun model Regresi Linear untuk mengetahui pengaruh Inflasi dan Tingkat Pengangguran terhadap GDP Growth.

---

## Dataset

## Dataset

Dataset yang digunakan berasal dari:

- Kaggle: Global Economic Indicators (2010–2025) – World Bank
- https://www.kaggle.com/datasets/tanishksharma9905/global-economic-indicators-20102025

Data bersumber dari World Bank Open Data API dan mencakup indikator ekonomi tahunan lebih dari 200 negara pada periode 2010–2025.
Dataset terdiri dari:

- 3472 observasi
- 16 variabel

Setelah proses data cleaning diperoleh:

- 2365 observasi
- 6 variabel utama

Variabel yang digunakan:

- GDP Growth (Annual %)
- Inflation (CPI)
- Unemployment Rate
- GDP per Capita
- Country Name
- Year

---

## 🛠️ Library yang Digunakan

```r
library(tidyverse)
library(ggplot2)
library(corrplot)
```

---

## Tahapan Analisis

### 1. Import Dataset

- Membaca dataset CSV menggunakan `read.csv()`.

### 2. Exploratory Data Analysis (EDA)

Melakukan:

- Struktur data
- Statistik deskriptif
- Pemeriksaan missing value

### 3. Data Cleaning

Melakukan:

- Pemilihan variabel yang relevan.
- Menghapus data yang memiliki nilai kosong menggunakan `drop_na()`.

### 4. Visualisasi Data

Visualisasi yang dibuat:

- Histogram GDP Growth
- Scatter Plot Inflation vs GDP Growth
- Correlation Matrix

### 5. Analisis Regresi Linear

Model yang digunakan:

```
GDP Growth ~ Inflation + Unemployment Rate
```

---

## Hasil Analisis

Hasil regresi menunjukkan bahwa:

- Inflasi memiliki pengaruh negatif terhadap GDP Growth.
- Tingkat Pengangguran memiliki pengaruh negatif terhadap GDP Growth.
- Kedua variabel signifikan secara statistik (p-value < 0.05).
- Nilai Multiple R² sebesar sekitar **2.27%**, sehingga masih terdapat faktor-faktor lain yang mempengaruhi pertumbuhan GDP di luar model.

---

## Struktur Repository

```
GDP-Growth-Regression
│
├── Proyek_World_Bank.R
├── world_bank_data_2025.csv
└── README.md
```

---

## Cara Menjalankan

1. Download repository.
2. Buka file `Proyek_World_Bank.R` menggunakan RStudio.
3. Pastikan dataset `world_bank_data_2025.csv` berada pada folder yang sama.
4. Install package yang diperlukan:

```r
install.packages(c(
  "tidyverse",
  "ggplot2",
  "corrplot"
))
```

5. Jalankan script dari awal hingga akhir.

---

## Penulis

**Retno Eka Sari**

Telkom University Surabaya

Mata Kuliah **Wawasan Global TIK**

---

##  Lisensi

Repository ini dibuat untuk keperluan pembelajaran dan tugas akademik.

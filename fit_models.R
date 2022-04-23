library(readxl)
library(forecast)
library(tidyverse)

# carga de datos
sheet <- excel_sheets('series_pos.xlsx')
datos <- mapply(FUN = read_xlsx, 
                'series_pos.xlsx', 
                sheet = sheet,
                skip = 36
                )
names(datos) <- sheet

# convercion a ts object
datos_ts <- lapply(X = datos, 
                   FUN = ts, 
                   start = c(2021,1), 
                   frequency = 12
                   )

# ajuste de modelos de tendencia emisor y adquiriente
fit_cantidades <- lapply(X = datos_ts, 
                         FUN = holt, 
                         h=13, 
                         damped = T,
                         level = c(85,95)
                         )

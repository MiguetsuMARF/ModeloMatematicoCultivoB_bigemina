
library(ggplot2)

cultivo <- data.frame(
  "ID" = c("C1B3","C1C3",
            "C1B4","C1C4",
            "C1B5","C1C5",
            "C2B2","C2C2","C2B3","C2C3",
            "C2B4","C2C4","C2B5","C2C5","C3B2","C3C2","C3B3","C3C3",
            "C3B4","C3C4","C3B5","C3C5","C4B2","C4C2","C4B3","C4C3",
            "C4B4","C4C4","C4B5","C4C5",
            "C5B2","C5C2","C5B3","C5C3",
           "C5B4","C5C4","C5B5","C5C5",
           "C6B2","C6C2","C6B3","C6C3",
           "C6B4","C6C4","C6B5","C6C5"
            ),
  "Suero" = c(40,40,
               40,40,
               40,40,
               40,40,40,40,
               40,40,40,40,20,20,20,20,
               20,20,20,20,40,40,40,40,
               20,20,20,20,
               20,20,20,20,
              20,20,20,20,
              20,20,20,20,
              20,20,20,20
               ),
  "48h" = c(0,0,
             1.74,1.04,
             1.5,2.65,
             1.65,2.4,1.79,2.65,
             1.85,1.2,1.69,2.25,1.04,1.04,1.2,1.25,
             1.39,1.14,0.5,1.49,1.1,1.85,0.8,0.54,
             1.6,1.7,1.29,1.89,
             1.54,2.04,1.29,2.09,
            2.0,1.95,1.85,1.85,
            2.45,2.15,1.85,2.5,
            1.79,1.79,1.75,2.34
            
             ),
  "72h" = c(0,0,
             1.45,1.14,
             1.75,2.9,
             2.29,2.69,2.34,2.39,
             2.39,2.89,2.79,2.59,1.44,1.85,1.75,1.79,
             1.6,2.09,1.95,1.75,1.35,2.25,2.29,2.59,
             1.45,2.09,2.04,3.59,
             2.95,2.84,2.4,2.75,
            3.09,2.9,2.25,2.45,
            4,3.09,3.09,2.75,
            2.79,2.34,2.75,3.65
            
             ),
  "96h" = c(1.3,2.5,
             2.7,2.44,
             0,0,
             2.39,2.84,3.39,2.94,
             2.34,1.89,3.25,2.5,1.99,1.79,2.04,2.44,
             2.45, 2.65,1.35, 2.75,3.65, 3.04, 3.2,3.65,
             3.2,2.95,3.75,3.2,
             3.34,5.09,3.54,4.55,
            4.3,3.04,3.54,3.9,
            5.65,4.75,4.15,4.05,
            3.95,3.29,3.34,4.4
            
             ),
  "120h" = c(2.3,1.95,
             0,0,
             0,0,
             0,0,0,0,
             1.35,1.79,1.85,2.59,0,2.2,2.79,2.95,
             2.5,3.09,2.45,2.34,2.04,0,3.04,0,
             3.75,3.34,5.75,3.9,
             4.69,5.75,4.09,5.8,
             5.15,4.64,3.95,4,
             6.15,5.25,4.34,4.4,
             3.39,3.79,4.09,4.94
             
             ),
  "144h" = c(2.1,2.65,
             0,0,
             0,0,
             0,0,0,0,
             0,0,0,0,0,0,0,0,
             4.15,3.09,2.4,3.65,2.84,1.75,3.5,4.19,
             0,0,0,0,
             3.09,5.84,4.09,6.59,
             5.34,4.8,5.5,4.8,
             7.05,5.34,5.65,5.19,
             4.4,4.5,5.4,5.09
             
             ),
  "168h" = c(2.75,2.05,
             0,0,
             0,0,
             0,0,0,0,
             0,0,0,0,0,0,0,0,
             0,0,0,0,0,0,0,0,
             0,0,0,0,
             0,0,0,0,
             4.9,6.09,4.8,5.5,
             0,0,0,0,
             4.84,3.79,5.8,5.65
             
              ),
  "192h" = c(1.9,2.4,
             0,0,
             0,0,
             0,0,0,0,
             0,0,0,0,0,0,0,0,
             0,0,0,0,0,0,0,0,
             0,0,0,0,
             0,0,0,0,
             0,0,0,0,
             0,0,0,0,
             0,0,0,4.34
             
             ),
  "216h" = c(3.09,1.94,
             0,0,
             0,0,
             0,0,0,0,
             0,0,0,0,0,0,0,0,
             0,0,0,0,0,0,0,0,
             0,0,0,0,
             0,0,0,0,
             0,0,0,0,
             0,0,0,0,
             0,0,0,3.45
             
             ),
  "240h" = c(1.95,2.09,
            0,0,
            0,0,
            0,0,0,0,
            0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,
            0,0,0,0,
            0,0,0,0,
            0,0,0,0,
            0,0,0,0,
            0,0,0,2.5
            
            )
)

cultivo <- data.frame(
  
  ID = rep(c(
    "C1B3","C1C3",
    "C1B4","C1C4",
    "C1B5","C1C5",
    "C2B2","C2C2","C2B3","C2C3",
    "C2B4","C2C4","C2B5","C2C5",
    "C3B2","C3C2","C3B3","C3C3",
    "C3B4","C3C4","C3B5","C3C5",
    "C4B2","C4C2","C4B3","C4C3",
    "C4B4","C4C4","C4B5","C4C5",
    "C5B2","C5C2","C5B3","C5C3",
    "C5B4","C5C4","C5B5","C5C5",
    "C6B2","C6C2","C6B3","C6C3",
    "C6B4","C6C4","C6B5","C6C5",
    "C6B6","C6C6",
    "C6B7","C6C7"
  ), each = 9),
  
  Suero = rep(c(
    40,40,
    40,40,
    40,40,
    40,40,40,40,
    40,40,40,40,
    20,20,20,20,
    20,20,20,20,
    40,40,40,40,
    20,20,20,20,
    20,20,20,20,
    20,20,20,20,
    20,20,20,20,
    20,20,20,20,
    20,20,
    20,20
  ), each = 9),
  
  
  Tiempo = rep(c(
    48,72,96,120,144,168,192,216,240
  ), times = 50),
  
  Parasitemia = c(
    # C1B3
    0,0,1.3,2.3,2.1,2.75,1.9,3.09,1.95,
    # C1C3
    0,0,2.5,1.95,2.65,2.05,2.4,1.94,2.09,
    
    # C1B4
    1.74,1.45,2.7,0,0,0,0,0,0,
    # C1C4
    1.04,1.14,2.44,0,0,0,0,0,0,
    
    # C1B5
    1.5,1.75,0,0,0,0,0,0,0,
    # C1C5
    2.65,2.9,0,0,0,0,0,0,0,
    
    # C2B2
    1.65,2.29,2.39,0,0,0,0,0,0,
    # C2C2
    2.4,2.69,2.84,0,0,0,0,0,0,
    
    # C2B3
    1.79,2.34,3.39,0,0,0,0,0,0,
    # C2C3
    2.65,2.39,2.94,0,0,0,0,0,0,
    
    # C2B4
    1.85,2.39,2.34,1.35,0,0,0,0,0,
    # C2C4
    1.2,2.89,1.89,1.79,0,0,0,0,0,
    
    # C2B5
    1.69,2.79,3.25,1.85,0,0,0,0,0,
    # C2C5
    2.25,2.59,2.5,2.59,0,0,0,0,0,
    
    # C3B2
    1.04,1.44,1.99,0,0,0,0,0,0,
    # C3C2
    1.04,1.85,1.79,2.2,0,0,0,0,0,
    
    # C3B3
    1.2,1.75,2.04,2.79,0,0,0,0,0,
    # C3C3
    1.25,1.79,2.44,2.95,0,0,0,0,0,
    
    # C3B4
    1.39,1.6,2.45,2.5,4.15,0,0,0,0,
    # C3C4
    1.14,2.09,2.65,3.09,3.09,0,0,0,0,
    
    # C3B5
    0.5,1.95,1.35,2.45,2.4,0,0,0,0,
    # C3C5
    1.49,1.75,2.75,2.34,3.65,0,0,0,0,
    
    # C4B2
    1.1,1.35,3.65,2.04,2.84,0,0,0,0,
    # C4C2
    1.85,2.25,3.04,0,1.75,0,0,0,0,
    
    # C4B3
    0.8,2.29,3.2,3.04,3.5,0,0,0,0,
    # C4C3
    0.54,2.59,3.65,0,4.19,0,0,0,0,
    
    # C4B4
    1.6,1.45,3.2,3.75,0,0,0,0,0,
    # C4C4
    1.7,2.09,2.95,3.34,0,0,0,0,0,
    
    # C4B5
    1.29,2.04,3.75,5.75,0,0,0,0,0,
    # C4C5
    1.89,3.59,3.2,3.9,0,0,0,0,0,
    
    # C5B2
    1.54,2.95,3.34,4.69,3.09,0,0,0,0,
    # C5C2
    2.04,2.84,5.09,5.75,5.84,0,0,0,0,
    
    # C5B3
    1.29,2.4,3.54,4.09,4.09,0,0,0,0,
    # C5C3
    2.09,2.75,4.55,5.8,6.59,0,0,0,0,
    
    # C5B4
    2.0,2.09,4.3,5.15,5.34,4.9,0,0,0,
    # C5C4
    1.95,2.9,3.04,4.69,4.8,4.8,0,0,0,
    
    # C5B5
    1.85,2.25,3.35,3.95,5.5,6.09,0,0,0,
    # C5C5
    1.85,2.45,3.9,4,4.8,5.5,0,0,0,
    
    # C6B2
    2.45,4,5.65,6.15,7.05,0,0,0,0,
    # C6C2
    2.15,3.09,4.75,5.25,5.34,0,0,0,0,
    
    # C6B3
    1.85,3.09,4.15,4.34,5.65,0,0,0,0,
    # C6C3
    2.5,2.79,4.05,4.4,5.19,0,0,0,0,
    
    # C6B4
    1.79,2.79,3.95,3.95,4.4,4.84,0,0,0,
    # C6C4
    1.79,2.34,3.29,3.79,4.5,3.79,0,0,0,
    
    # C6B5
    1.75,2.75,3.34,4.09,5.4,5.8,0,0,0,
    # C6C5
    2.34,3.65,4.4,4.94,5.09,5.65,4.34,3.45,2.5,
    
    # C6B6
    3.2,3.79,4.3,5.4,5.15,5.94,0,0,0,
    # C6C6
    2.04,2.9,3.04,5.59,4.44,4.15,0,0,0,
    
    # C6B7
    1.75,2.29,3.25,4.3,4.8,3.56,0,0,0,
    # C6C7
    1.35,2.09,3.45,4.44,3.9,2.34,0,0,0
  )
)

ggplot(cultivo, aes(
  x = Tiempo,
  y = ifelse(Parasitemia == 0, NA, Parasitemia),
  group = ID,
  color = factor(Suero)
)) +
  geom_line() +
  geom_point() +
  labs(
    x = "Tiempo (h)",
    y = "Parasitemia (%)",
    color = "Suero (%)"
  ) +
  theme_classic()


library(ggplot2)

cultivo$Tiempo <- factor(
  cultivo$Tiempo,
  levels = c(48, 72, 96, 120, 144, 168, 192, 216, 240)
)

ggplot(cultivo, aes(x = Tiempo, y = Parasitemia)) +
  geom_boxplot(
    fill = "lightblue",
    color = "black",
    width = 0.65,
    outlier.shape = 16,
    outlier.size = 1.5
  ) +
  geom_jitter(
    width = 0.12,
    alpha = 0.45,
    size = 1.5
  ) +
  labs(
    title = "Distribución de la parasitemia por tiempo",
    x = "Tiempo de cultivo (h)",
    y = "Parasitemia (%)"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(color = "black")
  )

cultivo$Tiempo <- factor(
  cultivo$Tiempo,
  levels = c(48, 72, 96, 120, 144, 168, 192, 216, 240)
)

ggplot(subset(cultivo, Parasitemia > 0),aes(x = Tiempo, y = Parasitemia))+
  geom_boxplot(
    fill = "lightblue",
    color = "black",
    width = 0.65,
    outlier.shape = 16,
    outlier.size = 1.5
  ) +
  geom_jitter(
    width = 0.12,
    alpha = 0.45,
    size = 1.5
  ) +
  labs(
    title = "Distribución de la parasitemia por tiempo",
    x = "Tiempo de cultivo (h)",
    y = "Parasitemia (%)"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(color = "black")
  )

## Estimando los valores de tiempo 0 de TODOS los cultivos.

# La estimacion se va a realizar a partir de la parasitemia que presentaba el cultivo
# original del que se obtuvo el subcultivo y la proporcion que se manejo.

cultivoIni <- data.frame(
  
  ID = rep(c(
    "C1B3","C1C3",
    "C1B4","C1C4",
    "C1B5","C1C5",
    "C2B2","C2C2","C2B3","C2C3",
    "C2B4","C2C4","C2B5","C2C5",
    "C3B2","C3C2","C3B3","C3C3",
    "C3B4","C3C4","C3B5","C3C5",
    "C4B2","C4C2","C4B3","C4C3",
    "C4B4","C4C4","C4B5","C4C5",
    "C5B2","C5C2","C5B3","C5C3",
    "C5B4","C5C4","C5B5","C5C5",
    "C6B2","C6C2","C6B3","C6C3",
    "C6B4","C6C4","C6B5","C6C5",
    "C6B6","C6C6",
    "C6B7","C6C7"
  ), each = 11),
  
  Suero = rep(c(
    40,40,
    40,40,
    40,40,
    40,40,40,40,
    40,40,40,40,
    20,20,20,20,
    20,20,20,20,
    40,40,40,40,
    20,20,20,20,
    20,20,20,20,
    20,20,20,20,
    20,20,20,20,
    20,20,20,20,
    20,20,
    20,20
  ), each = 11),
  
  
  
  Tiempo = rep(c(
    0,24,48,72,96,120,144,168,192,216,240
  ), times = 50),
  
  Parasitemia = c(
    # C1B3
    0,0,0,0,1.3,2.3,2.1,2.75,1.9,3.09,1.95,
    # C1C3
    0,0,0,0,2.5,1.95,2.65,2.05,2.4,1.94,2.09,
    
    # C1B4
    # Se subcultivo desde el dia 10 de C1B3 en 1:4, por lo que se disminuyó teoricamente
    # la parasitemia en un cuarto. 1.95/4.
    0.4875,0,1.74,1.45,2.7,0,0,0,0,0,0,
    # C1C4
    # Se subcultivo desde el dia 10 de C1C3 en 1:4. 2.09/4
    0.5225,0,1.04,1.14,2.44,0,0,0,0,0,0,
    
    # C1B5
    # Se subcultivo desde el dia 4 de C1B4 en 1:4. 2.7/4
    0.675,0,1.5,1.75,0,0,0,0,0,0,0,
    # C1C5
    # Se subcultivo desde el dia 4 de C1C4 en 1:4. 2.44/4
    0.61,0,2.65,2.9,0,0,0,0,0,0,0,
    
    # C2B2
    # Todo este grupo de cultivos se subcultivo desde el dia 4 de C1B5 en 1:4. 2.8/4
    0.7,0,1.65,2.29,2.39,0,0,0,0,0,0,
    # C2C2
    0.7,0,2.4,2.69,2.84,0,0,0,0,0,0,
    # C2B3
    0.7,0,1.79,2.34,3.39,0,0,0,0,0,0,
    # C2C3
    0.7,0,2.65,2.39,2.94,0,0,0,0,0,0,
    
    # C2B4
    # Este grupo fue subcultivado desde el dia 4 de C2B3 en 1:4.3.39/4 
    0.8475,0,1.85,2.39,2.34,1.35,0,0,0,0,0,
    # C2C4
    0.8475,0,1.2,2.89,1.89,1.79,0,0,0,0,0,
    
    # C2B5
    # Este grupo fue subcultivado desde el dia 4 de C2C3 en 1:4.2.94/4 
    0.735,0,1.69,2.79,3.25,1.85,0,0,0,0,0,
    # C2C5
    0.735,0,2.25,2.59,2.5,2.59,0,0,0,0,0,
    
    # C3B2
    # Este grupo fue subcultivado desde el dia 4 de C2B3 en 1:4.3.39/4 
    0.8475,0,1.04,1.44,1.99,0,0,0,0,0,0,
    # C3C2
    0.8475,0,1.04,1.85,1.79,2.2,0,0,0,0,0,
    
    # C3B3
    # Este grupo fue subcultivado desde el dia 4 de C2C3 en 1:4.2.94/4 
    0.735,0,1.2,1.75,2.04,2.79,0,0,0,0,0,
    # C3C3
    0.735,0,1.25,1.79,2.44,2.95,0,0,0,0,0,
    
    # C3B4
    # Este grupo fue subcultivado desde el dia 5 de C3C3 en 1:4. 2.95/4
    0.7375,0,1.39,1.6,2.45,2.5,4.15,0,0,0,0,
    # C3C4
    0.7375,0,1.14,2.09,2.65,3.09,3.09,0,0,0,0,
    # C3B5
    0.7375,0,0.5,1.95,1.35,2.45,2.4,0,0,0,0,
    # C3C5
    0.7375,0,1.49,1.75,2.75,2.34,3.65,0,0,0,0,
    
    # C4B2
    # Este grupo fue subcultivado desde el dia 5 de C2C5 en 1:4. 2.59/4
    0.6475,0,1.1,1.35,3.65,2.04,2.84,0,0,0,0,
    # C4C2
    0.6475,0,1.85,2.25,3.04,0,1.75,0,0,0,0,
    # C4B3
    0.6475,0,0.8,2.29,3.2,3.04,3.5,0,0,0,0,
    # C4C3
    0.6475,0,0.54,2.59,3.65,0,4.19,0,0,0,0,
    
    # C4B4
    # Este grupo fue subcultivado desde el dia 6 de C3C4 en 1:4. 4.15/4
    1.0375,0,1.6,1.45,3.2,3.75,0,0,0,0,0,
    # C4C4
    1.0375,0,1.7,2.09,2.95,3.34,0,0,0,0,0,
    # C4B5
    1.0375,0,1.29,2.04,3.75,5.75,0,0,0,0,0,
    # C4C5
    1.0375,0,1.89,3.59,3.2,3.9,0,0,0,0,0,
    
    # C5B2
    # Este grupo fue subcultivado desde el dia 5 de C4B5 en 1:4. 5.75/4
    1.4375,0,1.54,2.95,3.34,4.69,3.09,0,0,0,0,
    # C5C2
    1.4375,0,2.04,2.84,5.09,5.75,5.84,0,0,0,0,
    # C5B3
    1.4375,0,1.29,2.4,3.54,4.09,4.09,0,0,0,0,
    # C5C3
    1.4375,0,2.09,2.75,4.55,5.8,6.59,0,0,0,0,
    
    # C5B4
    # Este grupo fue subcultivado desde el dia 6 de C5C3 en 1:4. 6.59/4
    1.6475,0,2.0,2.09,4.3,5.15,5.34,4.9,0,0,0,
    # C5C4
    1.6475,0,1.95,2.9,3.04,4.69,4.8,4.8,0,0,0,
    # C5B5
    1.6475,0,1.85,2.25,3.35,3.95,5.5,6.09,0,0,0,
    # C5C5
    1.6475,0,1.85,2.45,3.9,4,4.8,5.5,0,0,0,
    
    # C6B2
    # Este grupo fue subcultivado desde el dia 7 de C5B5 en 1:4. 6.09/4
    1.5225,0,2.45,4,5.65,6.15,7.05,0,0,0,0,
    # C6C2
    1.5225,0,2.15,3.09,4.75,5.25,5.34,0,0,0,0,
    # C6B3
    1.5225,0,1.85,3.09,4.15,4.34,5.65,0,0,0,0,
    # C6C3
    1.5225,0,2.5,2.79,4.05,4.4,5.19,0,0,0,0,
    
    # C6B4
    # Este grupo fue subcultivado desde el dia 6 de C6B2 en 1:4. 7.05/4
    1.7625,0,1.79,2.79,3.95,3.95,4.4,4.84,0,0,0,
    # C6C4
    1.7625,0,1.79,2.34,3.29,3.79,4.5,3.79,0,0,0,
    # C6B5
    1.7625,0,1.75,2.75,3.34,4.09,5.4,5.8,0,0,0,
    # C6C5
    1.7625,0,2.34,3.65,4.4,4.94,5.09,5.65,4.34,3.45,2.5,
    
    # C6B6
    # Este grupo fue subcultivado desde el dia 7 de C6B5 en 1:4. 5.8/4
    1.45,0,3.2,3.79,4.3,5.4,5.15,5.94,0,0,0,
    # C6C6
    1.45,0,2.04,2.9,3.04,5.59,4.44,4.15,0,0,0,
    
    # C6B7
    # Este grupo fue subcultivado desde el dia 7 de C6B6 en 1:4. 5.95/4
    1.4875,0,1.75,2.29,3.25,4.3,4.8,3.56,0,0,0,
    # C6C7
    1.4875,0,1.35,2.09,3.45,4.44,3.9,2.34,0,0,0
  )
)

cultivoIni$Tiempo <- factor(
  cultivoIni$Tiempo,
  levels = c(0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240)
)

ggplot(subset(cultivoIni, Parasitemia > 0),aes(x = Tiempo, y = Parasitemia))+
  geom_boxplot(
    fill = "lightblue",
    color = "black",
    width = 0.65,
    outlier.shape = 16,
    outlier.size = 1.5
  ) +
  geom_jitter(
    width = 0.12,
    alpha = 0.45,
    size = 1.5
  ) +
  labs(
    title = "Distribución de la parasitemia por tiempo",
    x = "Tiempo de cultivo (h)",
    y = "Parasitemia (%)"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(color = "black")
  )

Modelo <- read.csv("03_Data/BaseDatosM2")
Modelo$tiempo <- (Modelo$tiempo/100000)*24
library(ggplot2)

cultivo$Tiempo <- factor(
  cultivo$Tiempo,
  levels = c(0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240)
)

ggplot() +
  geom_boxplot(
    data = subset(cultivoIni, Parasitemia > 0),
    aes(x = as.numeric(as.character(Tiempo)),
        y = Parasitemia,
        group = Tiempo),
    fill = "lightblue",
    color = "black",
    width = 10,
    outlier.shape = NA
  ) +
  geom_jitter(
    data = subset(cultivoIni, Parasitemia > 0),
    aes(x = as.numeric(as.character(Tiempo)),
        y = Parasitemia),
    width = 2,
    alpha = 0.35,
    size = 1.3
  ) +
  geom_line(
    data = Modelo,
    aes(x = tiempo, y = estimado_parasitemia),
    color = "red",
    linewidth = 1.2
  ) +
  labs(
    title = "Parasitemia experimental y predicción del modelo",
    x = "Tiempo de cultivo (h)",
    y = "Parasitemia (%)"
  ) +
  theme_classic()

Modelo2 <- read.csv("03_Data/BaseDatosM2_A")
Modelo2$tiempo <- (Modelo2$tiempo/1000)*24
library(ggplot2)

cultivo$Tiempo <- factor(
  cultivo$Tiempo,
  levels = c(0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240)
)

ggplot() +
  geom_boxplot(
    data = subset(cultivoIni, Parasitemia > 0),
    aes(x = as.numeric(as.character(Tiempo)),
        y = Parasitemia,
        group = Tiempo),
    fill = "lightblue",
    color = "black",
    width = 10,
    outlier.shape = NA
  ) +
  geom_jitter(
    data = subset(cultivoIni, Parasitemia > 0),
    aes(x = as.numeric(as.character(Tiempo)),
        y = Parasitemia),
    width = 2,
    alpha = 0.35,
    size = 1.3
  ) +
  geom_line(
    data = Modelo2,
    aes(x = tiempo, y = estimado_parasitemia),
    color = "red",
    linewidth = 1.2
  ) +
  labs(
    title = "Parasitemia experimental y predicción del modelo",
    x = "Tiempo de cultivo (h)",
    y = "Parasitemia (%)"
  ) +
  theme_classic()

ggplot() +
  geom_boxplot(
    data = subset(cultivoIni, Parasitemia > 0 & Suero == 20),
    aes(x = as.numeric(as.character(Tiempo)),
        y = Parasitemia,
        group = Tiempo),
    fill = "lightblue",
    color = "black",
    width = 10,
    outlier.shape = NA
  ) +
  geom_jitter(
    data = subset(cultivoIni, Parasitemia > 0 & Suero == 20),
    aes(x = as.numeric(as.character(Tiempo)),
        y = Parasitemia),
    width = 2,
    alpha = 0.35,
    size = 1.3
  ) +
  geom_line(
    data = Modelo2,
    aes(x = tiempo, y = estimado_parasitemia),
    color = "red",
    linewidth = 1.2
  ) +
  labs(
    title = "Parasitemia experimental y predicción del modelo",
    subtitle = "Modificacion en muI y beta. Unicamente datos con 20% de SNB",
    x = "Tiempo de cultivo (h)",
    y = "Parasitemia (%)"
  ) +
  theme_classic()

filt <- cultivoIni$Parasitemia[23:506]

Dif <- data.frame()

for (i in 1:(length(filt)/11)) {
  d1 <- filt[3+(11*(i-1))] - filt[1+(11*(i-1))]
  Dif[i,1] <- d1
  for (j in 1:8) {
    if(filt[(3+j)+(11*(i-1))] == 0 | filt[(3+(j-1))+(11*(i-1))] == 0){
      d <- NA
    } else {
      d <- filt[(3+j)+(11*(i-1))] - filt[(3+(j-1))+(11*(i-1))]
    }
    Dif[i,j+1] <- d
  }
}

## A partir de 48, normalizar con respecto al inicial.
Norm <- data.frame()
levels <- c(48, 72, 96, 120, 144, 168, 192, 216, 240)
for (i in 1:(length(filt)/11)) {
  for (j in 1:8) {
    if(filt[(3+j)+(11*(i-1))] == 0 | filt[1+(11*(i-1))] == 0){
      D <- NA
      } else {
        D <- filt[(3+j)+(11*(i-1))] - filt[1+(11*(i-1))]
      }
    Norm[j+(8*(i-1)),1] <- levels[j]
    Norm[j+(8*(i-1)),2] <- D
  }
}
names(Norm) <- c(
  "Tiempo",
  "ParasitemiaNorm"
)

ggplot(Norm, aes(x = Tiempo, y = ParasitemiaNorm)) +
  geom_point()

filt2 <- cultivoIni[23:506,]
filt3 <- filt2[which(filt2[,2] == 40),4]

Norm2 <- data.frame()
levels <- c(48, 72, 96, 120, 144, 168, 192, 216, 240)
for (i in 1:(length(filt3)/11)) {
  for (j in 1:8) {
    if(filt3[(3+j)+(11*(i-1))] == 0 | filt3[1+(11*(i-1))] == 0){
      D <- NA
    } else {
      D <- filt3[(3+j)+(11*(i-1))] - filt3[1+(11*(i-1))]
    }
    Norm2[j+(8*(i-1)),1] <- levels[j]
    Norm2[j+(8*(i-1)),2] <- D
  }
}
names(Norm2) <- c(
  "Tiempo",
  "ParasitemiaNorm"
)

ggplot(Norm2, aes(x = Tiempo, y = ParasitemiaNorm)) +
  geom_boxplot(
    data = Norm2,
    aes(x = Tiempo,
        y = ParasitemiaNorm,
        group = Tiempo)
  ) +
  geom_point()

Modelo2
for (i in 1:length(Modelo2[,1])) {
  Modelo2[i,6] <- Modelo2[i,5] - Modelo2[1,5]
}
names(Modelo2) <- c(
  "X",
  "tiempo",
  "eritrocitos_sanos",
  "eritrocitos_infectados",
  "estimado_parasitemia",
  "ParasitemiaNorm"
)

ggplot(Norm, aes(x = Tiempo, y = ParasitemiaNorm)) +
  geom_boxplot(
    data = Norm,
    aes(x = Tiempo,
        y = ParasitemiaNorm,
        group = Tiempo),
    fill = "lightblue",
    color = "black",
    width = 10,
    outlier.shape = NA
  ) +
  geom_point() +
  geom_line(
    data = Modelo2,
    aes(x = tiempo, y = ParasitemiaNorm),
    color = "red",
    linewidth = 1.2
  ) +
  labs(
    title = "Parasitemia experimental normalizada y predicción del modelo",
    subtitle = "Modificacion en muI y beta. Normalizado con respecto a T0",
    x = "Tiempo de cultivo (h)",
    y = "Parasitemia (%)"
  ) +
  theme_classic()

ggplot(Norm2, aes(x = Tiempo, y = ParasitemiaNorm)) +
  geom_boxplot(
    data = Norm2,
    aes(x = Tiempo,
        y = ParasitemiaNorm,
        group = Tiempo),
    fill = "lightblue",
    color = "black",
    width = 10,
    outlier.shape = NA
  ) +
  geom_point() +
  geom_line(
    data = Modelo2,
    aes(x = tiempo, y = ParasitemiaNorm),
    color = "red",
    linewidth = 1.2
  ) 

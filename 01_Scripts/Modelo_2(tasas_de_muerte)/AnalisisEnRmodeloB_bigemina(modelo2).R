########################################################################################
######################### MODELO 2 BABESIA BIGEMINA ##############################
########################################################################################

#### Definiendo el sistema

## Paquetes necesarios para empezar el trabajo ##
source("01_Scripts/Grind.R")
library(phaseR)
library(deSolve)
library(plotly)

# par(mfrow = c(1,1)) opcional para trabajar en una correcta configuracion de graficas.

## Modelo inicial, se plantea de forma simbolica.
model <- function(t,state,parms){
  
  with(as.list(c(state,parms)),{
    
    # Ecuacion para poblacion de parasitos infectivos
    dx <- - beta*y*x - muB*x + rho*muI*z
    
    # Ecuacion para poblacion de eritrocitos sanos
    dy <- - beta*y*x - muE*y
    
    # Ecuacion para poblacion de eritrocitos infectados
    dz <- beta*y*x - muI*z
    
    list(c(dx,dy,dz))
  })
}

## Parametros. Todos son dias-1, definir unidades de variables de estado.
p <- c(
  beta = 3.3*(10^-8), ### Unidades concentracion-1 por ser parametros de segundo orden.
  muB = 20,
  muE = 0.01,
  muI = 4,
  rho = 2 # proporcion
)

## Condiciones iniciales, Adaptar a unidades de concentracion. Adaptar al volumen. Esto promueve que sean continuas las unidades.
s <- c(
  x = 2*(10^2),
  y = 9*(10^8),
  z = 1*(10^7)
)

## Simulación
library(deSolve)
library(ggplot2)
times <- seq(0,10,0.0001)
out <- ode(
  y=s,
  times=times,
  func=model,
  parms=p
)
data <- data.frame()
for (i in 1:length(out[,1])) {
  pp <- (out[i,4]/(out[i,3]+out[i,4]))*100
  data[i,1] <- i
  data[i,2] <- out[i,3]
  data[i,3] <- out[i,4]
  data[i,4] <- pp
}
names(data) <- c(
  "tiempo",
  "eritrocitos_sanos",
  "eritrocitos_infectados",
  "estimado_parasitemia"
)
pdf ("02_Images/Simulacionmodelo2.pdf")
run(tmax = 10, tstep = 0.0001, state = s, parms = p, odes = model)

ggplot(data, aes(x = tiempo, y = estimado_parasitemia))+
  geom_line()+ 
  labs (x = "Tiempo (10 dias en 0.0001)",
        y = "Valor de parasitemia",
        title = "Parasitemia en simulacion")

dev.off()
s <- c(x = 1, y = 1, z = 1)

## Busqueda numerica de puntos de equilibrio.
plane(xmin=-5,xmax=5, ymin = -20,ymax = 5)
first <- newton(s,plot=T)
second <- newton(c(x = 0, y = -20, z = 0),plot=T) ## Rebaba.

## Analisis de bifurcaciones de los primeros puntos de equilibrio.
continue(state=first, parms = p, odes=model, x="beta", step=0.0001, 
         xmin=0,xmax=2,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="beta", step=0.0001, 
         xmin=0,xmax=2,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="beta", step=0.0001, 
         xmin=0,xmax=2,y="z", ymin=-1, ymax=100)

continue(state=second, parms = p, odes=model, x="beta", step=0.0001, 
         xmin=0,xmax=2,y="x", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="beta", step=0.0001, 
         xmin=0,xmax=2,y="y", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="beta", step=0.0001, 
         xmin=0,xmax=2,y="z", ymin=-1, ymax=100)
## Sin bifurcaciones.

continue(state=first, parms = p, odes=model, x="muB", step=0.01, 
         xmin=0,xmax=100,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="muB", step=0.01, 
         xmin=0,xmax=100,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="muB", step=0.01, 
         xmin=0,xmax=100,y="z", ymin=-1, ymax=100)

continue(state=second, parms = p, odes=model, x="muB", step=0.01, 
         xmin=0,xmax=100,y="x", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="muB", step=0.01, 
         xmin=0,xmax=100,y="y", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="muB", step=0.01, 
         xmin=0,xmax=100,y="z", ymin=-1, ymax=100)
## Bifurcacion en muB = 0.

continue(state=first, parms = p, odes=model, x="muE", step=0.0001, 
         xmin=0,xmax=1,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="muE", step=0.0001, 
         xmin=0,xmax=1,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="muE", step=0.0001, 
         xmin=0,xmax=1,y="z", ymin=-1, ymax=100)

continue(state=second, parms = p, odes=model, x="muE", step=0.0001, 
         xmin=0,xmax=1,y="x", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="muE", step=0.0001, 
         xmin=0,xmax=1,y="y", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="muE", step=0.0001, 
         xmin=0,xmax=1,y="z", ymin=-1, ymax=100)

# Bifurcation at muE = -1e-04 

continue(state=first, parms = p, odes=model, x="muI", step=0.001, 
         xmin=0,xmax=25,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="muI", step=0.001, 
         xmin=0,xmax=25,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="muI", step=0.001, 
         xmin=0,xmax=25,y="z", ymin=-1, ymax=100)

continue(state=second, parms = p, odes=model, x="muI", step=0.001, 
         xmin=0,xmax=25,y="x", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="muI", step=0.001, 
         xmin=0,xmax=25,y="y", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="muI", step=0.001, 
         xmin=0,xmax=25,y="z", ymin=-1, ymax=100)

# Bifurcation at muI = -0.025 

continue(state=first, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=25,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=25,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=25,y="z", ymin=-1, ymax=100)

continue(state=second, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=25,y="x", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=25,y="y", ymin=-1, ymax=100)
continue(state=second, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=25,y="z", ymin=-1, ymax=100)


###### Ciclo para obtener valores maximos y analisis de picos #############
data <- data.frame(
  parametro = c(),
  valor_parametro = c(),
  maximo = c(),
  tiempo_maximo = c(),
  tiempo_mayor_infectados = c(),
  parasitemiamax = c()
)
count <- 0

p2 <- c(
  beta = 3.3*(10^-8),
  muB = 20,
  muE = 0.01,
  muI = 4,
  rho = 2 
)

para <- c("beta", "muB", "muE", "muI", "rho")
times <- seq(0,10,0.001)

for (j in 1:length(p)) {
  count <- count + 1
  pms <- para[j]
  if(j > 1){
    p[(j-1)] <- p2[(j-1)]
  }else{}
  for (i in 1:length(seq(0,25, by = 0.1))) {
    p[j] <- (seq(0,25, by = 0.1))[i]
    out <- ode(
      y=s,
      times=times,
      func=model,
      parms=p
    )
    maxi <- max(out[,4])
    tpmax <- out[which(out[,4] == maxi)[1],1]
    tp <- out[which(out[,4] > out[,3])[1],1]
    parasitemiamax <- (maxi/(out[which(out[,4] == maxi)[1],3]+maxi))*100
    data[count,1] <- pms
    data[count,2] <- p[j]
    data[count,3] <- maxi
    data[count,4] <- tpmax
    data[count,5] <- tp
    data[count,6] <- parasitemiamax
    count <- count + 1
  }
}

write.csv(data, "03_Data/datos_maximos(modelo2).csv")

## Datos de maximos al variar los parametros
data <- read.csv("03_Data/datos_maximos(modelo2).csv")

str(data)


### Graficas de base de datos de maximos
library(ggplot2)
library(gridExtra)

pdf("02_Images/GraficasDatosMax(modelo2).pdf")
ggplot(data, aes(x = V2, y = V3, color = V1)) +
  geom_line(linewidth = 1.2) + 
  labs (x = "Valor del parametro",
        y = "Valor maximo de poblacion infectada",
        color = "Parametro",
        title = "Parametros vs Valor maximo de parasitos",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el 
        modelo base para obtener los valores maximos de infeccion.")

# Color alternativo

ggplot(data, aes(x = V2, y = V3, color = V1)) +
  geom_line(linewidth = 1.2) + 
  labs (x = "Valor del parametro",
        y = "Valor maximo de poblacion infectada",
        color = "Parametro",
        title = "Parametros vs Valor maximo de parasitos",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el 
        modelo base para obtener los valores maximos de infeccion.") +
  scale_color_manual (
    values = c(
      "green", 
      "blue",
      "red",
      "black",
      "orange",
      "darkgreen",
      "purple",
      "white"
    ))

data[2,]
# Graficas individuales

for(i in 1:length(unique(data$V1))){
  datafor <- data[which(data$V1 == unique(data$V1)[i]),]
  para <- unique(data$V1)[i]
  print( ggplot(datafor, aes(x = V2, y = V3)) +
           geom_line(linewidth = 1.2) + 
           labs (x = paste("Valor del parametro ", para),
                 y = "Valor maximo de poblacion infectada",
                 title = paste(
                   "Parametros vs Valor maximo de parasitos para: ", para),
                 caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo 
                 el modelo base para obtener los valores maximos de infeccion.")
  )
}

### Ahora con el tiempo para llegar al valor maximo

ggplot(data, aes(x = V2, y = V4, color = V1)) +
  geom_line(linewidth = 1.2) + 
  labs (x = "Valor del parametro",
        y = "Tiempo para llegar al valor maximo de infectados",
        color = "Parametro",
        title = "Parametros vs tiempo de valor maximo de infectados",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo 
        el modelo base para obtener los valores maximos de infeccion y el tiempo de llegada.")

# Graficas individuales vs el valor maximo 

for(i in 1:length(unique(data$V1))){
  datafor <- data[which(data$V1 == unique(data$V1)[i]),]
  para <- unique(data$V1)[i]
  valormax <- ggplot(datafor, aes(x = V2, y = V3)) +
    geom_line(linewidth = 1.2) +
    labs(
      x = NULL,
      y = "maximo de infeccion",
      title = paste(
        "Parametro vs tiempo de valor maximo de infectados para: ", para)
    )
  
  tiempomax <- ggplot(datafor, aes(x = V2, y = V4)) +
    geom_line(linewidth = 1.2) +
    labs(
      x = paste("Valor del parametro ",para),
      y = "Tiempo paramvalor maximo"
    )
  print(grid.arrange(
    valormax,
    tiempomax,
    ncol = 1)
  )
}

## Por ultimo con el tiempo si es que existe en el que el numero de infectados supera a sanos

ggplot(data, aes(x = V2, y = V5, color = V1)) +
  geom_line(linewidth = 1) + 
  labs (x = "Valor del parametro",
        y = "Tiempo para superar valor",
        color = "Parametro",
        title = "Parametros vs tiempo de mayor infectados",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 
        se evaluo el modelo base para obtener el tiempo en el que se supera la infeccion"
  )
# Graficas individuales

for(i in 1:length(unique(data$V1))){
  datafor <- data[which(data$V1 == unique(data$V1)[i]),]
  para <- unique(data$V1)[i]
  print( ggplot(datafor, aes(x = V2, y = V5)) +
           geom_line(linewidth = 1.2) + 
           labs (x = paste("Valor del parametro ", para),
                 y = "Valor maximo de poblacion infectada",
                 title = paste(
                   "Parametros vs tiempo de mayor infectados para: ", para),
                 caption = "
                 Dentro del intervalo del 0 al 25 por 0.1 se evaluo 
                 el modelo base para obtener el tiempo en el que se supera la infeccion")
  )
}
ggplot(data, aes(x = V2, y = V6, color = V1)) +
  geom_line(linewidth = 1.2) + 
  labs (x = "Valor del parametro",
        y = "Valor de parasitemia",
        color = "Parametro",
        title = "Parametros vs Parasitemia en valor maximo",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el 
        modelo base para obtener los valores de parasitemia.")
for(i in 1:length(unique(data$V1))){
  datafor <- data[which(data$V1 == unique(data$V1)[i]),]
  para <- unique(data$V1)[i]
  print( ggplot(datafor, aes(x = V2, y = V3)) +
           geom_line(linewidth = 1.2) + 
           labs (x = paste("Valor del parametro ", para),
                 y = "Valor de parasitemia",
                 title = paste(
                   "Parametros vs Valor de parasitemia para: ", para),
                 caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo 
                 el modelo base para obtener los valores de parasitemia.")
  )
}
dev.off()

### Muestreo aleatorio con reemplazo.
library(deSolve)

data2 <- data.frame(
  valor_beta = c(),
  valor_muB = c(),
  valor_muE = c(),
  valor_muI = c(),
  valor_rho = c(),
  maximo = c(),
  tiempo_maximo = c(),
  tiempo_mayor_infectados = c(),
  parasitemiamaxima = c()
)
combinaciones <- list()

for (i in 1:5000) {
  pa <- c(runif(7, 0, 100))
  co <- 0
  if (length(combinaciones) > 1){
    for (j in 1:length(combinaciones)) {
      if(all(pa == combinaciones[[j]]) == TRUE){
        co <- co + 1
      } else{}
    }
  }else{}
  if (co == 0){
    combinaciones[[i]] <- pa
    p <- c(
      beta = pa[1],
      muB  = pa[2],
      muE = pa[3],
      muI = pa[4],
      rho   = pa[5]
    )
    out <- ode(
      y=s,
      times=times,
      func=model,
      parms=p
    )
    maxi <- max(out[,4])
    tpmax <- out[which(out[,4] == maxi)[1],1]
    tp <- out[which(out[,4] > out[,3])[1],1]
    parasitemiamax <- (maxi/(out[which(out[,4] == maxi)[1],3]+maxi))*100
    data2[i,1] <- p[1]
    data2[i,2] <- p[2]
    data2[i,3] <- p[3]
    data2[i,4] <- p[4]
    data2[i,5] <- p[5]
    data2[i,6] <- maxi
    data2[i,7] <- tpmax
    data2[i,8] <- tp
    data2[i,9] <- parasitemiamax
  }
}

names(data2) <- c(
  "valor_beta",
  "valor_muB",
  "valor_muE",
  "valor_muI",
  "valor_rho",
  "maximo",
  "tiempo_maximo",
  "tiempo_mayor_infectados",
  "parasitemia_en_valor_maximo"
)
View(data2)

write.csv(data2, "./datos_maximosrandom(modelo2).csv")

## Datos de maximos al variar los parametros
data2 <- read.csv("03_Data/datos_maximosrandom(modelo2).csv")


### Vamos a realizar el LHS, aqui queremos definir intervalos especificos, muestrear dentro de estos 
### intervalos y a partir de ahi 
interv <- list()
for (i in 1:500){ # Ciclo para generar los intervalos de muestreo
  interv[[i]] <- seq(((i*2)/10)-0.2, ((i*2)/10), by = 0.005)
}
muestreo <- data.frame()
for (i in 1:5) { # Lista para realizar el muestreo
  for (j in 1:500) {
  muestreo[j,i] <- sample(interv[[j]],1)
  }
}
muestreo2 <- muestreo
valfin <- data.frame()
for (i in 1:500) { # Combinaciones aleatorias de parametros dentro del muestreo.
  for (j in 1:5) {
    if(length(muestreo2[which(muestreo2[,j] != -1),j]) == 1){
      sampl <- muestreo2[which(muestreo2[,j] != -1),j]
    } else {
      if(any(muestreo2[,j] == -1)){
        if(any(muestreo2[,j] != -1)){
          sampl<- sample(muestreo2[which(muestreo2[,j] != -1),j],1)
        } else {
        }
      } else {
        sampl<- sample(muestreo2[,j],1)
      }
    }
      valfin[i,j] <- sampl
      muestreo2[which(muestreo2[,j] == sampl), j] <- -1
  }
}
names(valfin) <- c(
  "gamma","muB","muE","muI","rho"
  )

write.csv(interv,"03_Data/Intervalos.csv")
write.csv(muestreo, "03_Data/DatosMuestreoLHS.csv")
write.csv(muestreo2, "03_Data/ListaRemplazos.csv")
write.csv(valfin, "03_Data/LHSParametrosAleatorios.csv")

## Simulaciones con la base de datos aleatorios

library(deSolve)
model <- function(t,state,parms){
  
  with(as.list(c(state,parms)),{
    
    dx <- - beta*y*x - muB*x + rho*muI*z
    dy <- - beta*y*x - muE*y
    dz <- beta*y*x - muI*z
    
    list(c(dx,dy,dz))
  })
}

s <- c(
  x = 2*(10^2),
  y = 9*(10^8),
  z = 1*(10^7)
)
times <- seq(0,10,0.001)
data3 <- data.frame()
for (i in 1:500) {
  p <- c(
    beta  = valfin[i,1],
    muB  = valfin[i,2],
    muE = valfin[i,3],
    muI = valfin[i,4],
    rho   = valfin[i,5]
  )
  out <- ode(
    y=s,
    times=times,
    func=model,
    parms=p
  )
  maxi <- max(out[,4])
  tpmax <- out[which(out[,4] == maxi)[1],1]
  tp <- out[which(out[,4] > out[,3])[1],1]
  parasitemiamax <- (maxi/(out[which(out[,4] == maxi)[1],3]+maxi))*100
  data3[i,1] <- p[1]
  data3[i,2] <- p[2]
  data3[i,3] <- p[3]
  data3[i,4] <- p[4]
  data3[i,5] <- p[5]
  data3[i,6] <- maxi
  data3[i,7] <- tpmax
  data3[i,8] <- tp
  data3[i,9] <- parasitemiamax
}

names(data3) <- c(
  "valor_beta",
  "valor_muB",
  "valor_muE",
  "valor_muI",
  "valor_rho",
  "maximo",
  "tiempo_maximo",
  "tiempo_mayor_infectados",
  "parasitemia_en_valor_maximo"
)

write.csv(data3, "03_Data/Datos_SimulacionesLHS.csv")
data3 <- read.csv("03_Data/Datos_SimulacionesLHS.csv")


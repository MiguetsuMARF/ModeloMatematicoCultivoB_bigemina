
################## MODELO INICIAL BABESIA BIGEMINA #####################

source("01_Scripts/Grind.R")
library(phaseR)
library(deSolve)
library(plotly)

par(mfrow = c(1,1))

## Modelo
model <- function(t,state,parms){
  
  with(as.list(c(state,parms)),{
    # Ecuacion para poblacion de parasitos infectivos
    dx <- alfa - beta*y*x - omega*x + mu*(rho*(1 + psi)*z)
    # Ecuacion para poblacion de eritrocitos sanos
    dy <- gamma - beta*y*x - rho*y
    # Ecuacion para poblacion de eritrocitos infectados
    dz <- beta*y*x - rho*(1 + psi)*z
    list(c(dx,dy,dz))
  })
}

## Parametros 
p <- c(
  alfa  = 0,
  beta  = 0.005,
  omega = 1/3,
  gamma = 0,
  rho   = 1/25,
  mu    = 5,
  psi   = 2
)

## Condiciones iniciales
s <- c(
  x = 10,
  y = 1000,
  z = 0
)

## Simulación
pdf ("02_Images/SimulacionSinAlfaGamma.pdf")
run(tmax = 100, tstep = 0.001, state = s, parms = p, odes = model)
dev.off()
s <- c(x = 1, y = 1, z = 1)

plane(xmin=-5,xmax=5, ymin = -20,ymax = 5)
first <- newton(s,plot=T)
second <- newton(c(x = 100, y = 100, z = 100),plot=T)
third <- newton(c(x = 0, y = -20, z = 0),plot=T)

continue(state=first, parms = p, odes=model, x="beta", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="beta", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="beta", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)

continue(state=third, parms = p, odes=model, x="beta", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="beta", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="beta", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)


continue(state=first, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)

continue(state=third, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="rho", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)


continue(state=first, parms = p, odes=model, x="psi", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="psi", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="psi", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)

continue(state=third, parms = p, odes=model, x="psi", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="psi", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="psi", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)


continue(state=first, parms = p, odes=model, x="omega", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="omega", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=first, parms = p, odes=model, x="omega", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)

continue(state=third, parms = p, odes=model, x="omega", step=0.001, 
         xmin=0,xmax=10,y="x", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="omega", step=0.001, 
         xmin=0,xmax=10,y="y", ymin=-1, ymax=100)
continue(state=third, parms = p, odes=model, x="omega", step=0.001, 
         xmin=0,xmax=10,y="z", ymin=-1, ymax=100)

model <- function(t,state,parms){
  
  with(as.list(c(state,parms)),{
    # Ecuacion para poblacion de parasitos infectivos
    dx <- alfa - beta*y*x - omega*x + mu*(rho*(1 + psi)*z)
    # Ecuacion para poblacion de eritrocitos sanos
    dy <- gamma - beta*y*x - rho*y
    # Ecuacion para poblacion de eritrocitos infectados
    dz <- beta*y*x - rho*(1 + psi)*z
    list(c(dx,dy,dz))
  })
}

## Parametros 
p <- c(
  alfa  = 0.25,
  beta  = 0.005,
  omega = 1/3,
  gamma = 0.15,
  rho   = 1/25,
  mu    = 5,
  psi   = 2
)

## Condiciones iniciales
s <- c(
  x = 0,
  y = 1000,
  z = 0
)

## Simulación
pdf ("02_Images/SimulacionesConAlfaGamma.pdf")
run(tmax = 75, tstep = 0.01, state = s, parms = p, odes = model)
run(tmax = 500, tstep = 0.01, state = s, parms = p, odes = model)
run(tmax = 1000, tstep = 0.01, state = s, parms = p, odes = model)
dev.off()

times <- seq(0,100,0.01)
out <- ode(
  y=s,
  times=times,
  func=model,
  parms=p
)

###### Ciclo para obtener valores maximos y analisis de picos #############
data <- data.frame(
  parametro = c(),
  valor_parametro = c(),
  maximo = c(),
  tiempo_maximo = c(),
  tiempo_mayor_infectados = c()
)
count <- 0
p2 <- c(
  alfa  = 0.25,
  beta  = 0.005,
  omega = 1/3,
  gamma = 0.15,
  rho   = 1/25,
  mu    = 5,
  psi   = 2
)
para <- c("alfa", "beta", "omega", "gamma", "rho", "mu", "psi")
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
    data[count,1] <- pms
    data[count,2] <- p[j]
    data[count,3] <- maxi
    data[count,4] <- tpmax
    data[count,5] <- tp
    count <- count + 1
  }
}

write.csv(data, "03_Data/datos_maximos.csv")

## Datos de maximos al variar los parametros
data <- read.csv("03_Data/datos_maximos.csv")

str(data)


### Graficas de base de datos de maximos
library(ggplot2)
library(gridExtra)

pdf("02_Images/GraficasDatosMax.pdf")
ggplot(data, aes(x = V2, y = V3, color = V1)) +
  geom_line(linewidth = 1.2) + 
  labs (x = "Valor del parametro",
        y = "Valor maximo de poblacion infectada",
        color = "Parametro",
        title = "Parametros vs Valor maximo de parasitos",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el modelo base para obtener los valores maximos de infeccion.")

# Color alternativo

ggplot(data, aes(x = V2, y = V3, color = V1)) +
  geom_line(linewidth = 1.2) + 
  labs (x = "Valor del parametro",
        y = "Valor maximo de poblacion infectada",
        color = "Parametro",
        title = "Parametros vs Valor maximo de parasitos",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el modelo base para obtener los valores maximos de infeccion.") +
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
                 title = paste("Parametros vs Valor maximo de parasitos para: ", para),
                 caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el modelo base para obtener los valores maximos de infeccion.")
  )
}

### Ahora con el tiempo para llegar al valor maximo

ggplot(data, aes(x = V2, y = V4, color = V1)) +
  geom_line(linewidth = 1.2) + 
  labs (x = "Valor del parametro",
        y = "Tiempo para llegar al valor maximo de infectados",
        color = "Parametro",
        title = "Parametros vs tiempo de valor maximo de infectados",
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el modelo base para obtener los valores maximos de infeccion y el tiempo de llegada.")

# Graficas individuales vs el valor maximo 

for(i in 1:length(unique(data$V1))){
  datafor <- data[which(data$V1 == unique(data$V1)[i]),]
  para <- unique(data$V1)[i]
  valormax <- ggplot(datafor, aes(x = V2, y = V3)) +
    geom_line(linewidth = 1.2) +
    labs(
      x = NULL,
      y = "maximo de infeccion",
      title = paste("Parametro vs tiempo de valor maximo de infectados para: ", para)
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
        caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el modelo base para obtener el tiempo en el que se supera la infeccion"
  )
# Graficas individuales

for(i in 1:length(unique(data$V1))){
  datafor <- data[which(data$V1 == unique(data$V1)[i]),]
  para <- unique(data$V1)[i]
  print( ggplot(datafor, aes(x = V2, y = V5)) +
           geom_line(linewidth = 1.2) + 
           labs (x = paste("Valor del parametro ", para),
                 y = "Valor maximo de poblacion infectada",
                 title = paste("Parametros vs tiempo de mayor infectados para: ", para),
                 caption = "Dentro del intervalo del 0 al 25 por 0.1 se evaluo el modelo base para obtener el tiempo en el que se supera la infeccion")
  )
}

dev.off()

### Muestreo aleatorio con reemplazo.
library(deSolve)

data2 <- data.frame(
  valor_alfa = c(),
  valor_beta = c(),
  valor_omega = c(),
  valor_gamma = c(),
  valor_rho = c(),
  valor_mu = c(),
  valor_psi = c(),
  maximo = c(),
  tiempo_maximo = c(),
  tiempo_mayor_infectados = c()
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
      alfa  = pa[1],
      beta  = pa[2],
      omega = pa[3],
      gamma = pa[4],
      rho   = pa[5],
      mu    = pa[6],
      psi   = pa[7]
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
    data2[i,1] <- p[1]
    data2[i,2] <- p[2]
    data2[i,3] <- p[3]
    data2[i,4] <- p[4]
    data2[i,5] <- p[5]
    data2[i,6] <- p[6]
    data2[i,7] <- p[7]
    data2[i,8] <- maxi
    data2[i,9] <- tpmax
    data2[i,10] <- tp
  }
}

names(data2) <- c(
  "valor_alfa",
  "valor_beta",
  "valor_omega",
  "valor_gamma",
  "valor_rho",
  "valor_mu",
  "valor_psi",
  "maximo",
  "tiempo_maximo",
  "tiempo_mayor_infectados"
)
View(data2)

write.csv(data2, "./datos_maximosrandom.csv")

## Datos de maximos al variar los parametros
data2 <- read.csv("03_Data/datos_maximosrandom.csv")

inter <- list()
valores <- list()
for (i in 1:100) {
  inter[[i]] <- seq((i-1),i,by = 0.01)
}
for(i in 1:7){
  for(j in 1:100){
    valor <- sample(inter[[j]],1)
    valores[[i]][j] <- valor
  }
}

a <- list(
  b <- c(1,2,3),
  d <- c(4,5,6),
  c <- c(8,9,10)
)

a[[1]][1]

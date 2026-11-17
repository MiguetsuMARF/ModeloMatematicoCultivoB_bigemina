
## Funcion para establecer el protocolo de una ensayo de neutralizacion

EN <- function(replicas, PPE_obj, PPE_pre, hematocrito,SB, animal, pilon, conejo){
  if(animal == "V"){
    vol_final <- (200*replicas) + (pilon*2)
    iRBC <- (PPE_obj/PPE_pre)*((hematocrito/100)*vol_final)
    nRBC <- ((hematocrito/100)*vol_final)-iRBC
    mediototal <- vol_final-iRBC-nRBC
    Suero <- mediototal*(SB/100)
    medio <- mediototal-Suero
    medioM1 <- ((vol_final/2)-iRBC)-Suero
    medioM2 <- medio-medioM1
    Protocolo <- data.frame(
      Solucion = c("Mezcla1", "Mezcla2"),
      iRBCs = c(iRBC, 0),
      nRBCs = c(0, nRBC),
      MedioCompleto = c((vol_final/2)-iRBC, 0),
      MedioBase = c(0, medioM2),
      SueroParaMedioCompleto = c(Suero, 0),
      MedioParaMedioCompleto = c(medioM1, 0),
      VolumenFinal = c((vol_final/2),(vol_final/2))
    )
    Volumenes <- data.frame(
      MedioM199base = medio,
      SueroProblema = Suero,
      iRBCs = iRBC,
      nRBCs = nRBC
    )
  } else if(animal == "C"){
    vol_final <- (200*replicas) + (pilon*2)
    iRBC <- (PPE_obj/PPE_pre)*((hematocrito/100)*vol_final)
    nRBC <- ((hematocrito/100)*vol_final)-iRBC
    mediototal <- vol_final-iRBC-nRBC
    Suero <- mediototal*(SB/100)
    SueroC <- (mediototal*(SB/100))*(conejo/100)
    SueroB <- Suero-SueroC
    medio <- mediototal-Suero
    medioM1 <- ((vol_final/2)-iRBC)-Suero
    medioM2 <- medio-medioM1
    Protocolo <- data.frame(
      Solucion = c("Mezcla1", "Mezcla2"),
      iRBCs = c(iRBC, 0),
      nRBCs = c(0, nRBC),
      MedioCompleto = c((vol_final/2)-iRBC, 0),
      MedioBase = c(0, medioM2),
      SueroConejoParaMedioCompleto = c(SueroC, 0),
      SueroBovinoParaMedioCompleto = c(SueroB, 0),
      MedioParaMedioCompleto = c(medioM1, 0),
      VolumenFinal = c((vol_final/2),(vol_final/2))
    )
    Volumenes <- data.frame(
      MedioM199base = medio,
      SueroProblema = SueroC,
      SueroBovino = SueroB,
      iRBCs = iRBC,
      nRBCs = nRBC
    )
  }
  Protocolo <- as.data.frame(t(Protocolo))
  View(Protocolo)
  View(Volumenes)
}

EN(replicas = 3, PPE_obj = 0.2, PPE_pre = 3, hematocrito = 5, 
   SB = 20, animal = "V", pilon = 20)


EN(replicas = 5, PPE_obj = 0.2, PPE_pre = 3, hematocrito = 5, 
   SB = 20, animal = "V", pilon = 20)

EN(replicas = 3, PPE_obj = 0.2, PPE_pre = 3, hematocrito = 5, 
   SB = 20, animal = "C", pilon = 20, conejo = 50)

EN(replicas = 5, PPE_obj = 0.5, PPE_pre = 6, hematocrito = 5, 
   SB = 20, animal = "V", pilon = 20)

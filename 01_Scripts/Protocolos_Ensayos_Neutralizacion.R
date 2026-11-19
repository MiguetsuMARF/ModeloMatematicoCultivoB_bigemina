
## Funcion para establecer el protocolo de una ensayo de neutralizacion

EN <- function(replicas, PPE_obj, PPE_pre, hematocrito,SB, animal, pilon, conejo){
  if(animal == "V"){
    vol_final <- (200*replicas) + (pilon)
    iRBC <- (PPE_obj/PPE_pre)*((hematocrito/100)*vol_final)
    nRBC <- ((hematocrito/100)*vol_final)-iRBC
    mediototal <- vol_final-iRBC-nRBC
    Suero <- mediototal*(SB/100)
    medio <- mediototal-Suero
    cambios <- ((150*2)*(SB/100))*replicas+(pilon)
    mediocambios <- (150*2)*replicas+(pilon) - cambios
    Protocolo <- data.frame(
      Solucion = "Volumenes",
      iRBCs = iRBC,
      nRBCs = nRBC,
      MedioCompletoM = mediototal,
      MedioBaseM = medio,
      SueroParaMedioCompleto = Suero,
      VolumenFinal = vol_final
    )
    Volumenes <- data.frame(
      MedioCompletoTotal = mediototal + ((150*2)*replicas)+(pilon),
      MedioCompletoCambios = ((150*2)*replicas)+(pilon),
      MedioCompletoEnsayo = mediototal,
      MedioM199base = medio+mediocambios,
      SueroProblemaEnsayo = Suero,
      SueroProblemaCambios = cambios,
      SueroProblemaTotal = Suero + cambios,
      iRBCs = iRBC,
      nRBCs = nRBC
    )
  } else if(animal == "C"){
    vol_final <- (200*replicas) + (pilon)
    iRBC <- (PPE_obj/PPE_pre)*((hematocrito/100)*vol_final)
    nRBC <- ((hematocrito/100)*vol_final)-iRBC
    mediototal <- vol_final-iRBC-nRBC
    Suero <- mediototal*(SB/100)
    SueroC <- (mediototal*(SB/100))*(conejo/100)
    SueroB <- Suero-SueroC
    medio <- mediototal-Suero
    cambios <- ((150*2)*(SB/100))*replicas + pilon
    cambiosC <- cambios*(conejo/100)
    cambiosB <- cambios-cambiosC
    mediocambios <- (150*2)*replicas+(pilon) - cambios
    Protocolo <- data.frame(
      Solucion = "Volumenes",
      iRBCs = iRBC,
      nRBCs = nRBC,
      MedioCompletoM = mediototal,
      MedioBaseM = medio,
      SueroCParaMedioCompleto = SueroC,
      SueroBParaMedioCompleto = SueroB,
      VolumenFinal = vol_final
    )
    Volumenes <- data.frame(
      MedioCompletoTotal = mediototal + ((150*2)*replicas)+(pilon),
      MedioCompletoCambios = ((150*2)*replicas)+(pilon),
      MedioCompletoEnsayo = mediototal,
      MedioM199base = medio+mediocambios,
      SueroProblemaEnsayo = SueroC,
      SueroProblemaCambios = cambiosC,
      SueroProblemaTotal = SueroC + cambiosC,
      SueroBovinoEnsayo = SueroB,
      SueroBovinoCambios = cambiosB,
      SueroBovinoTotal = SueroB + cambiosB,
      iRBCs = iRBC,
      nRBCs = nRBC
    )
  }
  Protocolo <- as.data.frame(t(Protocolo))
  Volumenes <- as.data.frame(t(Volumenes))
  View(Protocolo)
  View(Volumenes)
}

EN(replicas = 5, PPE_obj = 0.2, PPE_pre = 2, hematocrito = 5, 
   SB = 20, animal = "C", pilon = 20, conejo = 50)

EN(replicas = 5, PPE_obj = 1, PPE_pre = 2, hematocrito = 5, 
   SB = 20, animal = "V", pilon = 20)

EN(replicas = 4, PPE_obj = 0.2, PPE_pre = 2.5, hematocrito = 5, 
   SB = 20, animal = "V", pilon = 20)

EN(replicas = 3, PPE_obj = 1, PPE_pre = 2.5, hematocrito = 5, 
   SB = 20, animal = "V", pilon = 20)

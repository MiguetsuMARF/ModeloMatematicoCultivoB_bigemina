function dy=S_M_model_Hill_uncoupled(~, y, rS, alpha,  Mcirc, beta, kM, nH)

S =y(1);
M =y(2);
    

Ass=-rS/8; % carrying capacity


%dy=[S*(Ass*S+rS+mS*M);
  % alpha*M*(1-M/Mcirc)-beta*M*S]; 
  %  alpha*M*(1-M/Mcirc)-beta*M*(S.^5)./(7.^5+S.^5)]; 

% partially uncoupled version
dy=[S*(Ass*S+rS);
   %alpha*(1/(1+S))*M*(1-M/Mcirc)-beta*M*(S.^nH)./(kM.^nH+S.^nH)]; 
   alpha*M*(1-M/Mcirc)-beta*M*(S.^nH)./(kM.^nH+S.^nH)]; 

end
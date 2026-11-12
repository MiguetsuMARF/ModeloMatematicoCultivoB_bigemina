function dy=S_M_model_B_bigemina(~, y,  beta, muB, muE, muI, rho)

B = y(1);
E = y(2);
I = y(3);

dy =[rho.*muI.*I - beta.*B.*E - muB.*B;
    - beta.*B.*E - muE.*E;
    beta.*B.*E - muI.*I];
end
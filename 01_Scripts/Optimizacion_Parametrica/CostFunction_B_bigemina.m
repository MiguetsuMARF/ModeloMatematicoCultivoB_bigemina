function Cost=CostFunction_B_bigemina(x, t_exp, B_exp, E_exp, I_exp)

beta = x(1);
muB  = x(2);
muE = x(3);
muI = x(4);
rho = x(5);


tiempo=[0 t_exp(end)];
Y0=[B_exp(1);E_exp(1), I_exp(1)];

[t,y] = ode45(@(t,y)S_M_model_B_bigemina(t, y, beta, muB, muE, muI, rho),tiempo,Y0);

y_E=y(:,2);
y_I=y(:,3);

parasitemia = (y_I./(y_E + y_I)).*100;

y_P_Interpol= interp1(t,parasitemia,t_exp);

Cost_P=(sum((y_P_Interpol-P_exp).^2));


Cost=(Cost_P.*8);%./(2*length(t_exp));

end
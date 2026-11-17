function Cost=CostFunction_B_bigemina(x, t_exp, P_exp)

beta = x(1);
muB  = x(2);
muE = x(3);
muI = x(4);
rho = x(5);
B_s = x(6);

P_ini = P_exp(1)/100; % Convertir parasitemia a proporcion

%% Bajo el supuesto de que en un cultivo se trabaja con una concentracion de
%  8.0.*10.^5 como base, entonces podemos trabajar con:

E_s = 8.0*10^5;
I_ini = (P_ini.*E_s)./(1-P_ini);


Y0 = [B_s;E_s; I_ini];

tiempo = [t_exp(1) t_exp(end)];

[t,y] = ode45(@(t,y)S_M_model_B_bigemina(t, y, beta, muB, muE, muI, rho),tiempo,Y0);

y_E = y(:,2);
y_I = y(:,3);

parasitemia = (y_I./(y_E + y_I)).*100;

y_P_Interpol= interp1(t,parasitemia,t_exp);

Cost=(sum((y_P_Interpol-P_exp).^2));

end


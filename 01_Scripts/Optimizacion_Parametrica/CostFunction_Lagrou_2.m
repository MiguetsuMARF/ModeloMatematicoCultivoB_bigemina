function Cost=CostFunction_Lagrou_2(x,Mcirc, t_exp, M_exp, S_exp)

rS=x(1);
alpha=x(2);
beta=x(3);
kM=x(4);

nH=10;


tiempo=[0 t_exp(end)];
Y0=[S_exp(1);M_exp(1)];

[t,y] = ode45(@(t,y)S_M_model_Hill_uncoupled(t, y, rS, alpha,  Mcirc, beta, kM, nH),tiempo,Y0);

y_S=y(:,1);
y_M=y(:,2);


y_S_Interpol= interp1(t,y_S,t_exp);
y_M_Interpol= interp1(t,y_M,t_exp);


Cost_S=(sum((y_S_Interpol-S_exp).^2));
Cost_M=(sum((y_M_Interpol-M_exp).^2));
    

Cost=(Cost_S+Cost_M.*8);%./(2*length(t_exp));

end

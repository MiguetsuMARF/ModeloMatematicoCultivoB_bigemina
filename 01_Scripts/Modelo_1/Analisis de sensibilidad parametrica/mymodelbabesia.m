function Imax = mymodelbabesia(x)

nominal_parameters = [0.25, 0.005, 1/3, 0.15, 1/25, 5, 2];
nominal_parameters(1:7)=x(1:7);

alfa = x(1);
beta  = x(2);
omega = x(3);
gamma = x(4);
rho   = x(5);
mu    = x(6);
psi   = x(7);

dBdt=@(t,B, E, I, alfa, beta, omega, rho, mu, psi)alfa - beta.*B.*E - omega.*B + mu.*(rho.*(1 + psi).*I);
dEdt=@(t,B, E, I, beta, gamma, rho)gamma - beta.*B.*E - rho.*E;
dIdt=@(t,B, E, I, beta, rho, psi)beta.*B.*E - rho.*(1 + psi).*I;

tspan = [0 100];

B0 =x(8);
E0 =x(9);
I0 =x(10);

BEI0 = [B0 E0 I0];

[t,y] = ode45(@(t,y) [dBdt(t,y(1),y(2),y(3),alfa,beta,omega,rho,mu,psi);
    dEdt(t,y(1),y(2),y(3),beta, gamma, rho);
    dIdt(t,y(1),y(2),y(3),beta, rho, psi)
    ], tspan,BEI0);

Imax = max(y(:,3));

end




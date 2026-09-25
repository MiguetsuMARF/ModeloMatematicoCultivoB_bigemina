function Imax = mymodelbabesia(x)

% nominal_parameters = [0.25, 0.005, 1/3, 0.15, 1/25, 5, 2];

% nominal_parameters(1:7)=x(1:7);

% Definir parametros 
alfa = x(1);
beta  = x(2);
omega = x(3);
gamma = x(4);
rho   = x(5);
mu    = x(6);
psi   = x(7);

% Condiciones iniciales
B0 =x(8);
E0 =x(9);
I0 =x(10);
BEI0 = [B0 E0 I0];

tspan = [0 100];

%% Corregir
%dBdt=@(t,B, E, I, alfa, beta, omega, rho, mu, psi)alfa - beta.*B.*E - omega.*B + mu.*(rho.*(1 + psi).*I);
%dEdt=@(t,B, E, I, beta, gamma, rho)gamma - beta.*B.*E - rho.*E;
%dIdt=@(t,B, E, I, beta, rho, psi)beta.*B.*E - rho.*(1 + psi).*I;

%[t,y] = ode45(@(t,y) [dydt(1)(t,y(1),y(2),y(3),alfa,beta,omega,rho,mu,psi);
%    dydt(2)(t,y(1),y(2),y(3),beta, gamma, rho);
%    dydt(3)(t,y(1),y(2),y(3),beta, rho, psi)
%    ], tspan,BEI0);

[t,y] = ode45(@(t,y)babesia(t,y,x),tspan,BEI0);

%% Variable de respuesta del analisis (variable dependiendo del analisis)
Imax = max(y(:,3));
end

%% Definir modelo como funcion completa

function dydt = babesia(~,y,x)

% Parametros:

% alfa = 0.25; beta = 0.005; omega = 1/3; gamma = 0.15; rho = 1/25; mu = 5; psi = 2;

alfa = x(1);
beta  = x(2);
omega = x(3);
gamma = x(4);
rho   = x(5);
mu    = x(6);
psi   = x(7);

dydt = zeros(3,1);

dydt(1) = alfa - beta.*y(1).*y(2) - omega.*y(1) + mu.*(rho.*(1 + psi).*y(3));
dydt(2) = gamma - beta.*y(1).*y(2) - rho.*y(2);
dydt(3) = beta.*y(1).*y(2) - rho.*(1 + psi).*y(3);

end


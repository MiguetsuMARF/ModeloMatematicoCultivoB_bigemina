%%
function Imax = mymodelbabesia2IMAX(x)

beta = x(1);
muB  = x(2);
muE = x(3);
muI = x(4);
rho   = x(5);

B0 =x(6);
E0 =x(7);
I0 =x(8);
BEI0 = [B0 E0 I0];

tspan = [0 25];

[t,y] = ode45(@(t,y)babesia2(t,y,x),tspan,BEI0);

Imax = max(y(:,3));
end

%%

function dydt = babesia2(~,y,x)

%beta = 3.3.*(10.^-8);
%rho = 2;
%muB = 20;
%muE = 0.01;
%muI = 4;

beta = x(1);
muB  = x(2);
muE = x(3);
muI = x(4);
rho   = x(5);

dydt = zeros(3,1);

dydt(1) = rho.*muI.*y(3) - beta.*y(1).*y(2) - muB.*y(1);
dydt(2) = - beta.*y(1).*y(2) - muE.*y(2);
dydt(3) = beta.*y(1).*y(2) - muI.*y(3);

end
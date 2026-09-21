%% Modelo sin tasa de introduccion de babesia infectiva y eritrocitos

clear;
clc;
close all;

syms alfa beta omega gamma rho mu psi B E I dB dE dI
assume( ...
    alfa >= 0 & ...
    beta >= 0 & ...
    omega >= 0 & ...
    gamma >= 0 & ...
    rho >= 0 & ...
    mu >= 0 & ...
    psi >= 0 & ...
    B >= 0 & ...
    E >= 0 & ...
    I >= 0 ...
    )

eq1 = alfa - beta.*B.*E - omega.*B + mu.*(rho.*(1 + psi).*I);
eq2 = gamma - beta.*B.*E - rho.*E;
eq3 = beta.*B.*E - rho.*(1 + psi).*I;

vars = [B, E, I];

nulclina_B = solve(eq1 == 0, B);
nulclina_E = solve(eq2 == 0, E);
nulclina_I = solve(eq3 == 0, I);

disp('Nulclina de B:')
disp(nulclina_B)

disp('Nulclina de E:')
disp(nulclina_E)

disp('Nulclina de I:')
disp(nulclina_I)

nulclina_B = eq1 == 0;
nulclina_E = eq2 == 0;
nulclina_I = eq3 == 0;

params = struct( ...
'alfa', 0.25, 'beta', 0.005,'omega', 1/3, 'gamma', 0.15, 'rho', 1/25, 'mu', 5, 'psi', 2);

eq1_num = subs(eq1, params);
eq2_num = subs(eq2, params);
eq3_num = subs(eq3, params);

eq1_func = matlabFunction(eq1_num, 'Vars', [B,E,I]);
eq2_func = matlabFunction(eq2_num, 'Vars', [B,E,I]);
eq3_func = matlabFunction(eq3_num, 'Vars', [B,E,I]);

range = linspace(-10,500,200);
[B,E,I] = meshgrid(range, range, range);

eq1_vals = eq1_func(B,E,I);
eq2_vals = eq2_func(B,E,I);
eq3_vals = eq3_func(B,E,I);

figure;
s1 = isosurface(B,E,I, eq1_vals, 0);
p1 = patch(s1);
set(p1, ...
    'FaceColor', [0.85 0.1 0.1], ... % Rojo
    'EdgeColor', 'none', ... 
    'FaceAlpha', 0.6); % Transparencia

xlabel('B'); ylabel('E'); zlabel('I');
title('Nulclina de B: eq1 = 0');
grid on; axis tight; view(3);
camlight headlight; lighting gouraud;
rotate3d on;

figure;
s2 = isosurface(B,E,I, eq2_vals, 0);
p2 = patch(s2);
set(p2, ...
    'FaceColor', [0.85 0.1 0.1], ... % Rojo
    'EdgeColor', 'none', ... 
    'FaceAlpha', 0.6); % Transparencia

xlabel('B'); ylabel('E'); zlabel('I');
title('Nulclina de E: eq2 = 0');
grid on; axis tight; view(3);
camlight headlight; lighting gouraud;
rotate3d on;

figure;
s3 = isosurface(B,E,I, eq3_vals, 0);
p3 = patch(s3);
set(p3, ...
    'FaceColor', [0.85 0.1 0.1], ... % Rojo
    'EdgeColor', 'none', ... 
    'FaceAlpha', 0.6); % Transparencia

xlabel('B'); ylabel('E'); zlabel('I');
title('Nulclina de I: eq3 = 0');
grid on; axis tight; view(3);
camlight headlight; lighting gouraud;
rotate3d on;

figure;
p1 = patch(isosurface(B,E,I, eq1_vals, 0));
set(p1, 'FaceColor', [0.85 0.1 0.1], 'EdgeColor', 'none', 'FaceAlpha', 0.6); hold on;

p2 = patch(isosurface(B,E,I, eq3_vals, 0));
set(p2, 'FaceColor', [0.5 0.5 1], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

p3 = patch(isosurface(B,E,I, eq2_vals, 0));
set(p3, 'FaceColor', [0 0.4 0], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

xlabel('B'); ylabel('E'); zlabel('I');
legend([p1 p2 p3], {'eq1 = 0 (B)', 'eq2 = 0 (E)', 'eq3 = 0 (I)'});
title('Nulclinas');
view(3); axis tight; grid on;
camlight headlight; lighting gouraud;
rotate3d on;

%% Generando espacio fase con trayectorias

figure;
p1 = patch(isosurface(B,E,I, eq1_vals, 0));
set(p1, 'FaceColor', [0.85 0.1 0.1], 'EdgeColor', 'none', 'FaceAlpha', 0.6); hold on;

p2 = patch(isosurface(B,E,I, eq3_vals, 0));
set(p2, 'FaceColor', [0.5 0.5 1], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

p3 = patch(isosurface(B,E,I, eq2_vals, 0));
set(p3, 'FaceColor', [0 0.4 0], 'EdgeColor', 'none', 'FaceAlpha', 0.6);

xlabel('B'); ylabel('E'); zlabel('I');
legend([p1 p2 p3], {'eq1 = 0 (B)', 'eq2 = 0 (E)', 'eq3 = 0 (I)'});
title('Nulclinas');
view(3); axis tight; grid on;
camlight headlight; lighting gouraud;
rotate3d on;

syms alfa beta omega gamma rho mu psi B E I 

eq1 = alfa - beta.*B.*E - omega.*B + mu.*(rho.*(1 + psi).*I);
eq2 = gamma - beta.*B.*E - rho.*E;
eq3 = beta.*B.*E - rho.*(1 + psi).*I;

%%

[Bsol,Esol,Isol] = solve([eq1,eq2,eq3],[B,E,I]);
Bsol
Esol
Isol

equil = [Bsol Esol Isol];

disp(equil)

alfa = 0.25;
beta  = 0.005;
omega = 1/3;
gamma = 0.15;
rho   = 1/25;
mu    = 5;
psi   = 2;

F = @(x) [
    alfa - beta.*x(1).*x(2) - omega.*x(1) + mu.*(rho.*(1 + psi).*x(3));
    gamma - beta.*x(1).*x(2) - rho.*x(2);
    beta.*x(1).*x(2) - rho.*(1 + psi).*x(3)
    ];

x0 = [2 500 0];

xeq = fsolve(F,x0);

%% Analisis de estabilidad de puntos de equilibrio

syms alfa gamma beta omega rho mu psi B E I 

eq1 = alfa - beta.*B.*E - omega.*B + mu.*(rho.*(1 + psi).*I);
eq2 = gamma - beta.*B.*E - rho.*E;
eq3 = beta.*B.*E - rho.*(1 + psi).*I;

Modelo = [eq1; eq2; eq3];
vars = [B E I];

Jacobiano = jacobian(Modelo, vars);

Jacobiano

% Primero equilibrio

Jacobiano_eq1 = subs(Jacobiano, [B E I], [Bsol(1) Esol(1) Isol(1)]);

Jacobiano_eq1

eigenvalues_eq1 = eig(Jacobiano_eq1);
eigenvalues_eq1

% Segundo equilibrio

Jacobiano_eq2 = subs(Jacobiano, [B E I], [Bsol(2) Esol(2) Isol(2)]);

Jacobiano_eq2

eigenvalues_eq2 = eig(Jacobiano_eq2);
eigenvalues_eq2

%%

alfa = 0.25;
beta  = 0.005;
omega = 1/3;
gamma = 0.15;
rho   = 1/25;
mu    = 5;
psi   = 2;

F = @(x) [
    alfa - beta.*x(1).*x(2) - omega.*x(1) + mu.*(rho.*(1 + psi).*x(3));
    gamma - beta.*x(1).*x(2) - rho.*x(2);
    beta.*x(1).*x(2) - rho.*(1 + psi).*x(3)
    ];

x0 = [2 500 0];

ode = @(t,x)[
    alfa - beta.*x(1).*x(2) - omega.*x(1) + mu.*(rho.*(1 + psi).*x(3));
    gamma - beta.*x(1).*x(2) - rho.*x(2);
    beta.*x(1).*x(2) - rho.*(1 + psi).*x(3)
    ];

[t,x] = ode45(ode,[0 500],[0 0 0]);

plot3(x(:,1),x(:,2),x(:,3),'LineWidth',2)

[t,x] = ode45(ode,[0 500],[0.1 0.1 0.12]);
plot3(x(:,1),x(:,2),x(:,3),'r')

[t,x] = ode45(ode,[0 500],[10 100 0.1]);
plot3(x(:,1),x(:,2),x(:,3),'g')

[t,x] = ode45(ode,[0 500],[0 50 10]);
plot3(x(:,1),x(:,2),x(:,3),'w')

[t,x] = ode45(ode,[0 500],[100 500 10]);
plot3(x(:,1),x(:,2),x(:,3),'y')

[t,x] = ode45(ode,[0 500],[100 10 0.1]);
plot3(x(:,1),x(:,2),x(:,3),'c')

[t,x] = ode45(ode,[0 500],[1.1 0.01 0.8]);
plot3(x(:,1),x(:,2),x(:,3),'k')

[t,x] = ode45(ode,[0 500],[500 0.01 500]);
plot3(x(:,1),x(:,2),x(:,3))

[t,x] = ode45(ode,[0 500],[500 0.01 50]);
plot3(x(:,1),x(:,2),x(:,3))
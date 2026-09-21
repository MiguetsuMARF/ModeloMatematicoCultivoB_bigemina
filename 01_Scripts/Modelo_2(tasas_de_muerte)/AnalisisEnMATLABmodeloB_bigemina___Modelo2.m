%% Modelo 2, con tasas de muerte adaptadas.

clear;
clc;
close all;

syms beta muB muE muI rho B E I dB dE dI
assume( ...
    beta >= 0 & ...
    rho >= 0 & ...
    muB >= 0 & ...
    muE >= 0 & ...
    muI >= 0 & ...
    B >= 0 & ...
    E >= 0 & ...
    I >= 0 ...
    )

eq1 = rho.*muI.*I - beta.*B.*E - muB.*B;
eq2 = - beta.*B.*E - muE.*E;
eq3 = beta.*B.*E - muI.*I;

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
'beta', 3.3.*(10.^-8),'rho', 2, 'muB', 20, 'muE', 0.01, 'muI', 4);

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

syms beta muB muE muI rho B E I dB dE dI

eq1 = rho.*muI.*I - beta.*B.*E - muB.*B;
eq2 = - beta.*B.*E - muE.*E;
eq3 = beta.*B.*E - muI.*I;

%%

[Bsol,Esol,Isol] = solve([eq1,eq2,eq3],[B,E,I]);
Bsol
Esol
Isol

equil = [Bsol Esol Isol];

disp(equil)

beta = 3.3.*(10.^-8);
rho = 2;
muB = 20;
muE = 0.01;
muI = 4;

F = @(x) [
    rho.*muI.*x(3) - beta.*x(1).*x(2) - muB.*x(1);
    - beta.*x(1).*x(2) - muE.*x(2);
    beta.*x(1).*x(2) - muI.*x(3)
    ];

x0 = [2*(10^2) 9*(10^8) 1*(10^7)];

xeq = fsolve(F,x0);

%% Analisis de estabilidad de puntos de equilibrio

syms beta muB muE muI rho B E I

eq1 = rho.*muI.*I - beta.*B.*E - muB.*B;
eq2 = - beta.*B.*E - muE.*E;
eq3 = beta.*B.*E - muI.*I;

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

beta = 3.3.*(10.^-8);
rho = 2;
muB = 20;
muE = 0.01;
muI = 4;

F = @(x) [
    rho.*muI.*x(3) - beta.*x(1).*x(2) - muB.*x(1);
    - beta.*x(1).*x(2) - muE.*x(2);
    beta.*x(1).*x(2) - muI.*x(3)
    ];

x0 = [2*(10^2) 9*(10^8) 1*(10^7)];

ode = @(t,x)[
    rho.*muI.*x(3) - beta.*x(1).*x(2) - muB.*x(1);
    - beta.*x(1).*x(2) - muE.*x(2);
    beta.*x(1).*x(2) - muI.*x(3)
    ];

[t,x] = ode45(ode,[0 30],[0 0 0]);

plot3(x(:,1),x(:,2),x(:,3),'LineWidth',2)

[t,x] = ode45(ode,[0 30],[0.1 0.1 0.12]);
plot3(x(:,1),x(:,2),x(:,3),'r')

[t,x] = ode45(ode,[0 30],[10 100 600]);
plot3(x(:,1),x(:,2),x(:,3),'g')

[t,x] = ode45(ode,[0 30],[70 500 10]);
plot3(x(:,1),x(:,2),x(:,3),'w')

[t,x] = ode45(ode,[0 30],[100 50 100]);
plot3(x(:,1),x(:,2),x(:,3),'y')

[t,x] = ode45(ode,[0 30],[100 100 240]);
plot3(x(:,1),x(:,2),x(:,3),'c')

[t,x] = ode45(ode,[0 30],[200 200 200]);
plot3(x(:,1),x(:,2),x(:,3),'k')

[t,x] = ode45(ode,[0 30],[500 100 500]);
plot3(x(:,1),x(:,2),x(:,3))

[t,x] = ode45(ode,[0 30],[5 0.01 500]);
plot3(x(:,1),x(:,2),x(:,3))
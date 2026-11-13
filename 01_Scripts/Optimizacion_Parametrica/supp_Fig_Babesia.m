clear all
close all
clc

load('Datos_Exp_MeanIni')


%% Grafico de datos experimentales
figure;

subplot(1,1,1)

plot(Datos_Exp_MeanIni(:,1), Datos_Exp_MeanIni(:,3), 'ok', 'MarkerSize', 15, 'LineWidth', 2);
hold on
ylabel('Parasitemia (%)')
xlabel('Tiempo (dias)')
plot(Datos_Exp_MeanIni(:,1), Datos_Exp_MeanIni(:,4), 'ob', 'MarkerSize', 15, 'LineWidth', 2);
axis square
set(gca, 'FontSize', 15)

legend('Parasitemia 20% de suero', 'Parasitemia 40% de suero');
sgtitle('Lagrou 2003 data: Primary human nasal cells interacting with Pneumococci')
set(gca, 'FontSize', 15)


%% Parametros constantes

E_s = 8.0*10^5;

%%
tic

titlestr={'Parasitemia 20% de suero', 'Parasitemia 40% de suero'};

uu=1;
%for jj=[2, 3]

jj=3;

    %% Datos a utilizar

    P_exp=Datos_Exp_MeanIni(:,jj);

    indexes=find(~isnan(P_exp));
    P_exp=P_exp(indexes)';
    t_exp=Datos_Exp_MeanIni(indexes,1)';

    tiempo=[t_exp(1) t_exp(end)]; % time of integration

 %% plot 

 if jj==3

     Colores='k';

 elseif jj==4

     Colores='b';
 end

    figure;

    subplot(1,1,1)
    plot(Datos_Exp_MeanIni(:,1), Datos_Exp_MeanIni(:,jj), ['o' Colores'], 'MarkerSize', 15, 'LineWidth', 2);
    hold on
    ylabel('Parasitemia (%)')
    xlabel('time (dias)')

   

    % initial guess

    beta = (3.19*(10^-8))*1100;
    muB = 19.5;
    muE = 0.01;
    muI = 2;
    rho = 2;
    B_s = 2*(10^2)/1100;

    % Condiciones iniciales
    P_ini = P_exp(1)/100;
    I_ini = (P_ini*E_s)/(1-P_ini);
    Y0 = [B_s; E_s; I_ini];

    % run the initial guess
    [t_init,y_init] = ode45(@(t,y)S_M_model_B_bigemina(t, y, beta, muB, muE, muI, rho),tiempo,Y0);

    P_init = 100*y_init(:,3)./(y_init(:,2)+y_init(:,3));

    subplot(1,1,1)
    plot(t_init, P_init, ['--' Colores'], 'LineWidth', 2);
    

    %% Check the cost before the optimization
    %% Now do the optimization
    % intital guess for the parameter

    xinit= [beta muB muE muI rho B_s];
   
    CostFunction_B_bigemina(xinit, t_exp, P_exp)

%%
   % declare the objetctive function
   Objective_Function=@(x)CostFunction_B_bigemina(x, t_exp, P_exp);

    % the lower and the upper bounds for the parameter values to be optimised
    lb = [0 0 0 0 0 0];
    ub = xinit.*100;

%% Global

        gs=GlobalSearch('StartPointsToRun','bounds-ineqs','Display','iter');
        min=@(x)CostFunction_B_bigemina(x, t_exp, P_exp);
        problem=createOptimProblem('fmincon','x0',xinit,'objective',Objective_Function,'lb',lb,'ub',ub);
        xGlobal=run(gs,problem);

        %%
        CostGlobal=CostFunction_B_bigemina(xGlobal,t_exp, P_exp)

        %%

        beta = xGlobal(1);
        muB  = xGlobal(2);
        muE  = xGlobal(3);
        muI  = xGlobal(4);
        rho  = xGlobal(5);
        B_s  = xGlobal(6);

        I_ini = (P_ini*E_s)/(1-P_ini);

        Y0 = [B_s; E_s; I_ini];

        [t_Global,y_Global] = ode45(@(t,y) S_M_model_B_bigemina(t,y,beta,muB,muE,muI,rho),tiempo,Y0);

        P_Global = 100*y_Global(:,3)./(y_Global(:,2)+y_Global(:,3));

        plot(t_Global,P_Global,Colores,'LineWidth',2.5);

    legend('Datos experimentales','Simulacion inicial','Ajuste optimizado','Location','best');


sgtitle(['beta=' num2str(beta) ' , muB=' num2str(muB) ' , muE=' num2str(muE) ' , muI=' num2str(muI) ' , rho=' num2str(rho) ' , B0=' num2str(B_s) ' , Cost Global=' num2str(CostGlobal)])


text([1,1], [7,7], titlestr(uu))
uu=uu+1;

toc

figure;

subplot(1,1,1)
plot(Datos_Exp_MeanIni(:,1), Datos_Exp_MeanIni(:,jj+1), ['o' Colores'], 'MarkerSize', 15, 'LineWidth', 2);
hold on
ylabel('Parasitemia (%)')
xlabel('time (dias)')



% initial guess

beta = (3.19*(10^-8))*1100;
muB = 19.5;
muE = 0.01;
muI = 2;
rho = 2;
B_s = 2*(10^2)/1100;

% Condiciones iniciales
P_ini = P_exp(1)/100;
I_ini = (P_ini*E_s)/(1-P_ini);
Y0 = [B_s; E_s; I_ini];

% run the initial guess
[t_init,y_init] = ode45(@(t,y)S_M_model_B_bigemina(t, y, beta, muB, muE, muI, rho),tiempo,Y0);

P_init = 100*y_init(:,3)./(y_init(:,2)+y_init(:,3));

subplot(1,1,1)
plot(t_init, P_init, ['--' Colores'], 'LineWidth', 2);


%% Check the cost before the optimization
%% Now do the optimization
% intital guess for the parameter

xinit= [beta muB muE muI rho B_s];

CostFunction_B_bigemina(xinit, t_exp, P_exp)

%%
% declare the objetctive function
Objective_Function=@(x)CostFunction_B_bigemina(x, t_exp, P_exp);

% the lower and the upper bounds for the parameter values to be optimised
lb = [0 0 0 0 0 0];
ub = xinit.*100;

%% Global

gs=GlobalSearch('StartPointsToRun','bounds-ineqs','Display','iter');
min=@(x)CostFunction_B_bigemina(x, t_exp, P_exp);
problem=createOptimProblem('fmincon','x0',xinit,'objective',Objective_Function,'lb',lb,'ub',ub);
xGlobal=run(gs,problem);

%%
CostGlobal=CostFunction_B_bigemina(xGlobal,t_exp, P_exp)

%%

beta = xGlobal(1);
muB  = xGlobal(2);
muE  = xGlobal(3);
muI  = xGlobal(4);
rho  = xGlobal(5);
B_s  = xGlobal(6);

I_ini = (P_ini*E_s)/(1-P_ini);

Y0 = [B_s; E_s; I_ini];

[t_Global,y_Global] = ode45(@(t,y) S_M_model_B_bigemina(t,y,beta,muB,muE,muI,rho),tiempo,Y0);

P_Global = 100*y_Global(:,3)./(y_Global(:,2)+y_Global(:,3));

plot(t_Global,P_Global,Colores,'LineWidth',2.5);

legend('Datos experimentales','Simulacion inicial','Ajuste optimizado','Location','best');


sgtitle(['beta=' num2str(beta) ' , muB=' num2str(muB) ' , muE='num2str(muE) ' , muI=' num2str(muI) ' , rho=' num2str(rho) ' , B0=' num2str(B_s) ' , Cost Global=' num2str(CostGlobal)])


text([1,1], [7,7], titlestr(uu))
uu=uu+1;

toc
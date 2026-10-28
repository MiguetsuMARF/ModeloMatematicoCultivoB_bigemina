clear all
close all
clc

%{
syms S(t) Ass rS alpha beta M(t) Mcirc S0 M0

ode1 = diff(S) == S*(Ass*S+rS);
ode2 = diff(M) == alpha*M*(1-M/Mcirc)-beta*M*S;

odes = [ode1; ode2]

cond1 = S(0) == S0;
cond2 = M(0) == M0;

conds = [cond1; cond2];

AA=dsolve(odes,conds)
%}
% unfortunately no analytical solution

%% Data from Lagrou.
% Nasopharyngeal epithelium: Primary human nasal cells!
 % Pneumococci
% Full reference: Lagrou, K., Peetermans, W. E., Verhaegen, J., Jorissen, M., & Van Eldere, J. (2003). Disruption of nasopharyngeal epithelium by pneumococci is density-linked. European journal of clinical investigation, 33(4), 340‚Äì5. Retrieved from http://www.ncbi.nlm.nih.gov/pubmed/12662165

load('Lagrou_Data')

%{

figure;

subplot(1,3,1)
plot(Lagrou_Data(:,1), Lagrou_Data(:,2), 'k', 'filled');
hold on
ylabel('Mucosal barrier function (ohm / cm)')
xlabel('time (h)')
plot(Lagrou_Data(:,1), Lagrou_Data(:,4), 'b', 'filled');
plot(Lagrou_Data(:,1), Lagrou_Data(:,6), 'm', 'filled');
plot(Lagrou_Data(:,1), Lagrou_Data(:,8), 'c', 'filled');


subplot(1,3,2)
plot(Lagrou_Data(:,1), Lagrou_Data(:,3), 'k', 'filled');
ylabel('Bacterial load (Log CFU/ml)')
xlabel('time (h)')
hold on
plot(Lagrou_Data(:,1), Lagrou_Data(:,5), 'b', 'filled');
plot(Lagrou_Data(:,1), Lagrou_Data(:,7), 'm', 'filled');
plot(Lagrou_Data(:,1), Lagrou_Data(:,9), 'c', 'filled');


subplot(1,3,3)
plot(Lagrou_Data(:,3), Lagrou_Data(:,2), 'k', 'filled');
xlabel('Bacterial load (Log CFU/ml)')
ylabel('Mucosal barrier function (ohm / cm)')
hold on
plot(Lagrou_Data(:,5), Lagrou_Data(:,4), 'b', 'filled');
plot(Lagrou_Data(:,7), Lagrou_Data(:,6), 'm', 'filled');
plot(Lagrou_Data(:,9), Lagrou_Data(:,8), 'c', 'filled');


%}
%% Plot the data
figure;

subplot(1,2,1)

plot(Lagrou_Data(:,1), Lagrou_Data(:,2)./max(Lagrou_Data(:,2)), 'ok', 'MarkerSize', 15, 'LineWidth', 2);
hold on
ylabel('Mucosal barrier function (normalised by max)')
xlabel('time (h)')
plot(Lagrou_Data(:,1), Lagrou_Data(:,4)./max(Lagrou_Data(:,4)), 'ob', 'MarkerSize', 15, 'LineWidth', 2);
plot(Lagrou_Data(:,1), Lagrou_Data(:,6)./max(Lagrou_Data(:,6)), 'om', 'MarkerSize', 15, 'LineWidth', 2);
plot(Lagrou_Data(:,1), Lagrou_Data(:,8)./max(Lagrou_Data(:,8)), 'oc', 'MarkerSize', 15, 'LineWidth', 2);
axis square
set(gca, 'FontSize', 15)

subplot(1,2,2)
plot(Lagrou_Data(:,1), Lagrou_Data(:,3), 'sk', 'MarkerSize', 20, 'LineWidth', 2);
ylabel('Bacterial load (Log CFU/ml)')
xlabel('time (h)')
hold on
plot(Lagrou_Data(:,1), Lagrou_Data(:,5), 'sb', 'MarkerSize', 20, 'LineWidth', 2);
plot(Lagrou_Data(:,1), Lagrou_Data(:,7), 'sm', 'MarkerSize', 20, 'LineWidth', 2);
plot(Lagrou_Data(:,1), Lagrou_Data(:,9), 'sc', 'MarkerSize', 20, 'LineWidth', 2);
axis square
set(gca, 'FontSize', 15)

legend('Fig. 2 Strain  O10724'	, 'Fig. 2 Strain O11583', 'Fig 1b high inocolum O41313	', '	Fig 1b high inocolum O41313	');
sgtitle('Lagrou 2003 data: Primary human nasal cells interacting with Pneumococci')
set(gca, 'FontSize', 15)
%{
subplot(1,3,3)
plot(Lagrou_Data(:,3), Lagrou_Data(:,2)./max(Lagrou_Data(:,2)), 'k', 'filled');
xlabel('Bacterial load (Log CFU/ml)')
ylabel('Mucosal barrier function (normalised by max)')
hold on
plot(Lagrou_Data(:,5), Lagrou_Data(:,4)./max(Lagrou_Data(:,4)), 'b', 'filled');
plot(Lagrou_Data(:,7), Lagrou_Data(:,6)./max(Lagrou_Data(:,6)), 'm', 'filled');
plot(Lagrou_Data(:,9), Lagrou_Data(:,8)./max(Lagrou_Data(:,8)), 'c', 'filled');
%}

%% two parameters that will be kept consant

Mcirc=1;
nH=10;

%%
tic

titlestr={'Fig. 2 Strain  O10724'	, 'Fig. 2 Strain O11583',  'Fig 1b high inocolum O41313	',  '	Fig 1b high inocolum O41313	'};

uu=1;
%for jj=[2, 4, 6, 8]

jj=2;


    %% select the data we are going to use.

    M_exp_NaN=Lagrou_Data(:,jj)./max(Lagrou_Data(:,jj));

    indexes=find(~isnan(M_exp_NaN));
    M_exp=M_exp_NaN(indexes)';
    t_exp=Lagrou_Data(indexes,1)';
    S_exp=Lagrou_Data(indexes,jj+1)';

    tiempo=[0 t_exp(end)+0.1]; % time of integration



 %% plot 

 if jj==2

     Colores='k';
 elseif jj==4

     Colores='b';

 elseif jj==6

     Colores='m';
 elseif jj==8

     Colores='c';
 end

    figure;

    subplot(1,2,1)
    plot(Lagrou_Data(:,1), Lagrou_Data(:,jj)./max(Lagrou_Data(:,jj)), ['o' Colores'], 'MarkerSize', 15, 'LineWidth', 2);
    hold on
    ylabel('Mucosal barrier function (normalised by max')
    xlabel('time (h)')
    scatter(t_exp, M_exp, 50, 'filled', ['p' Colores'])


    subplot(1,2,2)
    plot(Lagrou_Data(:,1), Lagrou_Data(:,jj+1), ['s' Colores'], 'MarkerSize', 20, 'LineWidth', 2);
    hold on
    scatter(t_exp, S_exp, 50, 'filled', ['p' Colores'])
    ylabel('Bacterial load (Log CFU/ml)')
    xlabel('time (h)')



    % set the initial conditions accordingly
    Y0=[S_exp(1);M_exp(1)];


    % initial guess
    rS=.1;
    alpha=.5;
    beta=.5;
    kM=7;
  
    
    % run the initial guess
    [t_init,y_init] = ode45(@(t,y)S_M_model_Hill_uncoupled(t, y, rS, alpha,  Mcirc, beta, kM, nH),tiempo,Y0);

    subplot(1,2,1)
    plot(t_init, y_init(:,2), ['--' Colores'], 'LineWidth', 2);
    
    subplot(1,2,2)
    plot(t_init, y_init(:,1), ['--' Colores'], 'LineWidth', 2);


    %% Check the cost before the optimization
    %% Now do the optimization
    % intital guess for the parameter

    xinit= [rS alpha beta kM ];
   
    CostFunction_Lagrou_2(xinit,Mcirc, t_exp, M_exp, S_exp)
%%
   % declare the objetctive function
   Objective_Function=@(x)CostFunction_Lagrou_2(x,Mcirc, t_exp, M_exp, S_exp);

    % the lower and the upper bounds for the parameter values to be optimised
    lb = 0.*xinit';
    ub = 5.*ones(1,4);
    
    ub(3)=1000; %kM can be explored in a wider range 

    ub(4)=15; %kM can be explored in a wider range 


%% Global

        gs=GlobalSearch('StartPointsToRun','bounds-ineqs','Display','iter');
        min=@(x)CostFunction_Lagrou_2(x,Mcirc, t_exp, M_exp, S_exp);
        problem=createOptimProblem('fmincon','x0',xinit,'objective',Objective_Function,'lb',lb,'ub',ub);
        xGlobal=run(gs,problem);

        %%
        CostGlobal=CostFunction_Lagrou_2(xGlobal,Mcirc, t_exp, M_exp, S_exp)

        %%

        rS=xGlobal(1);
        alpha=xGlobal(2) ;
        beta=xGlobal(3);
        kM=xGlobal(4);


        [t_Global,y_Global] = ode45(@(t,y)S_M_model_Hill_uncoupled(t, y,rS,alpha,  Mcirc, beta, kM, nH),tiempo,Y0);



        subplot(1,2,1)
        plot(t_Global, y_Global(:,2), Colores, 'LineWidth', 2);
        subplot(1,2,2)
        plot(t_Global, y_Global(:,1), Colores, 'LineWidth', 2)


sgtitle(['r_S=' num2str(rS) ' , alpha=' num2str(alpha) ' , beta=' num2str(beta) ' , kM=' num2str(kM) ' , Cost Global=' num2str(    CostGlobal)])


text([1,1], [7,7], titlestr(uu))
uu=uu+1;
%end

toc
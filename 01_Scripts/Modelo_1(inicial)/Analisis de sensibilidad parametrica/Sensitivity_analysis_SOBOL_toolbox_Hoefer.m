close all
clear all
clc

tic

Nominal_parameters=[0.25, 0.005, 1/3, 0.15, 1/25, 5, 2] 

pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(1)*0.1 Nominal_parameters(1)*10]), 'alfa');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(2)*0.1 Nominal_parameters(2)*10]), 'beta');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(3)*0.1 Nominal_parameters(3)*10]), 'omega');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(4)*0.1 Nominal_parameters(4)*10]), 'gamma');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(5)*0.1 Nominal_parameters(5)*10]), 'rho');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(6)*0.1 Nominal_parameters(6)*10]), 'mu');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(7)*0.1 Nominal_parameters(7)*10]), 'psi');

pro = pro_AddInput(pro, @()pdf_Sobol([0 50]), 'B0');
pro = pro_AddInput(pro, @()pdf_Sobol([0 50]), 'E0');
pro = pro_AddInput(pro, @()pdf_Sobol([0 50]), 'I0');

pro = pro_SetModel(pro, @(x)mymodelbabesia(x), 'model');

pro.N = 10000;

pro = GSA_Init(pro);

[S1 eS1 pro] = GSA_GetSy(pro, {1});
[S2 eS2 pro] = GSA_GetSy(pro, {2});
[S3 eS3 pro] = GSA_GetSy(pro, {3});
[S4 eS4 pro] = GSA_GetSy(pro, {4});
[S5 eS5 pro] = GSA_GetSy(pro, {5});
[S6 eS6 pro] = GSA_GetSy(pro, {6});
[S7 eS7 pro] = GSA_GetSy(pro, {7});
[S8 eS8 pro] = GSA_GetSy(pro, {8});
[S9 eS9 pro] = GSA_GetSy(pro, {9});
[S10 eS10 pro] = GSA_GetSy(pro, {10});

sensitivity_indexes_vector = [S1 S2 S3 S4 S5 S6 S7 S8 S9 S10];
parameter_names = {'alfa','beta','omega','gamma','rho','mu','psi','B0','E0','I0'};

[sorted_sotols, index_sorted_sotols]=sort(abs(sensitivity_indexes_vector),'descend');


figure;
bar(abs(sensitivity_indexes_vector(index_sorted_sotols)));
ylabel('Sobol sensitivity indices');
xlabel('Parameters');
set(gca,'XTick', [1:10],'XTickLabel',parameter_names((index_sorted_sotols)))
xlim([0,10]);

Sfast = GSA_FAST_GetSi(pro);

[sorted_eFAST, index_sorted_eFAST]=sort(abs(Sfast),'descend');

figure;
bar((Sfast(index_sorted_eFAST)));
ylabel('eFAST sensitivity indices');
xlabel('Parameters');
set(gca,'XTick', [1:10],'XTickLabel',parameter_names(index_sorted_eFAST))
xlim([0,10]);


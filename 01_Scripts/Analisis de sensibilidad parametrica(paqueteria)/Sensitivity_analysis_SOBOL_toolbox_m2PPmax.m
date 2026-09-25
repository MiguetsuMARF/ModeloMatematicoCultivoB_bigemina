close all
clear all
clc

tic

pro = pro_Create();

Nominal_parameters=[3.3.*(10.^-8), 20, 0.01, 4, 2, 2.*(10.^2), 9.*(10.^8), 1.*(10.^7)] 


pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(1)*0.05 Nominal_parameters(1)*50]), 'beta');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(2)*0.05 Nominal_parameters(2)*50]), 'muB');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(3)*0.05 Nominal_parameters(3)*50]), 'muE');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(4)*0.05 Nominal_parameters(4)*50]), 'muI');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(5)*0.05 Nominal_parameters(5)*50]), 'rho');

pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(6)*0.05 Nominal_parameters(5)*50]), 'B0');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(7)*0.05 Nominal_parameters(5)*50]), 'E0');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(8)*0.05 Nominal_parameters(5)*50]), 'I0');

pro = pro_SetModel(pro, @(x)mymodelbabesia2PPMAX(x), 'model');

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

sensitivity_indexes_vector = [S1 S2 S3 S4 S5 S6 S7 S8];
parameter_names = {'beta','muB','muE','muI','rho','B0','E0','I0'};

[sorted_sotols, index_sorted_sotols]=sort(abs(sensitivity_indexes_vector),'descend');

figure;
bar(abs(sensitivity_indexes_vector(index_sorted_sotols)));
ylabel('Sobol sensitivity indices');
xlabel('Parameters');
%set(gcf, 'Position', [100 100 300 300]); 
%axis square
set(gca,'XTick', [1:8],'XTickLabel',parameter_names((index_sorted_sotols)))
xlim([0,9]);

Sfast = GSA_FAST_GetSi(pro);

[sorted_eFAST, index_sorted_eFAST]=sort(abs(Sfast),'descend');

figure;
bar((Sfast(index_sorted_eFAST)));
ylabel('eFAST sensitivity indices');
xlabel('Parameters');
%set(gcf, 'Position', [100 100 300 300]); 
%axis square
set(gca,'XTick', [1:8],'XTickLabel',parameter_names(index_sorted_eFAST))
xlim([0, 9]);

%% Figuras condiciones iniciales

idx_IC = 6:8;

figure;
Sobol_IC = abs(sensitivity_indexes_vector(idx_IC));
b = bar(Sobol_IC);
b.FaceColor = 'flat';
b.CData(1,:) = [0.2 0.5 0.8];
b.CData(2,:) = [0.3 0.7 0.4];
b.CData(3,:) = [0.9 0.5 0.2];
set(gca,'XTick',1:3,'XTickLabel',parameter_names(idx_IC));
ylabel('Indice de sensibilidad de SOBOL');
xlabel('Parametro');
title('Sensibilidad de condiciones iniciales INDICE SOBOL');
xlim([0 4]);
for i = 1:3
    text(i,Sobol_IC(i),sprintf('%.4f',Sobol_IC(i)),'HorizontalAlignment','center','VerticalAlignment','bottom');
end

Sfast = GSA_FAST_GetSi(pro);

figure;
eFAST_IC = abs(Sfast(idx_IC));
b = bar(eFAST_IC);
b.FaceColor = 'flat';
b.CData(1,:) = [0.2 0.5 0.8];
b.CData(2,:) = [0.3 0.7 0.4];
b.CData(3,:) = [0.9 0.5 0.2];
set(gca,'XTick',1:3,'XTickLabel',parameter_names(idx_IC));
ylabel('eFAST Indice de sensibilidad');
xlabel('Parametro');
title('Sensibilidad de condiciones iniciales INDICE eFAST');
xlim([0 4]);
for i = 1:3
    text(i,eFAST_IC(i),sprintf('%.4f',eFAST_IC(i)),'HorizontalAlignment','center','VerticalAlignment','bottom');
end

%% Figuras PARAMETROS

idx_IC = 1:5;

figure;
Sobol_IC = abs(sensitivity_indexes_vector(idx_IC));
b = bar(Sobol_IC);
b.FaceColor = 'flat';
b.CData(1,:) = [0.2 0.5 0.8];
b.CData(2,:) = [0.3 0.7 0.4];
b.CData(3,:) = [0.9 0.5 0.2];
b.CData(4,:) = [0.5 0.5 0.1];
b.CData(5,:) = [0.1 0.5 0.5];
set(gca,'XTick',1:7,'XTickLabel',parameter_names(idx_IC));
ylabel('Indice de sensibilidad de SOBOL');
xlabel('Parametro');
title('Sensibilidad de parametros INDICE SOBOL');
xlim([0 6]);
for i = 1:5
    text(i,Sobol_IC(i),sprintf('%.4f',Sobol_IC(i)),'HorizontalAlignment','center','VerticalAlignment','bottom');
end

Sfast = GSA_FAST_GetSi(pro);

figure;
eFAST_IC = abs(Sfast(idx_IC));
b = bar(eFAST_IC);
b.FaceColor = 'flat';
b.CData(1,:) = [0.2 0.5 0.8];
b.CData(2,:) = [0.3 0.7 0.4];
b.CData(3,:) = [0.9 0.5 0.2];
b.CData(4,:) = [0.5 0.5 0.1];
b.CData(5,:) = [0.1 0.5 0.5];
set(gca,'XTick',1:7,'XTickLabel',parameter_names(idx_IC));
ylabel('eFAST Indice de sensibilidad');
xlabel('Parametro');
title('Sensibilidad de condiciones iniciales INDICE eFAST');
xlim([0 6]);
for i = 1:5
    text(i,eFAST_IC(i),sprintf('%.4f',eFAST_IC(i)),'HorizontalAlignment','center','VerticalAlignment','bottom');
end
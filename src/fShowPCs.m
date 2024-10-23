function pathToSaveFigure= fShowPCs(pcRef, pcNaoTransformada, pcTransformada, HabSalvarGraficos, pathToSaveFigure, RMSE_total)
clc;
close all;

if ~iscell(pcTransformada)
    numPCs= 1; 
else
    numPCs= size(pcTransformada,2);    
end

tamFonte= 18;

fig= figure;
fig.Position= [-1919 257 1536 747];
subplot(1,2,1);
plot3(pcRef(:,1), pcRef(:,2), pcRef(:,3), 'or', 'MarkerSize', 10);
hold on;
ax1= gca;
set(ax1,'FontSize', 16)
% Reposiciona a câmera para colocar o eixo Z na profundidade e o Y na vertica:
ax1.CameraPosition= [-110 -807 280];
% axis equal;
grid on;
xlabel('X (mm)', 'FontSize', tamFonte, 'FontWeight','bold');
ylabel('Y (mm)', 'FontSize', tamFonte, 'FontWeight','bold');
zlabel('Z (mm)', 'FontSize', tamFonte, 'FontWeight','bold');


subplot(1,2,2);
plot3(pcRef(:,1), pcRef(:,2), pcRef(:,3), 'or', 'MarkerSize', 10);
hold on;
ax2= gca;
set(ax2,'FontSize', 16)
% Reposiciona a câmera para colocar o eixo Z na profundidade e o Y na vertica:
ax2.CameraPosition= [-90 -1000 10];
% axis equal;
msg= sprintf('RMSE Total= %0.1f mm', RMSE_total);
subtitle(msg, 'FontSize', tamFonte, 'FontWeight','bold');
grid on;
xlabel('X (mm)', 'FontSize', tamFonte, 'FontWeight','bold');
ylabel('Y (mm)', 'FontSize', tamFonte, 'FontWeight','bold');
zlabel('Z (mm)', 'FontSize', tamFonte, 'FontWeight','bold');

for ctPC=1:numPCs
    if numPCs==1
        subplot(1,2,1);
        plot3(pcNaoTransformada{ctPC}(:,1), pcNaoTransformada{ctPC}(:,2), pcNaoTransformada{ctPC}(:,3), '.b', 'MarkerSize', 8);
        subplot(1,2,2);
        plot3(pcTransformada{ctPC}(:,1), pcTransformada{ctPC}(:,2), pcTransformada{ctPC}(:,3), '.b');
    else
        subplot(1,2,1);
        plot3(pcNaoTransformada{ctPC}(:,1), pcNaoTransformada{ctPC}(:,2), pcNaoTransformada{ctPC}(:,3), '.b');
        subplot(1,2,2);
        plot3(pcTransformada{ctPC}(:,1), pcTransformada{ctPC}(:,2), pcTransformada{ctPC}(:,3), '.b', 'MarkerSize', 8);
    end
end

if HabSalvarGraficos
    % Escolha a pasta onde serão salvas as PCs:
    pathToSave= uigetdir(pathToSaveFigure, 'Escolha a pasta onde serão salvas as figuras no formato .png e .svg.');

    if ~pathToSave
        msg= sprintf('Salvamento das imagens cancelado!');
        msgbox(msg, '', 'warn');
        return;
    end
    
    % Salva a figura .png:
    nameFile= sprintf('grafico_PC_Tabuleiro_Xadrez_Registrada.png'); 
    fullFile= fullfile(pathToSave, nameFile);
    saveas(gcf, fullFile);

    % Salva a figura .svg:
    nameFile= sprintf('grafico_PC_Tabuleiro_Xadrez_Registrada.svg'); 
    fullFile= fullfile(pathToSave, nameFile);
    saveas(gcf, fullFile); 
    
    pathToSaveFigure= pathToSave; 
end
end
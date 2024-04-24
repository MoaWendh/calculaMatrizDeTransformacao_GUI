function fShowPCs(pcRef, pcNaoTransformada, pcTransformada)
clc;
close all;

if ~iscell(pcTransformada)
    numPCs= 1; 
else
    numPCs= size(pcTransformada,2);    
end

fig= figure;
subplot(1,2,1);
plot3(pcRef(:,1), pcRef(:,2), pcRef(:,3), 'or');
hold on;

subplot(1,2,2);
plot3(pcRef(:,1), pcRef(:,2), pcRef(:,3), 'or');
hold on;


for ctPC=1:numPCs
    if numPCs==1
        subplot(1,2,1);
        plot3(pcNaoTransformada{ctPC}(:,1), pcNaoTransformada{ctPC}(:,2), pcNaoTransformada{ctPC}(:,3), '.b');
        subplot(1,2,2);
        plot3(pcTransformada{ctPC}(:,1), pcTransformada{ctPC}(:,2), pcTransformada{ctPC}(:,3), '.b');
    else
        subplot(1,2,1);
        plot3(pcNaoTransformada{ctPC}(:,1), pcNaoTransformada{ctPC}(:,2), pcNaoTransformada{ctPC}(:,3), '.b');
        subplot(1,2,2);
        plot3(pcTransformada{ctPC}(:,1), pcTransformada{ctPC}(:,2), pcTransformada{ctPC}(:,3), '.b');
    end
    axis equal;
    grid on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');  
end
end
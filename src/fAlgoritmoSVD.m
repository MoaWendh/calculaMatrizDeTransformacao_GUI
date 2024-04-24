function [R, t, pcTransformada] = fAlgoritmoSVD(points_ref, points_toAligne)
   
    % Executa o SVD sem o RANSAC.
    centroidA= mean(points_ref, 1);
    centroidB= mean(points_toAligne, 1);

    % Centralizar os pontos
    XX= (points_ref - centroidA)';
    YY= (points_toAligne - centroidB)';

    XY= XX*YY';
    numPontos= size(YY,2); 

    % Matriz de covariância
    H= XY/numPontos;

    % Algoritmo SVD:
    [U, ~, V]= svd(H);

    % Calcular rotação
    R= U*V';
    %R= V*U';

    % Garantir uma transformação de rotação correta
    if det(R) < 0
        V(:,end) = -V(:,end);
        R= U*V';
    end

    % Calcular translação
    t= centroidA' - R*centroidB'; 

    % Transforma a PC e disponibiliza na saída para análise:
    pcTransformada= (R*points_toAligne' + t)';       
end
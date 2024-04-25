function [M, pcTransformada, SSE]= fAplicaTransformacaoDeCorpoRigido(pcX, pcY, ... 
                                                               pathToSave, ...
                                                               HabRANSAC, ...
                                                               DistanciaMaxima, ...
                                                               NumMaxIteracoes)                                                                                                           
if ~iscell(pcY)
    numPCsParaReferenciar= 1;
else
    numPCsParaReferenciar= size(pcY, 2);
end

format long;

for ctPC=1:numPCsParaReferenciar
    if HabRANSAC
        % Chama o algoritmo RANSAC com SVD:
        [R, t, pcX_aux, pcTransformada_aux] = fAlgoritmoRansacSVD(pcX, pcY{ctPC}, DistanciaMaxima, NumMaxIteracoes);
    else
        % Chama o algoritmo SVD:
        [R, t, pcTransformada_aux]= fAlgoritmoSVD(pcX, pcY{ctPC});
        pcX_aux= pcX;
    end
    % Monta Matriz de transformação homogênea:
    M_aux=[R t; [0 0 0 1]];
    
    % Calcular as distâncias quadráticas entre os pontos correspondentes
    squared_errors= sum((pcX_aux - pcTransformada_aux).^2, 2);
    
    numPontos= size(squared_errors,1);
    
    % Calcula o erro quadrático:
    SSE(ctPC)= sum(squared_errors)/numPontos;
    
    M{ctPC}= M_aux;
    pcTransformada{ctPC}= pcTransformada_aux;
end

end
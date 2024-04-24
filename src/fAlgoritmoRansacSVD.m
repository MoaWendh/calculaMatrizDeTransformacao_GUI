function [R, t, pcTransformada] = fAlgoritmoRansacSVD(points_toAligne, points_ref, maxDistance, numIterations)
    
    numPointsToAligne= size(points_toAligne, 1);
    numPointsRef= size(points_ref, 1);
    bestNumInliers= 0;
    bestInliers= false(numPointsToAligne, 1); % Inicializar com todos os pontos sendo outliers

    bestR= [];
    bestT= [];

    for i=1:numIterations
        
        numPointsToAligne= size(points_toAligne, 1);
        numPointsRef= size(points_ref, 1);
        
        % Escolha aleatoriamente 3 pontos da nuvem de pontos de dados
        indices= randperm(numPointsToAligne, 3);
        points_toAligneSample= points_toAligne(indices, :);

        % Encontre 3 pontos correspondentes no modelo (também escolhidos aleatoriamente)
        points_refIndices= randperm(numPointsRef, 3);
        points_refSample= points_ref(points_refIndices, :);

        % Calcule a transformação de corpo rígido entre as amostras
        [R_candidate, t_candidate, pcTransformada]= fAlgoritmoSVD(points_ref, points_toAligne);

        % Aplicar transformação a todos os pontos de dados
        points_toAligneTransformed= (R_candidate * points_toAligne' + t_candidate)';

        % Calcule a distância entre os pontos transformados e todos os pontos do modelo
        distances= pdist2(points_toAligneTransformed, points_ref);

        % Determine os inliers
        inliers= any(distances < maxDistance, 2);

        % Atualize o melhor modelo se o número de inliers for maior
        numInliers = sum(inliers);
        if numInliers > bestNumInliers
            bestNumInliers = numInliers;
            bestR = R_candidate;
            bestT = t_candidate;
            bestInliers = inliers;
        end
    end

    % Use apenas os inliers para estimar a transformação final usando SVD
    points_toAligneInliers= points_toAligne(bestInliers, :);
    points_refInliers= points_ref(bestInliers, :);
    [R, t, pcTransformada]= fAlgoritmoSVD(points_toAligneInliers, points_refInliers);
    inliers= bestInliers;    
end

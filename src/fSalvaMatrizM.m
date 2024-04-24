function fSalvaMatrizM(M, path)

numMatrizes= size(M, 2);

for ctMatriz=1:numMatrizes
    
    nameFile= sprintf('M_%0.2d.txt', ctMatriz);
    fullNameFile= fullfile(path, nameFile);
    
    fid= fopen(fullNameFile, 'wt');
    
    fprintf(fid,'%.4f\t%.4f\t%.4f\t%.4f\n', M{ctMatriz}');
    
    fclose(fid);
end
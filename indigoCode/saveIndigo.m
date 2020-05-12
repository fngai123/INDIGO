function resultsFile = saveIndigo(indigoSummary)
%save results
dataName = erase(indigoSummary.testFile,'.xlsx');

if indigoSummary.standardized == 1
    resultsFile = strcat('indigoResults/',dataName,sprintf('_%s_%s_z.mat', ...
    indigoSummary.trainingData, indigoSummary.valMethod));
else
    resultsFile = strcat('indigoResults/',dataName,sprintf('_%s_%s.mat', ...
    indigoSummary.trainingData, indigoSummary.valMethod));
end

end
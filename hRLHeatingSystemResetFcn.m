function in = hRLHeatingSystemResetFcn(in)
    % temperature at every 60 seconds
    data = evalin("base","temperatureData"); 
    
    % Randomly determine the initial time from the logged data for training
    numDataPoints = size(data,1);
    MaxStepsPerEpisode = evalin("base","maxStepsPerEpisode");
    SampleTime = evalin("base","sampleTime");
    dataStepSize = ceil(SampleTime/60);
    totalDataSteps = dataStepSize * MaxStepsPerEpisode;
    lastPossibleDataInitialIndex = numDataPoints - totalDataSteps + 1;
    initialIndex = randi(lastPossibleDataInitialIndex);

    inputData = data(initialIndex:end, :);
    inputData(:,1) = 60:60:60*size(inputData,1);
    assignin("base","outsideTemperature", inputData)
end
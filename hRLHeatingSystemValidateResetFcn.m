function in = hRLHeatingSystemValidateResetFcn(in)
    % temperature at every 60 seconds   
    data = evalin('base','validationTemperature');     
    inputData = data;
    inputData(:,1) = 60:60:60*size(inputData,1);
    assignin('base','outsideTemperature', inputData)
end
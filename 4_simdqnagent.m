% Local Plot Results
function localPlotResults(experience, maxSteps, comfortMax, comfortMin, sampleTime, figNum)
    % localPlotResults plots results of validation

    % Compute comfort temperature violation
    minutesViolateComfort = ...
    sum(experience.Observation.obs1.Data(1,:,1:maxSteps) < comfortMin) ...
    + sum(experience.Observation.obs1.Data(1,:,1:maxSteps) > comfortMax);
    
    % Cost of energy
    totalCosts = experience.SimulationInfo(1).househeat_output{1}.Values;
    totalCosts.Time = totalCosts.Time/60;
    totalCosts.TimeInfo.Units="minutes";
    totalCosts.Name = "Total Energy Cost";
    finalCost = experience.SimulationInfo(1).househeat_output{1}.Values.Data(end);

    % Cost of energy per step
    costPerStep = experience.SimulationInfo(1).househeat_output{2}.Values;
    costPerStep.Time = costPerStep.Time/60;
    costPerStep.TimeInfo.Units="minutes";    
    costPerStep.Name = "Energy Cost per Step";
    minutes = (0:maxSteps)*sampleTime/60;

    % Plot results   

    fig = figure(figNum);
    % Change the size of the figure
    fig.Position = fig.Position + [0, 0, 0, 200];

    % Temperatures
    layoutResult = tiledlayout(3,1);
    nexttile
    plot(minutes, ...
        reshape(experience.Observation.obs1.Data(1,:,:), ...
        [1,length(experience.Observation.obs1.Data)]),"k")
    hold on
    plot(minutes, ...
        reshape(experience.Observation.obs1.Data(2,:,:), ...
        [1,length(experience.Observation.obs1.Data)]),"g")
    yline(comfortMin,'b')
    yline(comfortMax,'r')
    lgd = legend("T_{room}", "T_{outside}","T_{comfortMin}", ...
        "T_{comfortMax}","location","northoutside");
    lgd.NumColumns = 4;
    title("Temperatures")
    ylabel("Temperature")
    xlabel("Time (minutes)")
    hold off

    % Total cost
    nexttile
    plot(totalCosts)    
    title("Total Cost")
    ylabel("Energy cost")

    % Cost per step
    nexttile
    plot(costPerStep)  
    title("Cost per step")
    ylabel("Energy cost")    
    fprintf("Comfort Temperature violation:" + ...
        " %d/1440 minutes, cost: %f dollars\n", ...
        minutesViolateComfort, finalCost);
end
%{
% Evaluate agent performance on March 21st temp data
maxSteps= 720;
validationTemperature = temperatureMarch21;
env.ResetFcn = @(in) hRLHeatingSystemValidateResetFcn(in);
simOptions = rlSimulationOptions(MaxSteps = maxSteps);
experience1 = sim(env);

localPlotResults(experience1, maxSteps, comfortMax, comfortMin, sampleTime,1)

% Evaluate on April 15th 2022
validationTemperature = temperatureApril15;
%experience2 = sim(env,agent,simOptions);
%localPlotResults(experience2, maxSteps, comfortMax, comfortMin, sampleTime,2)
%}
%Evaluate on April 15th 2022, with 8 degree increase (more mild)
validationTemperature = temperatureApril15;
validationTemperature(:,2) = validationTemperature(:,2) + 8;
%experience3 = sim(env,agent,simOptions);
%localPlotResults(experience3, maxSteps, comfortMax, comfortMin, sampleTime, 3)

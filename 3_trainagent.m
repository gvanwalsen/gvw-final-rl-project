% Specify training options
trainOpts = rlTrainingOptions(MaxEpisodes = 150, MaxStepsPerEpisode = maxStepsPerEpisode, ScoreAveragingWindowLength = 5, Verbose = false, Plots = "training-progress", StopTrainingCriteria = "AverageReward", StopTrainingValue = 85);

% Train the agent using the train function. 
% Training this agent is a computationally-intensive process that takes several hours to complete. 
% To save time while running this example, load a pretrained agent by setting doTraining to false. 
% To train the agent yourself, set doTraining to true.

doTraining = true;
if doTraining
    % Train the agent.
    trainingStats = train(agent,env,trainOpts);
else
    % Load the pretrained agent for the example.
    load("HeatControlDQNAgent.mat","agent")
end



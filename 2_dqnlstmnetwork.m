% Specify actor and critic training options
criticOpts = rlOptimizerOptions(LearnRate=0.001, GradientThreshold=1);

% Specify DQN agent options
agentOpts = rlDQNAgentOptions(UseDoubleDQN = false, TargetSmoothFactor = 1, TargetUpdateFrequency = 4, ExperienceBufferLength = 1e6, CriticOptimizerOptions = criticOpts, MiniBatchSize = 64);
agentOpts.EpsilonGreedyExploration.EpsilonDecay = 0.0001;

useRNN = true;
initOpts = rlAgentInitializationOptions(UseRNN=useRNN, NumHiddenUnit=64);
agentOpts.SequenceLength = 20;

agent = rlDQNAgent(obsInfo, actInfo, initOpts, agentOpts);
agent.SampleTime = sampleTime;

% Define simulink environment
env = rlSimulinkEnv(mdl,agentBlk,obsInfo,actInfo);
env.ResetFcn = @(in) hRLHeatingSystemResetFcn(in);
validateEnvironment(env)

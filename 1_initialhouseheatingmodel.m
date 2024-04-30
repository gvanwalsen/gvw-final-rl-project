% Open model
mdl = "rlHouseHeatingSystem";
open_system(mdl)

% Sample time and steps per episode
sampleTime = 120; % seconds
maxStepsPerEpisode = 1000;

% Agent block path
agentBlk = mdl + "/Smart Thermostat/RL Agent";

% Load outside temp, will be used to simulate the environment
data = load('temperatureMar21toApr15_2022.mat');
temperatureData = data.temperatureData;

% Extract validation data
temperatureMarch21 = temperatureData(1:60*24,:);
temperatureApril15 = temperatureData(end-60*24+1:end,:);

% Extract training data
temperatureData = temperatureData(60*24+1:end-60*24,:);

% Initialize Simulink variables
outsideTemperature = temperatureData;
comfortMax = 23;
comfortMin = 18;

% Define observation and action specs
obsInfo = rlNumericSpec([6,1]);
actInfo = rlFiniteSetSpec([0,1]); % (0=off,1=on)

% Ensure reproducability by fixing the seed of the random generator
rng(0)
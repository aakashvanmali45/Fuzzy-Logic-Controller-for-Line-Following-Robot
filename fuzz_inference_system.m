fis = mamfis('Name','LineFollower');

% Inputs: Left, Center, and Right sensors (range [0 1])
fis = addInput(fis, [0 1], 'Name', 'Left');
fis = addInput(fis, [0 1], 'Name', 'Center');
fis = addInput(fis, [0 1], 'Name', 'Right');

% Membership Functions for Inputs (0 = No line, 1 = Line detected)
% Left Sensor
fis = addMF(fis, 'Left', 'trapmf', [-0.1 0 0.5 1], 'Name', 'Off');
fis = addMF(fis, 'Left', 'trapmf', [0 0.5 1 1.1], 'Name', 'On');

% Center Sensor
fis = addMF(fis, 'Center', 'trapmf', [-0.1 0 0.5 1], 'Name', 'Off');
fis = addMF(fis, 'Center', 'trapmf', [0 0.5 1 1.1], 'Name', 'On');

% Right Sensor
fis = addMF(fis, 'Right', 'trapmf', [-0.1 0 0.5 1], 'Name', 'Off');
fis = addMF(fis, 'Right', 'trapmf', [0 0.5 1 1.1], 'Name', 'On');

% Outputs: wL and wR ∈ [0, 1] (left and right wheel speeds)
fis = addOutput(fis, [0 1], 'Name', 'wL');
fis = addOutput(fis, [0 1], 'Name', 'wR');

% Membership Functions for Output (Slow, Medium, Fast wheel speeds)
fis = addMF(fis, 'wL', 'trimf', [0 0 0.5], 'Name', 'Slow');   % Slow (Left wheel)
fis = addMF(fis, 'wL', 'trimf', [0.25 0.5 0.75], 'Name', 'Medium'); % Medium (Left wheel)
fis = addMF(fis, 'wL', 'trimf', [0.5 1 1], 'Name', 'Fast');   % Fast (Left wheel)

fis = addMF(fis, 'wR', 'trimf', [0 0 0.5], 'Name', 'Slow');   % Slow (Right wheel)
fis = addMF(fis, 'wR', 'trimf', [0.25 0.5 0.75], 'Name', 'Medium'); % Medium (Right wheel)
fis = addMF(fis, 'wR', 'trimf', [0.5 1 1], 'Name', 'Fast');   % Fast (Right wheel)

% Define the rule base for the fuzzy inference system

  % L  C  R => wL  wR  weight op
ruleList = [
    2 1 2 3 3 1 1;  % [0 1 0] → Fast, Fast
    1 2 2 1 3 1 1;  % [1 0 0] → Slow, Fast
    2 2 1 3 1 1 1;  % [0 0 1] → Fast, Slow
    1 1 2 1 2 1 1;  % [1 1 0] → Slow, Medium
    2 1 1 2 1 1 1;  % [0 1 1] → Medium, Slow
    2 2 2 3 3 1 1;  % [0 0 0] → Fast, Fast (assume continue forward)
    1 1 1 1 1 1 1;  % [1 1 1] → Slow, Slow (all sensors see line)
    2 1 1 2 2 1 1;  % [0 1 1] → Medium, Medium
];

% Add the rules to the fuzzy system
fis = addRule(fis, ruleList);

% Write the FIS to a file
writeFIS(fis, 'line_follower_fuzzy.fis');

% Simulate Fuzzy Logi

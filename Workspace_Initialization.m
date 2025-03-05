% Evaluate the RRT Algorithm using HW6 Dataset
clear;
clc;

% Specify circular obstacles as [x_center, y_center, radius]
obstacles = [
    0, 700, 39;       % Obstacle #1: Center = (0, 700), Radius = 39
    575, 575, 32;     % Obstacle #2: Center = (575, 575), Radius = 32
    -600, 600, 52;    % Obstacle #3: Center = (-600, 600), Radius = 52
    800, 350, 7       % Obstacle #4: Center = (800, 350), Radius = 7
];

% Define initial and goal configurations
Qi = [22, 5, 5];      % Initial configurations [Theta1 = 22; Theta2 = 5; Theta3 = 5]
Qg = [158, 5, 5];     % Goal configurations [Theta1 = 158; Theta2 = 5; Theta3 = 5]

% Call RRT algorithm to explore the workspace and find a path without
Main_RRT_Algorithm(obstacles, Qi, Qg);

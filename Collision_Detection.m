% Collision Detection
function col = Collision_Detection(Q, obstacles)
    % Inputs:
    % Q: The robot's configuration is represented as a line segment [x1, y1, x2, y2]
    % Obstacles: Array of circular obstacles = [x_center, y_center, radius]
    
    col = 0;  % Initialize collision flag to 0 (no collision)

    % Extract robot's line segment coordinates
    A = [Q(1), Q(2)];  % Start of the robot's line
    B = [Q(3), Q(4)];  % End of the robot's line

    %% Iterate through each obstacle
    for i = 1:size(obstacles, 1)
        % Extract obstacle data
        C = [obstacles(i, 1), obstacles(i, 2)];  % Center of the obstacle
        R = obstacles(i, 3);  % Radius of the obstacle
        
        % Check for intersection using Utility_for_Intersection_Checking
        delta = Utility_for_Intersection_Checking(A, B, C, R);
        if delta < 0
            col = 1;  % Collision detected
            return;
        end
    end
end

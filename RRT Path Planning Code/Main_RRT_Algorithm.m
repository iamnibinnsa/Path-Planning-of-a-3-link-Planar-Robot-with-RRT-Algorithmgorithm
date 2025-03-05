% Primary RRT loop for collision path planning

function Main_RRT_Algorithm(obstacles, Qi, Qg)
    % Inputs:
    % Obstacles: Array of circular obstacles = [x_center, y_center, radius]
    % Qi: Initial configuration = [x, y, theta]
    % Qg: Goal configuration = [x, y, theta]

    %% Initialization
    G = Qi;             % Initialize the tree with the initial node
    wxy = 2;            % Weight for linear distance
    wth = 1;            % Weight for angular distance
    step_size = 10;     % Step size for each RRT extension
    N = 1e5;          % Number of samples to generate for RRT
    found = 0;          % Flag to indicate if the goal has been reached
    parent = 1;         % Array to store parent-child node relationships in the tree
    
    %% Initiate RRT Loop
    for i = 1:N
        % Select a random point within the workspace
        if rand(1) < 0.99
            Qrand = [rand(1) * 1000, rand(1) * 1000, rand(1) * 180];  % Random point
        else
            Qrand = Qg;  % Add a bias towards the goal with 1% probability
        end
        
        % Find the nearest node in the tree
        [Qnear, near_idx] = find_nearest_node(G, Qrand, wxy, wth);

        % Extend from Qnear towards the direction of Qrand
        Qnew = extend(Qnear, Qrand, step_size);
        
        % Detect collisions with circular obstacles
        if Collision_Detection([Qnear(1), Qnear(2), Qnew(1), Qnew(2)], obstacles) == 0
            G = [G; Qnew];
            parent = [parent; near_idx];
            
            % Determine if the goal has been reached
            if norm(Qnew(1:2) - Qg(1:2)) < 10 && abs(Qnew(3) - Qg(3)) < 10
                found = 1;
                break;
            end
        end
    end
    
    %% Plot the final path
    if found
        disp('Goal has been reached!');
        plot_tree(G, parent, obstacles);
    else
        disp('Goal has not been reached.');
    end
    
    toc;  % Print the total runtime
end

%% Function to Extend the RRT Tree
function Qnew = extend(Qnear, Qrand, step_size)
    direction = (Qrand - Qnear) / norm(Qrand - Qnear);  % Unit direction vector
    Qnew = Qnear + step_size * direction;  % New configuration
end

%% Helper Function to Find the Nearest Node in the Tree
function [Qnear, near_idx] = find_nearest_node(G, Qrand, wxy, wth)
    % Find the nearest node in the tree G to the random configuration Qrand
    distances = arrayfun(@(i) metric(G(i, :), Qrand, wxy, wth), 1:size(G, 1));
    [min_dist, near_idx] = min(distances);  % Find index of minimum distance
    Qnear = G(near_idx, :);  % Return nearest node
end

%% Distance Metric Calculation for RRT
function d = metric(Q1, Q2, wxy, wth)
    % Calculate the weighted distance between configurations Q1 and Q2
    d = wxy * norm(Q1(1:2) - Q2(1:2)) + wth * abs(Q1(3) - Q2(3));
end


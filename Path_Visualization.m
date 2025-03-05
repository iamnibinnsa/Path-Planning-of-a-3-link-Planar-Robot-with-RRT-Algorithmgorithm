% Visualization of the path
function Path_Visualization(G, parent, obstacles)
    % Inputs:
    % G: Collection of nodes in the tree (each node is a function of x, y, theta)
    % Parent: Array of parent nodes
    % Obstacles: Array of circular obstacles = [x_center, y_center, radius]
    
    figure;
    hold on;
    axis([0 1000 0 1000]);  % Set axis limits based on the workspace size
    axis equal;

    % Plot circular obstacles
    for i = 1:size(obstacles, 1)
        % Draw each obstacle using the filledCircle function
        filledCircle(obstacles(i, 1:2), obstacles(i, 3), 100, 'k');
    end
    
    % Plot the tree by drawing lines between parent and child nodes
    for i = 2:size(G, 1)
        plot([G(i, 1), G(parent(i), 1)], [G(i, 2), G(parent(i), 2)], 'b', 'LineWidth', 1);
    end

    % Mark initial and goal nodes
    plot(G(1, 1), G(1, 2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');  % Initial node in green
    plot(G(end, 1), G(end, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'y');  % Goal node in red

    title('RRT Path Planning');
    xlabel('X-axis');
    ylabel('Y-axis');
    hold off;
end

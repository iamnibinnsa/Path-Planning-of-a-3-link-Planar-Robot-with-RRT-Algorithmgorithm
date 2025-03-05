% Drawing Obstacles
function h = Obstacle_Drawing(center, r, N, color)
    % Inputs:
    % center: [x, y] coordinates of the circle's center
    % r: Radius of the circle
    % N: Number of points to approximate the circle
    % color: Color of the circle
    
    % Create angle values from 0 to 2*pi to represent the full circle
    theta = linspace(0, 2*pi, N);
    
    % Convert polar coordinates (theta, r) into Cartesian coordinates (x, y)
    X = r * cos(theta) + center(1);
    Y = r * sin(theta) + center(2);
    
    % Plot the filled circle
    h = fill(X, Y, color);
    axis square;
end

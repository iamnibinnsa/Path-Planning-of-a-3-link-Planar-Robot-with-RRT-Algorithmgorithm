% Utility for Intersection Checking
function delta = Utility_for_Intersection_Checking(A, B, C, R)
    % Inputs:
    % A: [x, y] coordinates of the start of the line segment
    % B: [x, y] coordinates of the end of the line segment
    % C: [x, y] coordinates of the center of the circle
    % R: Radius of the circle
    
    % Vector from A to B
    BA = B - A;
    
    % Vector from A to C
    CA = C - A;
    
    % Project CA onto BA to find the closest point on the line to the circle center
    proj = dot(CA, BA / norm(BA));  % Normalize BA to obtain the unit vector along the line
    
    %% Determine the closest point on the line segment to the circle
    if proj <= 0
        closest_point = A;  % Closest point is A
    elseif proj >= norm(BA)
        closest_point = B;  % Closest point is B
    else
        closest_point = A + proj * BA / norm(BA);  % Closest point lies between A and B
    end
    
    % Vector from the closest point on the line to the center of the circle
    D = C - closest_point;
    
    % Distance between the closest point and the center of the circle minus the radius
    delta = norm(D) - R;
end

function [abc] = iclarket(alpha_beta_zero)
    % Transformation matrix
    iM_clarke =    [1,    0,      1;...
                    -1/2,   sqrt(3)/2, 1;...
                    -1/2, -sqrt(3)/2 ,       1];
    
    % Apply to all inputs
    abc = iM_clarke*alpha_beta_zero;
end
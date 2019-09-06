function [alpha_beta_zero] = clarket(abc)
    % Transformation matrix
    M_clarke = 2/3*[1,   -1/2,      -1/2;...
                    0,   sqrt(3)/2, -sqrt(3)/2;...
                    1/2, 1/2,       1/2];
    
    % Apply to all inputs
    alpha_beta_zero = M_clarke*abc;
end
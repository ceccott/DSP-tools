function [dqo] = parkt(abc,theta)
   KP = sqrt(2/3).*[cos(theta) cos(theta - (2*pi/3)) cos(theta + (2*pi/3)); ...
                    -sin(theta) -sin(theta - (2*pi/3)) -sin(theta + (2*pi/3)); ...
                    sqrt(2)/2 sqrt(2)/2 sqrt(2)/2];
     
    dqo = KP*abc;
end

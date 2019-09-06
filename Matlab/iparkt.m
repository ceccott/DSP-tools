function [abc] = iparkt(dqo,theta)
   KP = sqrt(2/3)*[cos(theta) -sin(theta) sqrt(2)/2; ...
                   cos(theta-(2*pi/3)) -sin(theta - (2*pi/3)) sqrt(2)/2; ...
                   cos(theta+(2*pi/3)) -sin(theta + (2*pi/3)) sqrt(2)/2];
     
    abc = KP*dqo;
end


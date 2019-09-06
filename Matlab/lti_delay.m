function [d,e] = lti_delay(filter,en_ths,plt)
% principal system components delay
%   inputs: H(z)=num/den and energy interval in sigmas (1,2,3)
%   outputs: d, principal system components delay
%   outputs: energy fraction 

n_ring = 100;                          % number of samples for evaluation
[h,t] = impz(filter,n_ring);          % computes impulse response

total_energy = sqrt(sum(h.^2));        % computes total energy 

acc_energy = cumsum(abs(h));           % computes accumulated output energy over time

   
d = find(acc_energy >= total_energy*en_ths,1);  % find energy threshold
e = cumsum(d);                                  % throughput energy up to d

if(plt)
    figure;
    hold on;
    stem(t,(h.^2)./total_energy);
    line([d d], [0 max(h.^2)*1.3/total_energy],'Color','red','LineStyle','--');
    hold off;
    xlabel('time [samples]');
    ylabel('normalized energy');
end

end


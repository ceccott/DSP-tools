function [out1,out2] = lti_dist(filter,att_db,plt,out)
% Magnitude and phase distortion for an LTI system
%   inputs: H(z)=num/den and attenuation in dB 
%   outputs: md,pd 

[H,~]=freqz(filter);
mag = abs(H).^2; 
phase = phasez(filter);
passb_idx = find(mag > 1./10.^(att_db./10));
freqs_pi = linspace(0,1,length(mag));

freqs = freqs_pi(passb_idx);                        % pass band normalized frequencies

md = sqrt(sum((1-mag(passb_idx)).^2));              % magnitude distortion

ofs=10;
c_lin = polyfit(freqs(ofs:end),phase(passb_idx(ofs:end))',1);         % best linear phase fit
pd = sqrt(sum((c_lin(2)+c_lin(1).*freqs)-phase(passb_idx)').^2); % phase distortion

if(plt)
    figure;
    hold on; 
    plot(freqs_pi,mag);
    plot(freqs_pi(passb_idx(end)),mag(passb_idx(end)),'o'); 
    yyaxis right;
    plot(freqs_pi,phase);
    yyaxis left;
    plot(freqs,(1-mag(passb_idx)).^2,'--');
    yyaxis right;
    plot(freqs,((c_lin(2)+c_lin(1).*freqs)-phase(passb_idx)').^2);
    legend('|H|','cutoff','(|H| dist)^2','arg(H)','(arg(H) dist)^2');
    xlabel('normalized frequency [x\pi]');
    hold off;
    %set(gca,'YScale','log')
end

if out=='md'
    out1=md;
    out2=pd;
elseif out=='pd'
    out1=pd;
    out2=md;
end

end

  
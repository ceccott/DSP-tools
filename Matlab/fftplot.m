function [Y,f] = fftplot(x,Fs,Fstop,xaxis)
    Y = fft(x);
    L = size(x,1);
    if(L==1)
        error('input array must be a column');
    end
    P2 = abs(Y/L); %normalized fft
    P1 = P2(floor(1:L/2+1),:);
    P1(2:end-1,:) = 2*P1(2:end-1,:);
    switch xaxis
        case 'f'          
            f = Fs/2*linspace(0,1,(L/2+1));
            f = repmat(f',1,size(x,2));
          %  length(f(1:min(length(f),floor(Fstop/Fs*L)),:))
          %  length(P1(1:floor(Fstop/Fs*L),:))
            plot(f(1:min(length(f),floor(Fstop/Fs*L)),:),P1(1:min(length(P1),floor(Fstop/Fs*L)),:)); 
            if(Fstop >= Fs/2)
                hold on;
                plot(Fs/2,0,'x');
                hold off;
            end
            xlabel('freq (Hz)');
            ylabel('|X|');
        case 'nf'
            f = linspace(0,1,(L/2+1));
            f = repmat(f',1,size(x,2));
            plot(f(1:min(length(f),floor(Fstop/Fs*L)),:),P1(1:min(length(P1),floor(Fstop/Fs*L)),:)); 
            xlabel('norm freq w.r.t. fs/2');
            ylabel('|X|');
        case 'lognf'          
            f = linspace(0,1,(L/2+1));
            f = repmat(f',1,size(x,2));
            semilogy(f(1:min(length(f),floor(Fstop/Fs*L)),:),P1(1:min(length(P1),floor(Fstop/Fs*L)),:)); 
            xlabel('norm freq w.r.t. fs/2');
            ylabel('log|X|');      
        case 'w'
            f = 2*pi*Fs/2*linspace(0,1,(L/2+1));
            f = repmat(f',1,size(x,2));
            plot(f(1:min(length(f),floor(Fstop/Fs*L)),:),P1(1:min(length(P1),floor(Fstop/Fs*L)),:)); 
            if(Fstop >= Fs/2)
                hold on;
                plot(2*pi*Fs/2,0,'x');
                hold off;
            end
            xlabel('w (rad/s)');
            ylabel('|X|');
        case 'logw'
            f = 2*pi*Fs/2*linspace(0,1,(L/2+1));
            f = repmat(f',1,size(x,2));
            semilogy(f(1:min(length(f),floor(Fstop/Fs*L)),:),P1(1:min(length(P1),floor(Fstop/Fs*L)),:)); 
            if(Fstop >= Fs/2)
                hold on;
                plot(2*pi*Fs/2,0,'x');
                hold off;
            end
            xlabel('w (rad/s)');
            ylabel('log|X|');            
        case 'nw'
            f = 2*pi*linspace(0,1,(L/2+1));
            f = repmat(f',1,size(x,2));
            plot(f(1:min(length(f),floor(Fstop/Fs*L)),:),P1(1:min(length(P1),floor(Fstop/Fs*L)),:)); 
            xlabel('norm w w.r.t. fs/2');
            ylabel('|X|');
        otherwise
            error('xaxis format not recognized')
    end
end


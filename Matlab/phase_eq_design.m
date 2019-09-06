function [eq_filter,c,tau] = phase_eq_design(filter,gdt,M,T,K)
%PHASE_EQ_DESIGN design a phase equalizer for the target filter
%   filter: filter to be phase-equalized
%   gdt : group delay target 
%   M : number of sections
%   T: Sampling period
%   K: Number of sampling points

    T = 1;
    [gdf,wf] = grpdelay(filter);
    gdf = gdf(1:end/K:end);
    wf = wf(1:end/K:end);
    coeff = ones(2*M,1).*0.1;
    x0 = [coeff;gdt];
    eq_filter=[];
    
    gde=@(c,w) 2*T*sum(((1-c(:,1).^2 + c(:,2).*(1-c(:,1)).*cos(w.*T))./ ...
                     ((1-c(:,1)).^2 + c(:,2).^2 + 2.*c(:,2).*(1+c(:,1)).*cos(w.*T)+4.*c(:,1).*cos(w.*T).^2)),1);
                 
    gdfe = @(c)gdf + gde(c,wf')';
    
    err = @(x) gdfe(reshape(x(1:end-1),M,2))./T - x(end);
    
    x=x0;
    %x = fminimax(err,x0)
    
    tau = x(end);
    c = reshape(x(1:end-1),M,2);
    
    % design of the all-pass filter
    
    eq_filter = dfilt.df2t(fliplr([c(1,:) 1]),[c(1,:) 1]);
    
    for m=2:M
        eq_filter = dfilt.cascade(eq_filter,dfilt.df2t(fliplr([c(m,:) 1]),[c(m,:) 1]));
    end
    
    fvtool(eq_filter);

end


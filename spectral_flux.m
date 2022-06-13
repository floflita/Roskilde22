function out = spectral_flux(X)
% Spectral Flux measured the rate of change of the spectral shape.
% 
% Input:
%       - X : stft of audio signal
%  
% Output:
%       - out : spectral flux
% 
%  out = spectral_flux(X)


%% Run
for n = 2:size(X,2)
    out(n) = sum(sqrt((abs(X(:,n))-abs(X(:,n-1))).^2));
end


function out = spectral_spread(SC,X,f)
% Spectral Spread describes how the spectrzm is concentrated around the
% spectral centroid
% 
% Input:
%       - SC: spectral centroid of signal
%       - X : stft of audio signal
%       - f : frequency axis of signal
%  
% Output:
%       - out : spectral spread (Hz)
% 
% out = spectral_spread(SC,X,f)

%% Run


% out = sqrt(sum((log2(f/1000)-SC.^2).*abs(X).^2,1)./sum(abs(X).^2,1));

out = sum((f-SC).^2 .* abs(X),1) ./ sum(abs(X),1);
function out = spectral_centroid(X,f)
% Spectral Centroid describes the gravity center of spectral energy.
% 
% Input:
%       - X : stft of audio signal
%       - f : frequency axis of signal
%  
% Output:
%       - out : spectral centroid (Hz)
% 
% out = spectral_centroid(X,f)


%% Run
% combine all bins below 62.5 Hz into one band
% fn = cat(31.25, f(f>62.5));
% Xbelow = sum(X(f<62.5,:),1);
% Xn = cat(Xbelow, X(f>62.5,:));


% out = sum(log2(f/1000).*abs(X).^2,1) ./ sum(abs(X).^2);

out = sum(f.*abs(X),1) ./ sum(abs(X),1);

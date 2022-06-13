function out = spectral_rolloff(X,f)
% Spectral Rolloff is a measure of the bandwidth of the audio signal. It is
% defined as the frequency bin below which the accumulated magnitudes of
% the STFT reaches 85% of the overall sum
% 
% Input:
%       - X : stft of audio signal
%       - f : frequency axis of signal
%  
% Output:
%       - out : spectral rolloff bandwidth (in Hz)
% 
%  out = spectral_rolloff(X,f)


%% Run
% total sum of magnitudes in the frequency axis
Xtot = sum(abs(X),1);

% cumulative sum of magnitudes
Xgradual = cumsum(abs(X),1);


for n = 1:size(X,2)
    % apply 85% of overall sum condition
    fbelow = f(Xgradual(:,n) < 0.85*Xtot(n));
    % extract the rolloff frequency
    out(n) = fbelow(end);
end


clear
close all
clc

% % add path to Jeremy's toolbox
% addpath('Marozeau_Timbre_Toolbox')
% addpath Marozeau_Timbre_Toolbox/slaney
% addpath Marozeau_Timbre_Toolbox/slaney/another_mex
% 
% help MFCC % Mel Frequency Cepstral Coefficent, look at 4 first coefficients
% help CorrelogramArray % array of correlogram frames of audio
% help env_conv % find out what it gives


% add path to audio folder
addpath audio

%%
[x,fs] = audioread('sk8rboi.wav');
T = length(x)/fs;

window_size = 2^12;
hop = 2^8;

[X,t,f] = stft(x,fs);


rolloff = spectral_rolloff(X,f);

figure;
plot(t,rolloff, 'LineWidth', 2)
xlabel('time [s]')
ylabel('Spectral Rolloff [Hz]')
title('Spectral Rolloff')
xlim([0 T])

flux = spectral_flux(X);
figure;
plot(t,flux, 'LineWidth', 2)
xlabel('time [s]')
ylabel('Spectral Flux')
title('Spectral Flux')
xlim([0 T])


SC = spectral_centroid(X,f);
figure;
plot(t,SC, 'LineWidth', 2)
xlabel('time [s]')
ylabel('Spectral Centroid [Hz]')
title('Spectral Centroid')
xlim([0 T])


%% GENERAL SPECTRAL DESCRIPTORS IMPLEMENTATION
% Refer to:
% https://uk.mathworks.com/help/audio/ug/spectral-descriptors.html

% Housekeeping
clear; close all; clc
addpath audio
play=false;

%% Reading file

% [signal, fs]=audioread('funk.wav');
% if play; soundsc(signal,fs); end

fs = 48000;
T = 10;
t = 0:1/fs:T;
f = 2000;
signal = 0.5 * sin(2*pi*f*t');

% signal = sum(signal,2)/2;


%% STFT

[X,f,t]=stft(signal,fs,'Window',kaiser(256,5),'OverlapLength',220,...
    'FFTLength',512,'FrequencyRange','onesided');
XdB=10.*log10(abs(X));

mfig('STFT');
imagesc(t, f, XdB);
set(gca,'YDir','normal');
colormap;
colorbar;
ylim([0 fs/2]);
xlabel('Time (s)');
ylabel('Frequency (Hz)');

%% Spectral Centroid
centroid = spectralCentroid(signal,fs);

mfig('Spectral Centroid')
subplot(2,1,1)
t = linspace(0,size(signal,1)/fs,size(signal,1));
plot(t,signal)
ylabel('Amplitude')

subplot(2,1,2)
t = linspace(0,size(signal,1)/fs,size(centroid,1));
plot(t,centroid)
xlabel('Time (s)')
ylabel('Centroid (Hz)')

%% Spectral Spread
% The spectral centroid represents the "center of gravity" of the spectrum.
% It is used as an indication of brightness.

spread = spectralSpread(signal,fs);

mfig('Spectral Spread');
subplot(2,1,1)
spectrogram(signal,round(fs*0.05),round(fs*0.04),2048,fs,'yaxis')

subplot(2,1,2)
t = linspace(0,size(signal,1)/fs,size(spread,1));
plot(t,spread)
xlabel('Time (s)')
ylabel('Spread')

%% Spectral Skewness
% The spectral spread represents the "instantaneous bandwidth" of the
% spectrum. It is used as an indication of the dominance of a tone.
% For example, the spread increases as the tones diverge and decreases as
% the tones converge.

skewness = spectralSkewness(signal,fs);
t = linspace(0,size(signal,1)/fs,size(skewness,1))/60;

mfig('Spectral Skewness')
subplot(2,1,1)
spectrogram(signal,round(fs*0.05),round(fs*0.04),2048,fs,'yaxis')

subplot(2,1,2)
plot(t,skewness)
xlabel('Time (minutes)')
ylabel('Skewness')

%% Spectral Kurtosis
% The spectral kurtosis measures the flatness, or non-Gaussianity, of the
% spectrum around its centroid. Conversely, it is used to indicate the
% peakiness of a spectrum. For example, as the white noise is increased on 
% the speech signal, the kurtosis decreases, indicating a less peaky
% spectrum.

kurtosis = spectralKurtosis(signal,fs);

mfig('Spectral Kurtosis')
t = linspace(0,size(signal,1)/fs,size(signal,1));
subplot(2,1,1)
plot(t,signal)
ylabel('Amplitude')

t = linspace(0,size(signal,1)/fs,size(kurtosis,1));
subplot(2,1,2)
plot(t,kurtosis)
xlabel('Time (s)')
ylabel('Kurtosis')

%% Spectral Entropy
% Spectral entropy has been used successfully in voiced/unvoiced decisions
% for automatic speech recognition [6]. Because entropy is a measure of 
% disorder, regions of voiced speech have lower entropy compared to regions 
% of unvoiced speech.
% Spectral entropy has also been used to discriminate between speech and
% music [7] [8]. For example, compare histograms of entropy for speech, 
% music, and background audio files.

entropy = spectralEntropy(signal,fs);

mfig('Spectral Entropy')

t = linspace(0,size(signal,1)/fs,size(signal,1));
subplot(2,1,1)
plot(t,signal)
ylabel('Amplitude')

t = linspace(0,size(signal,1)/fs,size(entropy,1));
subplot(2,1,2)
plot(t,entropy)
xlabel('Time (s)')
ylabel('Entropy')

%% Spectral Flatness
%Spectral flatness (spectralFlatness) measures the ratio of the geometric
% mean of the spectrum to the arithmetic mean of the spectrum [9]
% Spectral flatness is an indication of the peakiness of the spectrum. 
% A higher spectral flatness indicates noise, while a lower spectral
% flatness indicates tonality.

flatness = spectralFlatness(signal,fs);

mfig('Spectral Flatness');
subplot(2,1,1)
t = linspace(0,size(signal,1)/fs,size(signal,1));
plot(t,signal)
ylabel('Amplitude')

subplot(2,1,2)
t = linspace(0,size(signal,1)/fs,size(flatness,1));
plot(t,flatness)
ylabel('Flatness')
xlabel('Time (s)')

%% Spectral Crest
% Spectral crest (spectralCrest) measures the ratio of the maximum of the 
% spectrum to the arithmetic mean of the spectrum [1]:
% Spectral crest is an indication of the peakiness of the spectrum. A 
% higher spectral crest indicates more tonality, while a lower spectral 
% crest indicates more noise.

crest = spectralCrest(signal,fs);

mfig('Spectral Crest')
subplot(2,1,1)
t = linspace(0,size(signal,1)/fs,size(signal,1));
plot(t,signal)
ylabel('Amplitude')

subplot(2,1,2)
t = linspace(0,size(signal,1)/fs,size(crest,1));
plot(t,crest)
ylabel('Crest')
xlabel('Time (s)')

%% Spectral Flux
% Spectral flux (spectralFlux) is a measure of the variability of the
% spectrum over time [12]:
% Spectral flux is popularly used in onset detection [13] and audio
% segmentation [14]. For example, the beats in the drum track correspond to
% high spectral flux.

flux = spectralFlux(signal,fs);

mfig('Spectral Flux')
subplot(2,1,1)
t = linspace(0,size(signal,1)/fs,size(signal,1));
plot(t,signal)
ylabel('Amplitude')

subplot(2,1,2)
t = linspace(0,size(signal,1)/fs,size(flux,1));
plot(t,flux)
ylabel('Flux')
xlabel('Time (s)')

%% Spectral Slope
% Spectral slope (spectralSlope) measures the amount of decrease of the 
% spectrum [15]:
% Spectral slope has been used extensively in speech analysis, particularly
% in modeling speaker stress [19]. The slope is directly related to the 
% resonant characteristics of the vocal folds and has also been applied to 
% speaker identification [21]. Spectral slope is a socially important 
% aspect of timbre. Spectral slope discrimination has been shown to occur 
% in early childhood development [20]. Spectral slope is most pronounced 
% when the energy in the lower formants is much greater than the energy in 
% the higher formants.

slope = spectralSlope(signal,fs);

mfig('Spectral Slope');
t = linspace(0,size(signal,1)/fs,size(slope,1));
subplot(2,1,1)
spectrogram(signal,round(fs*0.05),round(fs*0.04),round(fs*0.05),fs,'yaxis','power')

subplot(2,1,2)
plot(t,slope)
title('Female Speaker')
ylabel('Slope')
xlabel('Time (s)')

%% Spectral decrease 
% spectralDecrease represents the amount of decrease of the spectrum, while 
% emphasizing the slopes of the lower frequencies [1]:
% Spectral decrease is used less frequently than spectral slope in the 
% speech literature, but it is commonly used, along with slope, in the 
% analysis of music. In particular, spectral decrease has been shown to 
% perform well as a feature in instrument recognition [22].

decrease = spectralDecrease(signal,fs);

t = linspace(0,size(signal,1)/fs,size(decrease,1));

mfig('Spectral Decrease')
plot(t,decrease)
ylabel('Decrease')

%% Spectral Rolloff Point
% The spectral rolloff point (spectralRolloffPoint) measures the bandwidth
% of the audio signal by determining the frequency bin under which a given
% percentage of the total energy exists [12]:
%The spectral rolloff point has been used to distinguish between voiced and 
% unvoiced speech, speech/music discrimination [12], music genre 
% classification [16], acoustic scene recognition [17], and music mood 
% classification [18]. For example, observe the different mean and variance 
% of the rolloff point for speech, rock guitar, acoustic guitar, and an 
% acoustic scene.

rolloff = spectralRolloffPoint(signal,fs);

t = linspace(0,size(signal,1)/fs,size(rolloff,1));

mfig('Spectral Rolloff')
plot(t,rolloff)
ylabel('Rolloff Point (Hz)')
xlabel('Time (s)')




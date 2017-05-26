function[feat_audio] = feat_one_sound(audiofile, mean_train, dev_train)

frame_length = 50;
frame_shift = 25;
alpha = 0.97;
window = @hanning;
R = [300 5000]; %frequency range
M = 26; % number of filterbank channels
N = 20; % number of mfcc
L = 22; % liftering coefficient

[sound_data, samp_freq] = audioread(audiofile, 'native');
sound_data = sound_data(:, 1); %only data in 1st column
sound_data = sound_data(:, 1);
[ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
    frame_shift, alpha, window, R, M, N, L );
CC = CC';
CC = CC(1:8,:);
CC = CC(:);
CC = CC';

feat_audio = CC;

feat_audio = (feat_audio - mean_train)./dev_train;

end
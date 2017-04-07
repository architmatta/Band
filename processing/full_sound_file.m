%file to analyse any sound file of any length and give the output of
% net for each interval

function [out, a] = full_sound_file(audiofile, net)

frame_length = 50;
frame_shift = 25;
alpha = 0.97;
window = @hanning;
R = [300 5000]; %frequency range
M = 26; % number of filterbank channels
N = 20; % number of mfcc
L = 22; % liftering coefficient

[sound_data, samp_freq] = audioread(audiofile, 'double');
sound_data = sound_data(:, 1); %only data in 1st column
[ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
    frame_shift, alpha, window, R, M, N, L );
CC = CC';

num_row = size(CC, 1);
files = floor(num_row/8) - 1;

files_feat = [];
for i = 0:files
    temp1 = CC((i*8+1):(i*8+8), :);
    temp1 = temp1(:)';
    files_feat = [files_feat; temp1];
end

out = [];
for i = 1:size(files_feat, 1)
    temp2 = net(files_feat(i, :)');
    out = [out temp2];
end

out = out';

y = out(:, 1) > 0.75;
a = [1:length(y)];
a = a';
a = a.*y;
a = a*250;
a = nonzeros(a);
a = a/1000;
end
function[out] = test_main(net)
[test_sound] = get_test_data();
test_feat = [];

frame_length = 50;
frame_shift = 25;
alpha = 0.97;
window = @hanning;
R = [300 5000]; %frequency range
M = 26; % number of filterbank channels
N = 20; % number of mfcc
L = 22; % liftering coefficient

for i = 1:size(test_sound)
   audiofile = test_sound(i,:);
   [sound_data, samp_freq] = audioread(audiofile, 'double');
   sound_data = sound_data(:, 1); %only data in 1st column
   [ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
        frame_shift, alpha, window, R, M, N, L );
    CC = CC';
    CC = CC(1:8,:);
    CC = CC(:);
    CC = CC';
    
    test_feat = [test_feat; CC];
end
out = net(test_feat');
end
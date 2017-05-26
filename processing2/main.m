%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main file to calculate the feature
%This file is meant to process the data and find features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sound_train, final_output] = main(frame_length, frame_shift, alpha, window, R, M, N, L)
[horn_train] = get_horn_data();
[silence_train] = get_silence_data();
[cry_train] = get_cry_data();

horn_feat = [];
silence_feat = [];
cry_feat = [];

horn_out = [];
silence_out = [];
cry_out = [];

%% ==========Part 1: Find Feature and visualize============
for i = 1:size(horn_train)
   audiofile = horn_train(i,:);
   [sound_data, samp_freq] = audioread(audiofile, 'double');
   sound_data = sound_data(:, 1); %only data in 1st column
   %sound_data = sound_data(1:samp_freq/4);
   [ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
        frame_shift, alpha, window, R, M, N, L );
    CC = CC';
    CC = CC(1:8,:);
    CC = CC(:);
    CC = CC';
    
    horn_feat = [horn_feat; CC];
    horn_out = [horn_out; 1];
    silence_out = [silence_out; 0];
    cry_out = [cry_out; 0];
end

output1 = ones(size(horn_feat, 1), 1);

for i = 1:size(silence_train) 
    audiofile = silence_train(i, :);
    [sound_data, samp_freq] = audioread(audiofile, 'double');
    sound_data = sound_data(:, 1);
    %sound_data = sound_data(1:samp_freq/4);
   [ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
        frame_shift, alpha, window, R, M, N, L );
    CC = CC';
    CC = CC(1:8,:);
    CC = CC(:);
    CC = CC';
    
    silence_feat = [silence_feat; CC];
    horn_out = [horn_out; 0];
    silence_out = [silence_out; 1];
    cry_out = [cry_out; 0];
end
out1= ones(size(horn_feat, 1), 1);
for i = 1:size(silence_feat, 1)
    output1 = [output1; 0];
end

for i = 1:size(cry_train)
   audiofile = cry_train(i,:);
   [sound_data, samp_freq] = audioread(audiofile, 'double');
   sound_data = sound_data(:, 1); %only data in 1st column
   %sound_data = sound_data(1:samp_freq/4);
   [ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
        frame_shift, alpha, window, R, M, N, L );
    CC = CC';
    CC = CC(1:8,:);
    CC = CC(:);
    CC = CC';
    
    cry_feat = [cry_feat; CC];
    horn_out = [horn_out; 0];
    silence_out = [silence_out; 0];
    cry_out = [cry_out; 1];
end
%% ====================== final ==============================

%all features
sound_train = [horn_feat; silence_feat; cry_feat];

new_output = [output1 abs(output1-1)];
final_output = [horn_out silence_out cry_out];

end


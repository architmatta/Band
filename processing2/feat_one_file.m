%Divide a long file in samples of 250ms and calculate each samples feature
% not normalised
function [CC_files, sound_files, samp_freq] ...
        = feat_one_file(audiofile, frame_length, frame_shift, ...
                                        alpha, window, R, M, N, L)

[sound_data, samp_freq] = audioread(audiofile, 'double');
time_sound = [1/samp_freq:1/samp_freq:length(sound_data)/samp_freq];
sound_data = sound_data(:, 1); %only data in 1st column
time_sound = time_sound';

num_files = floor(length(sound_data)*4/samp_freq);

for i = 1:num_files
    temp1 = ((i-1)*samp_freq/4) + 1;
    temp2 = (i*samp_freq/4);
    sound_files(:, i) = sound_data(temp1:temp2);
end
sound_files = sound_files';

CC_files = [];
for i = 1:num_files
    [ CC, FBE, frames ] = mfcc( sound_files(i, :), samp_freq, frame_length,...
                                frame_shift, alpha, window, R, M, N, L );
                            
     CC = CC';
     CC = CC(1:8, :);
     CC = CC(:);
     CC = CC';
     
     CC_files = [CC_files; CC];
end

end
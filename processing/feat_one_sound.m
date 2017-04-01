function[feat_audio] = feat_one_sound(audiofile)

[sound_data, samp_freq] = audioread(audiofile, 'double');
   sound_data = sound_data(:, 1); %only data in 1st column
   [ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
        frame_shift, alpha, window, R, M, N, L );
    CC = CC';
    CC = CC(1:8,:);
    CC = CC(:);
    CC = CC';
    
    feat_audio = CC;

end
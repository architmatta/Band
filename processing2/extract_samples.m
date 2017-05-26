%This file will detect different types of sound in files and extrct 
%sample files of 3 secs from there

hornUnclipped_data = get_hornUnclipped_data();
cryUnclipped_data = get_cryUnclipped_data();
ambUnclipped_data = get_ambUnclipped_data();

frame_length = 50;
frame_shift = 25;
alpha = 0.97;
window = @hanning;
R = [300 5000]; %frequency range
M = 26; % number of filterbank channels
N = 20; % number of mfcc
L = 22; % liftering coefficient

fprintf('Training network with previous 250ms files...');
[net, mean_train, dev_train, epochs, msret, msrev, msretest, time, ...
                    num_input, num_hidden, num_output] = train_one_time();
            
fprintf('Trained.');

for j = 1:size(hornUnclipped_data, 1)
    j
    audiofile = hornUnclipped_data(j, :);
    [CC_files, sound_files, samp_freq] ...
        = feat_one_file(audiofile, frame_length, frame_shift, ...
                                        alpha, window, R, M, N, L);
                                    
                                    
    [sample_horn, sample_cry, sample_horn_out, sample_cry_out] ...
          = three_sec_samples(net, sound_files, CC_files, mean_train,...
                                  dev_train);
                              
    for i = 1:size(sample_horn, 2)
        filename = strcat('.\SoundDataNew\horn_new_', int2str(j), '_', int2str(i), '.wav');
        audiowrite(filename, sample_horn(:, i), samp_freq);
    end
 end


for k = 1:size(cryUnclipped_data, 1)
    k
    audiofile = cryUnclipped_data(k, :);
    [CC_files, sound_files, samp_freq] ...
        = feat_one_file(audiofile, frame_length, frame_shift, ...
                                        alpha, window, R, M, N, L);
                                    
                                    
    [sample_horn, sample_cry, sample_horn_out, sample_cry_out] ...
          = three_sec_samples(net, sound_files, CC_files, mean_train,...
                                  dev_train);
                              
    for i = 1:size(sample_cry, 2)
        filename = strcat('.\SoundDataNew\cry_new_', int2str(k), '_', int2str(i), '.wav');
        audiowrite(filename, sample_cry(:, i), samp_freq);
    end
end

for l = 1:size(ambUnclipped_data, 1)
    l
    audiofile = ambUnclipped_data(l, :);
    [ambience_data, samp_freq] = audioread(audiofile, 'double');
    ambience_data = ambience_data(:, 1);
    
    for i = 1:floor(size(ambience_data)/(3*samp_freq))
        start = (i-1)*3*samp_freq + 1;
        finish = i*3*samp_freq;
        sample = ambience_data(start:finish);
        
        filename = strcat('.\SoundDataNew\ambience_new_', int2str(l), '_', int2str(i), '.wav');
        audiowrite(filename, sample, samp_freq);
    end  
end

clear ; close all; clc;

[horn_train] = get_horn_data();
[random_train] = get_random_data();
horn_feat = [];
random_feat = [];

for i = 1:size(horn_train) 
    audiofile = horn_train(i, :);
    [result, LL, AA, FF, AiHn, mask, sortvals] = peakdet(audiofile);
    feature = calc_feat(LL, AA, FF, AiHn, mask, sortvals);
    feature = real(feature);
    
    horn_feat = [horn_feat; feature];
end
output = ones(size(horn_feat, 1), 1);

for i = 1:size(random_train) 
    audiofile = random_train(i, :);
    [result, LL, AA, FF, AiHn, mask, sortvals] = peakdet(audiofile);
    feature = calc_feat(LL, AA, FF, AiHn, mask, sortvals);
    feature = real(feature);
    
    random_feat = [random_feat; feature];
end
for i = 1:size(random_feat, 1)
    output = [output; 0];
end
sound_train = [horn_feat; random_feat];

new_output = [output abs(output-1)];
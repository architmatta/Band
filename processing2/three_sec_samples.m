function[sample_horn, sample_cry, sample_horn_out, sample_cry_out] ...
          = three_sec_samples(net, sound_files, CC_files, mean_train,...
                                  dev_train)

sample_horn = [];
sample_cry = [];

out_net = [];
sample = [];

sample_horn_out = [];
sample_cry_out = [];

for i = 1:size(CC_files, 1)
    temp = CC_files(i, :);
    temp = (temp - mean_train)./dev_train; % zero mean unit variance
    prob = net(temp')';
    
    if(prob(1)>0.8)
        if(i>5 && i<(size(CC_files, 1)-6))
            start = i-5;
            finish = i+6;
            sample = sound_files(start:finish, :);
            sample = sample()';
            sample = sample(:);
            sample_horn = horzcat(sample_horn, sample);
            a = [1; 0; 0];
            sample_horn_out = horzcat(sample_horn_out, a);
        end
    end
    
    if(prob(3)>0.8)
        if(i>5 && i<(size(CC_files, 1)-6))
            start = i-5;
            finish = i+6;
            sample = sound_files(start:finish, :);
            sample = sample()';
            sample = sample(:);
            sample_cry = horzcat(sample_cry, sample);
            a = [0; 0; 1];
            sample_cry_out = horzcat(sample_cry_out, a);
        end
    end
    
    out_net = [out_net; prob];
end

end
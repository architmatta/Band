function [T, max_freq, val, feature] = print3D_audio(audiofile)
%Y is sampled data and Fs is sample rate
[Y, Fs] = audioread(audiofile, 'double');

%L = length(Y);
%f1 = Fs*(0:(L/2))/L;

nfft = 150;
noverlap=nfft/2;
wnd= hamming(nfft,'periodic');
[S, F, T, P] = spectrogram (Y, wnd, noverlap, nfft, Fs);
%P is spectral density of signal
E = 10*log10(abs(P));
mesh(T,F,E);

[sortvals, sortidx] = sort(E,1,'descend'); 
B = zeros(size(E),'like',E); 
for K = 1 : size(E,1) 
B(K,sortidx(K,1:10)) = sortvals(K,1:10); 
end

tenval = sortvals(10, :);
tenind = sortidx(10,:);
mask=bsxfun(@ge,E,tenval);
L = sum(mask,2);
mask=mask.*E;
A = sum(mask,2);
tmp = mask;
tmp(tmp==0) = -Inf;
H = max(tmp,[],2);
L = L*6.8;
Output = [L H A F];
sorted_output = sortrows(Output, -1);
sorted_output = sorted_output(1:10, :);

[feature] = calc_feat(sorted_output);

%max of E over F at given T
[val, ind] = max(E, [], 1);
max_freq = F(ind);



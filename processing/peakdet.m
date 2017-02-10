function [output,LL, AA, FF, AiHn, mask, sortvals] = peakdet(audiofile)
%Y is sampled data and Fs is sample rate
[Y, Fs] = audioread(audiofile, 'double');
Y = Y(:, 1);
%L = length(Y);
%f1 = Fs*(0:(L/2))/L;

nfft = 150;
noverlap=nfft/2;
wnd= hamming(nfft,'periodic');
[S, F, T, P] = spectrogram (Y, wnd, noverlap, nfft, Fs);
%P is spectral density of signal
E = 10*log10(abs(P));
%mesh(T,F,E);

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
L = L*6.8;
A = sum(mask,2);
tmp = A;
[sortv, sorti] = sort(tmp,1,'ascend');
AA=sortv(1:8);
II=sorti(1:8);
FF=II;
LL=II;
for z = 1:8;
    FF(z)=F(II(z));
end;
for z = 1:8;
    LL(z)=L(II(z));
end;
AiHn = randn(8,size(E,2));
for n = 1:8;
    for i = 1:size(E,2);
        AiHn(n,i)= mask(II(n),i);
    end;
end;
output = [LL AA FF];
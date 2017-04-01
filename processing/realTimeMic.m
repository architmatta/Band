ai = analoginput('winsound');
addchannel(ai,1);
Fs = 22050;
NFFT = 16000 / 100;
set (ai, 'SampleRate', Fs);
set (ai, 'SamplesPerTrigger', duration*Fs);
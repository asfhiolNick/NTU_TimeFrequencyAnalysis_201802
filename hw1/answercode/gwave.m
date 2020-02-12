function output = gwave(a, b, c, T, Fs)
t=[0:Fs*T-1]./Fs;

F1=2*pi*(a/3*t.^3-a*b*t.^2+(a*b*b+c)*t);
output = cos(F1);

audioFile = 'HW1wave.wav';
audiowrite(audioFile, output, Fs);

[a1, fs]=audioread('Chord.wav');
x=a1(:,1);
dtau=1/44100; dt=0.01; df=1; sgm=200;
tau=0:dtau:1.6; t=0:dt:max(tau); f=20:df:1000;
tic
% y=Gabor(x,tau,t,f,sgm);
y=Gabor(x,tau,t,f,sgm);
toc

image(t, f, abs(y)/max(max(abs(y)))*400);
colormap(gray(256));
set(gca, 'Ydir', 'normal');
dt=0.05;
df=0.05;
t1=[0:dt:10-dt]; t2=[10:dt:20-dt]; t3=[20:dt:30];
t=[0:dt:30];
f=[-5:df:5];
x=[cos(2*pi*t1), cos(6*pi*t2), cos(4*pi*t3)];
B=1;
tic
y=recSTFT(x,t,f,B);
toc
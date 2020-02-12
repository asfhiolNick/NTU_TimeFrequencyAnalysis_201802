function y = recSTFT(x, t, f, B)
%Restrict B<10
%Step 1:Calculate n0, m0, T, F, N, Q
dt=t(2)-t(1);
df=f(2)-f(1);
N=round( 1/(dt*df) );
n=t./dt; n=round(n); n0=n(1); T=length(n);
m=f./df; m=round(m); m0=m(1); F=length(m);
Q=round(B/dt);
fprintf('%d', Q);

X=zeros(T,F);
spacet=zeros(1,T);
spacef=zeros(1,F);
x=[x,0];
%Step 2:n=n0
for a = 1:T
    %Step 3:determine x1(q)
    zeropt= zeros(1, N-2*Q-1);
    q=[0:2*Q]; valpt=round(n(a)-Q+q); valpt(valpt<1)=T+1; valpt(valpt>T)=T+1;
    x1=[x(valpt), zeropt];   
    %Step 4:X1(m)=FFT[x1(q)]
    X1=fft(x1, N);
    %Step 5:Convert X1(m) into X(ndt, mdf)
    for b = 1:F
        spacet(1,a)=n(a)*dt;
        spacef(1,b)=m(b)*df;
        X(a,b)     =X1(1,mod(m(b),N)+1)*exp(i*2*pi*(Q-n(a))*m(b)/N)*dt;
    end
end
y=X';


image(spacet, spacef, abs(y)/max(max(abs(y)))*400);
colormap(gray(256));
set(gca, 'Ydir', 'normal');
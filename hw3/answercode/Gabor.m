function y = Gabor(x, tau, t, f, sgm)
%Step 1:Calculate c0, m0, no, C, F, T, N, Q
dtau=tau(2)-tau(1); dt=t(2)-t(1); df=f(2)-f(1);
n=round(tau./dtau);  T=length(n);
m=round(f./df);      F=length(m);
c=round(t./dt);      C=length(c);
N=round(1/(dtau*df)); Q=round(1.9143/(sqrt(sgm)*dtau)); S=round(dt/dtau);
m =mod(m, N)+1; %Consider m<0 || m==0
%Step 2:n=c0
X=zeros(F,C);
for a = 1:C
    %Step3:Determine x1(q)
    x1=zeros(N-2*Q-1, 0);
    q=(0:1:2*Q)';
    x1=x(max(min((a-1)*S+1-Q+q, T), 1)).*exp(-sgm*pi*((Q-q)*dtau).^2);
    x1=[x1;zeros(N-2*Q-1,1)];
    %Step4:X1(m)=FFT(x1(q))
    X1=fft(x1, N);
    %Step5:ConvertX1(m) into X(ndt, mdf)
    for b = 1:F
        X(b,a)=dtau*exp(j*2*pi*(Q-a*S)*b/N)*X1(m(b),1);  
    end
end
y=X;
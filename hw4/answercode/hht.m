function y=hht(x, t, thr)
%Step1: Initial
y=x; n=1; k=1; key=0; keys=0; length=size(y,2);
while n<10 && keys==0
    k=1; key=0;
    while k<30 && key==0
        %Step2: Find the local peaks/Step4: Find the local dips
        idmax=[]; idmin=[];
        for i = 2:length-1
            if (y(i)>=y(i-1)) && (y(i)>=y(i+1))
                idmax=[idmax, i];
            elseif (y(i)<=y(i-1) && y(i)<=y(i+1))
                idmin=[idmin, i];
            end
        end
        %Step3: Connect local peaks/Step5: Connect local dips
        spmax=spline(t(idmax), y(idmax), t);
        spmin=spline(t(idmin), y(idmin), t);
        %Step6: Compute the mean, the residue
        z = (spmax+spmin)*0.5;
        h = y-z;
        %Step7: Check whether h_k(t) is an IMF       
        key=1;
        hidmax=[]; hidmin=[];
        for i = 2:length-1
            if (h(i)>=h(i-1)) && (h(i)>=h(i+1))
                hidmax=[hidmax, i];
            elseif (h(i)<=h(i-1) && h(i)<=h(i+1))
                hidmin=[hidmin, i];
            end
        end
        u1=spline(t(hidmax), h(hidmax), t);
        u0=spline(t(hidmin), h(hidmin), t);        
        
        
        for i = hidmax
            if h(i) <= 0
                key=0;
            end
        end
        for i = hidmin
            if h(i) >= 0
                key=0;
            end
        end
        sum = abs(u1+u0);
        for i = 1:length
            if sum >= thr
                key=0;
            end
        end
        if ~(key==0 && k<30)
            c(n, : )=h;
        else
            y=h;
            k=k+1;
        end
    end
    %Step 8:Calculate x0(t)=x(t)-(c1(t)+...+cn(t))
    x0 = x;
    for i = 1:n
        x0=x0-c(i, :);
    end
    iter = 0;
    for i = 2:length-1
        if x0(i)>=x0(i-1) && x0(i)>=x0(i+1)
            iter=iter+1;
        elseif x0(i)<=x0(i-1) && x0(i)<=x0(i+1)
            iter=iter+1;
        end
    end
    keys=1;
    if iter>2
        keys=0;
    end
    if ~(n<10 && keys==0)
        c(n+1, : )=x0;
    end
    y=x0;
    n=n+1;
end
y = c;
function y = iwavedbc10(x1L, x1H1, x1H2, x1H3)
g1 = [0.1601 -0.6038 0.7243 -0.1384 -0.2423 0.0322 0.0776 0.0062 -0.0126 -0.0033];
h1 = [-0.0033 -0.0126 0.0062 0.0776 0.0322 -0.2423 -0.1384 0.7243 -0.6038 0.1601];
h1T = transpose(h1); g1T = transpose(g1);

X1L = upsample(x1L, 2);
X1H1 = upsample(x1H1, 2);
x0 = conv2(X1L, g1T)+conv2(X1H1, h1T);

X1H2 = upsample(x1H2, 2);
X1H3 = upsample(x1H3, 2);
x1 = conv2(X1H2, g1T)+conv2(X1H3, h1T);

x0T = transpose(x0);
X0 = transpose(upsample(x0T, 2));
x1T = transpose(x1);
X1 = transpose(upsample(x1T, 2));
newx = conv2(X0, g1)+conv2(X1, h1); 
for i=1:10
    newx(1, :)=[]; newx(:, 1)=[];
end
L = size(newx, 1);
for i=1:9
    newx(L-8, :)=[]; newx(:, L-8)=[];
end
y = newx;


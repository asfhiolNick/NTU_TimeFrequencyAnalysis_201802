x = double(imread('Peppers.bmp'));
tic
y = wavedbc10(x);
toc
L = size(y, 2)/4;
x1L = y(:, 1:L); x1H1 = y(:, L+1:2*L); x1H2 = y(:, 2*L+1:3*L); x1H3 = y(:, 3*L+1:4*L);
figure(1);
colormap(gray(256));
image(x);
hold on;
figure(2);
colormap(gray(256));
subplot(2, 2, 1);
image(x1L./sqrt(2));
hold on;
subplot(2, 2, 3);
image(x1H1.*5);
hold on;
subplot(2, 2, 2);
image(x1H2.*5);
hold on;
subplot(2, 2, 4);
image(x1H3.*10);
hold on;

z = iwavedbc10(x1L, x1H1, x1H2, x1H3);
figure(3);
colormap(gray(256));
image(z);
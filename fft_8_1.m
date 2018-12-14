% 对宽带接收数据进行FFT变换，是一个子程序，一般被其他程序调用
% 2007.1.29
 
xx = zeros(J,NN,M); % x的第三维是M个阵元，第一维是要做的FFT的点数，第二维是要做的J点FFT的次数
for n=1:NN
    for m=1:M
        xx(:,n,m) = x(m,(n-1)*J+1:(n-1)*J+J);
    end
end
X = fft(xx,J,1);    % FFT变换完成 第一维是子频点的个数  
% figure
% plot((0:fs/J:fs-fs/J),abs(X(1:J,1,1)))


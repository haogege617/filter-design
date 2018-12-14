function [x] = LFMsource(M,f0,fl,B,fs,T,seta,snr,K)
 
c = 3*10^8;                       % 光速
d = 0.5*c/f0;                     % 阵元间距
ft = 0:1/fs:T-1/fs;               % 时间变量
N = length(ft);                   % 快拍数
k = B/T;                          % 调频速率
for m=1:M
    for n=1:N
        x(m,n) = 10^(snr(K)/20)*exp(i*(2*pi*fl*(ft(n)-(m-1)*d/c*sin(seta(K)))+pi*k*(ft(n)-(m-1)*d/c*sin(seta(K))).^2));
    end
end

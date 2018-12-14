function [x] = LFMsource(M,f0,fl,B,fs,T,seta,snr,K)
 
c = 3*10^8;                       % ����
d = 0.5*c/f0;                     % ��Ԫ���
ft = 0:1/fs:T-1/fs;               % ʱ�����
N = length(ft);                   % ������
k = B/T;                          % ��Ƶ����
for m=1:M
    for n=1:N
        x(m,n) = 10^(snr(K)/20)*exp(i*(2*pi*fl*(ft(n)-(m-1)*d/c*sin(seta(K)))+pi*k*(ft(n)-(m-1)*d/c*sin(seta(K))).^2));
    end
end

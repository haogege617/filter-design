% 宽带信号频域处理 

 
clear
clc 
% f0 = 1.3*10^9;                  % 信号中心频率 
% fr=1.3*10^9;  
% B = 50*10^6;                    % 信号带宽 
f0 = 2.2*10^3;                  % 信号中心频率 
fr=2.2*10^3;  
B = 3.6*10^3; 
fl = f0-B/2;                    % 信号起始频率 
fh = f0+B/2; 
Tr = 50*10^(-6);                % 工作周期 
T = 10*10^(-6);                 % 信号持续时间，要求大于孔径渡越时间 
% Tr = 5;                % 工作周期 
% T = 1;                 % 信号持续时间，要求大于孔径渡越时间 
fs = 100*10^6;                  % 采样频率 
snr = [40;0];                   % 信噪比 
w0 = 40/180*pi;                  % 指向角 
M =8;                          % 阵元数为M 
Kr=1; 
Ks = 2;                         % 信号数目 
seta =[0/180*pi,40/180*pi];     % 干扰信号方向 
Nm = 6;                        % 驻留周期个数 
Nr = Tr*fs;                     % 采样点数 
N = T*fs; 
J = 1000;                       % FFT的点数 
NN = Nm*Nr/J;                   % 频域快拍数  为么？ 
c= 340;                     % 光速 
d = 0.5*c/f0;                   % 阵元间距 
x = zeros(M,1);                 % 数据矢量 
R = zeros(M,M);                 % 接收数据协方差矩阵 
 
tic 
% 产生阵列接收的宽带数据 
x2 = LFMsource(M,f0,fl,B,fs,T,seta,snr,2); % 期望信号的脉冲宽度为T，出现时间不定 
 
% 产生干扰信号 
x1 = LFMsource(M,f0,fl,B,fs,Tr,seta,snr,1); 
% u = 1:Nr; 
% for k=1:Kr 
% for n=1:Nr 
%     fai(k,n) = rand; 
%  s(k,n) = exp(i*2*pi*(fr*u(n)/fs+fai(k,n)));       % 源信号 
% end 
% end 
% for k=1:Kr 
% for m=1:M 
%         A(m,k)=exp(-i*2*pi*d*fr*(m-1)*sin(seta(k))/c); 
%     end 
% end 
% % 阵列接收信号 
% x1 = 10.^(snr(1)/20).*A*s;  
% 阵列接收的和信号 
t1 = 1000;                                 % 任意选择的期望信号出现位置 
x1(:,(t1+1):(t1+N)) = x1(:,(t1+1):(t1+N)) + x2; 
for nm=1:Nm 
    x(:,((nm-1)*Nr+1):(nm*Nr)) = x1; 
end 
noise = randn(M,Nm*Nr)+i*randn(M,Nm*Nr);   % 噪声 
x = x + noise; 
 
% 时域信号变换为频域信号 
fft_8_1; 
toc 
tic 
% 构造方向矢量 
w = -90*pi/180:0.01:90*pi/180; 
WW = length(w); 
P = zeros(1,WW); 
Wav=zeros(M,1); 
% 计算不同子频点的加权向量                                                               
F = fl:B/(J/2-1):fh; 
for k = 1:250                      %为么是250？ 
    for m = 1:M                     % 估计子频点对应的协方差矩阵 
        for n = 1:NN 
            xf(n,m) = X(k,n,m); 
        end 
    end 
    R = xf.'*conj(xf)./NN;%   xf.'?? 
    Ri = inv(R); 
    for m=1:M 
        a0(m,1) = exp(-i*2*pi*d*F(k+250)*(m-1)*sin(w0)/c);% 指向向量  
    end  
    W = Ri*a0/(a0'*Ri*a0);                                % 加权向量 
    for m=1:M 
        a(m,:) = exp(-i*2*pi*d*F(k+250)*(m-1)*sin(w)/c);  % 方向向量，用于方向搜索 
    end 
    Wav=Wav+W; 
    f((k+250),:) = abs(W'*a).^2; 
    f((k+250),:) =f((k+250),:)./max(f((k+250),:)); 
end 
 
for k = 1:250 
    for m = 1:M                     % 估计子频点对应的协方差矩阵 
        for n = 1:NN 
            xf(n,m) = X((k+750),n,m); 
        end 
    end 
    R = xf.'*conj(xf)./NN; 
    Ri = inv(R); 
    for m=1:M 
        a0(m,1) = exp(-i*2*pi*d*F(k)*(m-1)*sin(w0)/c);% 指向向量  
    end  
    W = Ri*a0/(a0'*Ri*a0);                            % 加权向量 
    for m=1:M 
        a(m,:) = exp(-i*2*pi*d*F(k)*(m-1)*sin(w)/c);  % 方向向量，用于方向搜索 
    end 
    Wav=Wav+W; 
    f(k,:) = abs(W'*a).^2; 
    f(k,:)=f(k,:)./max(f(k,:)); 
end 
Wav=Wav./500; 
for m=1:M 
        a(m,:) = exp(-i*2*pi*d*f0*(m-1)*sin(w)/c);  % 方向向量，用于方向搜索 
end 
fav=abs(Wav'*a).^2; 
fav=fav./max(fav); 
 f1 = f(1,:)./max(f(1,:)); 
  f2 = f(500,:)./max(f(500,:)); 
   f3 = f(251,:)./max(f(251,:)); 
% figure; 
% plot(w*180/pi,10*log10(f1)); 
% % title('pattern of linear array(bearing45,interfere20),B=4M,f0=40M,不聚焦,信号不相关(0,40)dB'); 
% xlabel('\theta/deg');  
% ylabel('阵列增益/dB'); 
% grid on 
% legend('最低频率')  
% hold on 
%  
% figure; 
% plot(w*180/pi,10*log10(f2)); 
% xlabel('\theta/deg');  
% ylabel('阵列增益/dB'); 
% grid on 
% legend('最高频率')  
% hold on 
%  
% figure; 
% plot(w*180/pi,10*log10(f3)); 
% xlabel('\theta/deg');  
% ylabel('阵列增益/dB'); 
% grid on 
% legend('中心频率')  
% hold on 
%  
figure; 
plot(w*180/pi,10*log10(f1),w*180/pi,10*log10(f2),w*180/pi,10*log10(f3)); 
xlabel('\theta/deg');  
ylabel('阵列增益/dB'); 
title('不同频率下波束形成')
grid on 
legend('最低频率','最高频率','中心频率')  
hold on 
%  
% figure; 
% plot(w*180/pi,10*log10(fav)); 
% % title('pattern of linear array(bearing45,interfere20),B=4M,f0=40M,不聚焦,信号不相关(0,40)dB'); 
% xlabel('\theta/deg');  
% ylabel('阵列增益/dB'); 
% grid on 
% legend('ISM参考频率')  
% hold on 
 
% figure; 
% plot(w*180/pi,10*log10(f3),w*180/pi,10*log10(fav)); 
% xlabel('\theta/deg');  
% ylabel('阵列增益/dB'); 
% grid on 
% legend('不做平均的中心频率','平均后的中心频率')  
% hold on 
 
figure;  % 三维立体图
[XX,Y] = meshgrid(w*180/pi,F); 
meshc(XX,Y,10*log10(f/max(max(f)))) 
title('宽带波束形成'); 
xlabel('\theta/deg');  
ylabel('频率/Hz'); 
zlabel('阵列增益/dB')
toc

% 作者：叶夜笙歌 
% 来源：CSDN 
% 原文：https://blog.csdn.net/YJJat1989/article/details/22174925 
% 版权声明：本文为博主原创文章，转载请附上博文链接！
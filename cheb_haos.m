% 切比雪夫I型滤波器设计
% 
% （1）得到滤波器最小滤波器阶数和截止频率，调用cheb1ord函数，其调用格式如下：
% 
%         [n,wn]=cheb1ord(Wp,Ws,Rp,Rs);Wp,Ws分别表示归一化通带截至频率和归一化阻带截至频率，Rp，Rs分别表示通带和阻带的波纹系数
% 
% （2）计算滤波器的系数，调用cheby1函数，调用格式如下：
% 
%       [b,a]=cheby1（n,Rp,Wn，’ftype’）;
% 
%       n表示滤波器阶数，Wn归一化截至频率，Rp表示通带波纹系数，ftype:滤波器类型，b，a表示滤波器系数
% 
% 示例：采样频率为1000HZ，通带内（0-30HZ）波动不超过2dB,在120HZ处至少衰减50dB，设计切比雪夫I型滤波器
clc;clear
Fs=1000;

      Wp=30/Fs;

      Ws=120/Fs;

      Rp=2;

      Rs=50;

      [n,Wn]=cheb1ord(Wp,Ws,Rp,Rs);

      [b,a]=cheby1(n,Rp,Wn);

      [h,f]=freqz(b,a,512,Fs);

      f=Fs*(0:length(f)-1)/length(f);

      subplot(2,1,1)

      plot(f(1:length(f)/2),20*log(abs(h(1:length(f)/2))));

      title('切比雪夫I型低通滤波器');

      xlabel('频率/HZ');

      ylabel('幅值/dB');

      grid on;

      subplot(2,1,2)

      plot(f(1:length(f)/2),phase(h(1:length(f)/2))*180/pi);

      xlabel('频率/HZ');

      ylabel('相位/度');

      grid on;
% 	  切比雪夫II型滤波器设计
% 
% （1）得到滤波器最小滤波器阶数和截止频率，调用cheb2ord函数，其调用格式如下：
% 
%         [n,wn]=cheb2ord(Wp,Ws,Rp,Rs);Wp,Ws分别表示归一化通带截至频率和归一化阻带截至频率，Rp，Rs分别表示通带和阻带的波纹系数
% 
% （2）计算滤波器的系数，调用cheby1函数，调用格式如下：
% 
%       [b,a]=cheby2（n,Rs,Wn，’ftype’）;
% 
%       n表示滤波器阶数，Wn归一化截至频率，Rs表示阻带波纹系数，ftype:滤波器类型，b，a表示滤波器系数
% 
% 示例：采样频率为1000HZ，通带内（0-30HZ）波动不超过2dB,在120HZ处至少衰减50dB，设计切比雪夫II型滤波器
	  Fs=1000;

      Wp=30/Fs;

      Ws=120/Fs;

      Rp=2;

      Rs=50;

      [n,Wn]=cheb2ord(Wp,Ws,Rp,Rs);

      [b,a]=cheby2(n,Rs,Wn);

      [h,f]=freqz(b,a,512,Fs);

      f=Fs*(0:length(f)-1)/length(f);

      subplot(2,1,1)

      plot(f(1:length(f)/2),20*log(abs(h(1:length(f)/2))));

      title('切比雪夫II型低通滤波器');

      xlabel('频率/HZ');

      ylabel('幅值/dB');

      grid on;

      subplot(2,1,2)

      plot(f(1:length(f)/2),phase(h(1:length(f)/2))*180/pi);

     xlabel('频率/HZ');

     ylabel('相位/度');

     grid on;
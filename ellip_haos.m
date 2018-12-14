%  椭圆滤波器设计
% 
%    （1）得到滤波器最小滤波器阶数和截止频率，调用ellipord函数，其调用格式如下：
% 
%         [n,wn]=ellipord(Wp,Ws,Rp,Rs);Wp,Ws分别表示归一化通带截至频率和归一化阻带截至频率，Rp，Rs分别表示通带和阻带的波纹系数
% 
%    （2）计算滤波器的系数，调用cheby1函数，调用格式如下：
% 
%       [b,a]=ellip（n,Rp,Rs,Wn，’ftype’）;
% 
%      n表示滤波器阶数，Wn归一化截至频率，ftype:滤波器类型，b，a表示滤波器系数
% 
% 示例：采样频率为1000HZ，通带内（0-30HZ）波动不超过2dB,在120HZ处至少衰减50dB，设计椭圆滤波器
clc;clear
Fs=1000;

      Wp=30/Fs;

      Ws=120/Fs;

      Rp=2;

      Rs=50;

      [n,Wn]=ellipord(Wp,Ws,Rp,Rs);

      [b,a]=ellip(n,Rp,Rs,Wn);
      zplane(b,a);

      [h,f]=freqz(b,a,512,Fs);

      f=Fs*(0:length(f)-1)/length(f);

     subplot(2,1,1)

      plot(f(1:length(f)/2),20*log(abs(h(1:length(f)/2))));

      title('椭圆低通滤波器');

      xlabel('频率/HZ');

      ylabel('幅值/dB');

      grid on;

      subplot(2,1,2)

      plot(f(1:length(f)/2),phase(h(1:length(f)/2))*180/pi);

      xlabel('频率/HZ');

      ylabel('相位/度');

      grid on;
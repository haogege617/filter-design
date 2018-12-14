
% 巴特沃斯滤波器设计
% 巴特沃斯滤波器可以用于设计低通、高通、带通、带阻滤波器，其设计方法如下：
% 
%    （1）得到滤波器最小滤波器阶数和截止频率，调用buttord函数，其调用格式如下：
% 
%         [n,wn]=buttord(Wp,Ws,Rp,Rs);Wp,Ws分别表示归一化通带截至频率和归一化阻带截至频率，Rp，Rs分别表示通带和阻带的波纹系数
% 
%        巴特沃斯各种滤波器设计对应的Wp，Ws的对应的规则不同
% 
%        高通滤波器：Wp，Ws都是一元矢量，Wp>Ws
% 
%        低通滤波器：Wp，Ws都是一元矢量，Wp<Ws
% 
%        带通滤波器：Wp，Ws都是二元矢量，Wp<Ws
% 
%        带阻滤波器：Wp，Ws都是二元矢量，Wp>Ws
% 
%   （2）计算滤波器的系数，调用butter函数，调用格式如下：
% 
%       [z,p,k]=butterap（n）;
% 
%       [b,a]=butter（n，Wn，’ftype’）;
% 
%       n表示滤波器阶数，Wn归一化截至频率，ftype:滤波器类型，z：零点，p：极点，k：增益，b，a表示滤波器系数
% 
% 示例：对含有20HZ和50HZ频率叠加谐波信号的低通滤波，使其只含有20HZ频率Fs=250;
clc;clear
      Fs = 1000;
    
      T=1/Fs;

      L=500;

      N=0:L-1;

      t=T*N;

      f1=20;

      f2=50;

      x=sin(2*pi*f1*t)+sin(2*pi*f2*t);

      subplot(2,3,1)

      plot(t,x,'r')

      title('鍘熷淇″彿');

      xlabel('t/s');

      title('原始信号');

      xlabel('t/s');

      ylabel('幅值');

      Ndata=2^nextpow2(L);

      y=fft(x,Ndata)*2/Ndata;

      f=Fs*(0:Ndata-1)/Ndata;

      subplot(2,3,2)

      plot(f(1:Ndata/2),abs(y(1:Ndata/2)),'b');

      title('原始信号频谱图');

      xlabel('频率/HZ');

      ylabel('幅值');

 %%巴特沃斯低通滤波器设计%%

      Wp=30/Fs;

      Ws=100/Fs;

      Rs=50;

      Rp=1;

      [n,Wn]=buttord(Wp,Ws,Rp,Rs);

      [b,a]=butter(n,Wn);

      [h,f]=freqz(b,a);

      f=Fs*(0:length(f)-1)/length(f);%%频率转化%%

      subplot(2,3,3)

      plot(f(1:length(f)/2),abs(h(1:length(f)/2)));

      title('巴特沃斯滤波器设计')

      xlabel('频率/HZ');

      ylabel('幅值');

%%对原始信号进行滤波%%

      x2=filter(b,a,x);

      subplot(2,3,4)

      plot(t,x2);

      title('滤波后信号');

      y2=fft(x2,Ndata)*2/Ndata;

      f=Fs*(0:Ndata-1)/Ndata;

      xlabel('t/s');

      ylabel('幅值');

      subplot(2,3,5)

      plot(f(1:Ndata/2),abs(y2(1:Ndata/2)))

      title('滤波后信号频谱图');

      xlabel('频率/HZ');

      ylabel('幅值');
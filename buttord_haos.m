
% ������˹�˲������
% ������˹�˲�������������Ƶ�ͨ����ͨ����ͨ�������˲���������Ʒ������£�
% 
%    ��1���õ��˲�����С�˲��������ͽ�ֹƵ�ʣ�����buttord����������ø�ʽ���£�
% 
%         [n,wn]=buttord(Wp,Ws,Rp,Rs);Wp,Ws�ֱ��ʾ��һ��ͨ������Ƶ�ʺ͹�һ���������Ƶ�ʣ�Rp��Rs�ֱ��ʾͨ��������Ĳ���ϵ��
% 
%        ������˹�����˲�����ƶ�Ӧ��Wp��Ws�Ķ�Ӧ�Ĺ���ͬ
% 
%        ��ͨ�˲�����Wp��Ws����һԪʸ����Wp>Ws
% 
%        ��ͨ�˲�����Wp��Ws����һԪʸ����Wp<Ws
% 
%        ��ͨ�˲�����Wp��Ws���Ƕ�Ԫʸ����Wp<Ws
% 
%        �����˲�����Wp��Ws���Ƕ�Ԫʸ����Wp>Ws
% 
%   ��2�������˲�����ϵ��������butter���������ø�ʽ���£�
% 
%       [z,p,k]=butterap��n��;
% 
%       [b,a]=butter��n��Wn����ftype����;
% 
%       n��ʾ�˲���������Wn��һ������Ƶ�ʣ�ftype:�˲������ͣ�z����㣬p�����㣬k�����棬b��a��ʾ�˲���ϵ��
% 
% ʾ�����Ժ���20HZ��50HZƵ�ʵ���г���źŵĵ�ͨ�˲���ʹ��ֻ����20HZƵ��Fs=250;
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

      title('原始信号');

      xlabel('t/s');

      title('ԭʼ�ź�');

      xlabel('t/s');

      ylabel('��ֵ');

      Ndata=2^nextpow2(L);

      y=fft(x,Ndata)*2/Ndata;

      f=Fs*(0:Ndata-1)/Ndata;

      subplot(2,3,2)

      plot(f(1:Ndata/2),abs(y(1:Ndata/2)),'b');

      title('ԭʼ�ź�Ƶ��ͼ');

      xlabel('Ƶ��/HZ');

      ylabel('��ֵ');

 %%������˹��ͨ�˲������%%

      Wp=30/Fs;

      Ws=100/Fs;

      Rs=50;

      Rp=1;

      [n,Wn]=buttord(Wp,Ws,Rp,Rs);

      [b,a]=butter(n,Wn);

      [h,f]=freqz(b,a);

      f=Fs*(0:length(f)-1)/length(f);%%Ƶ��ת��%%

      subplot(2,3,3)

      plot(f(1:length(f)/2),abs(h(1:length(f)/2)));

      title('������˹�˲������')

      xlabel('Ƶ��/HZ');

      ylabel('��ֵ');

%%��ԭʼ�źŽ����˲�%%

      x2=filter(b,a,x);

      subplot(2,3,4)

      plot(t,x2);

      title('�˲����ź�');

      y2=fft(x2,Ndata)*2/Ndata;

      f=Fs*(0:Ndata-1)/Ndata;

      xlabel('t/s');

      ylabel('��ֵ');

      subplot(2,3,5)

      plot(f(1:Ndata/2),abs(y2(1:Ndata/2)))

      title('�˲����ź�Ƶ��ͼ');

      xlabel('Ƶ��/HZ');

      ylabel('��ֵ');
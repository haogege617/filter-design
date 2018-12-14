% �б�ѩ��I���˲������
% 
% ��1���õ��˲�����С�˲��������ͽ�ֹƵ�ʣ�����cheb1ord����������ø�ʽ���£�
% 
%         [n,wn]=cheb1ord(Wp,Ws,Rp,Rs);Wp,Ws�ֱ��ʾ��һ��ͨ������Ƶ�ʺ͹�һ���������Ƶ�ʣ�Rp��Rs�ֱ��ʾͨ��������Ĳ���ϵ��
% 
% ��2�������˲�����ϵ��������cheby1���������ø�ʽ���£�
% 
%       [b,a]=cheby1��n,Rp,Wn����ftype����;
% 
%       n��ʾ�˲���������Wn��һ������Ƶ�ʣ�Rp��ʾͨ������ϵ����ftype:�˲������ͣ�b��a��ʾ�˲���ϵ��
% 
% ʾ��������Ƶ��Ϊ1000HZ��ͨ���ڣ�0-30HZ������������2dB,��120HZ������˥��50dB������б�ѩ��I���˲���
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

      title('�б�ѩ��I�͵�ͨ�˲���');

      xlabel('Ƶ��/HZ');

      ylabel('��ֵ/dB');

      grid on;

      subplot(2,1,2)

      plot(f(1:length(f)/2),phase(h(1:length(f)/2))*180/pi);

      xlabel('Ƶ��/HZ');

      ylabel('��λ/��');

      grid on;
% 	  �б�ѩ��II���˲������
% 
% ��1���õ��˲�����С�˲��������ͽ�ֹƵ�ʣ�����cheb2ord����������ø�ʽ���£�
% 
%         [n,wn]=cheb2ord(Wp,Ws,Rp,Rs);Wp,Ws�ֱ��ʾ��һ��ͨ������Ƶ�ʺ͹�һ���������Ƶ�ʣ�Rp��Rs�ֱ��ʾͨ��������Ĳ���ϵ��
% 
% ��2�������˲�����ϵ��������cheby1���������ø�ʽ���£�
% 
%       [b,a]=cheby2��n,Rs,Wn����ftype����;
% 
%       n��ʾ�˲���������Wn��һ������Ƶ�ʣ�Rs��ʾ�������ϵ����ftype:�˲������ͣ�b��a��ʾ�˲���ϵ��
% 
% ʾ��������Ƶ��Ϊ1000HZ��ͨ���ڣ�0-30HZ������������2dB,��120HZ������˥��50dB������б�ѩ��II���˲���
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

      title('�б�ѩ��II�͵�ͨ�˲���');

      xlabel('Ƶ��/HZ');

      ylabel('��ֵ/dB');

      grid on;

      subplot(2,1,2)

      plot(f(1:length(f)/2),phase(h(1:length(f)/2))*180/pi);

     xlabel('Ƶ��/HZ');

     ylabel('��λ/��');

     grid on;
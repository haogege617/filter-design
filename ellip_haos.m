%  ��Բ�˲������
% 
%    ��1���õ��˲�����С�˲��������ͽ�ֹƵ�ʣ�����ellipord����������ø�ʽ���£�
% 
%         [n,wn]=ellipord(Wp,Ws,Rp,Rs);Wp,Ws�ֱ��ʾ��һ��ͨ������Ƶ�ʺ͹�һ���������Ƶ�ʣ�Rp��Rs�ֱ��ʾͨ��������Ĳ���ϵ��
% 
%    ��2�������˲�����ϵ��������cheby1���������ø�ʽ���£�
% 
%       [b,a]=ellip��n,Rp,Rs,Wn����ftype����;
% 
%      n��ʾ�˲���������Wn��һ������Ƶ�ʣ�ftype:�˲������ͣ�b��a��ʾ�˲���ϵ��
% 
% ʾ��������Ƶ��Ϊ1000HZ��ͨ���ڣ�0-30HZ������������2dB,��120HZ������˥��50dB�������Բ�˲���
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

      title('��Բ��ͨ�˲���');

      xlabel('Ƶ��/HZ');

      ylabel('��ֵ/dB');

      grid on;

      subplot(2,1,2)

      plot(f(1:length(f)/2),phase(h(1:length(f)/2))*180/pi);

      xlabel('Ƶ��/HZ');

      ylabel('��λ/��');

      grid on;
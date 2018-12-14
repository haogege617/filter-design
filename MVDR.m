% ����ź�Ƶ���� 

 
clear
clc 
% f0 = 1.3*10^9;                  % �ź�����Ƶ�� 
% fr=1.3*10^9;  
% B = 50*10^6;                    % �źŴ��� 
f0 = 2.2*10^3;                  % �ź�����Ƶ�� 
fr=2.2*10^3;  
B = 3.6*10^3; 
fl = f0-B/2;                    % �ź���ʼƵ�� 
fh = f0+B/2; 
Tr = 50*10^(-6);                % �������� 
T = 10*10^(-6);                 % �źų���ʱ�䣬Ҫ����ڿ׾���Խʱ�� 
% Tr = 5;                % �������� 
% T = 1;                 % �źų���ʱ�䣬Ҫ����ڿ׾���Խʱ�� 
fs = 100*10^6;                  % ����Ƶ�� 
snr = [40;0];                   % ����� 
w0 = 40/180*pi;                  % ָ��� 
M =8;                          % ��Ԫ��ΪM 
Kr=1; 
Ks = 2;                         % �ź���Ŀ 
seta =[0/180*pi,40/180*pi];     % �����źŷ��� 
Nm = 6;                        % פ�����ڸ��� 
Nr = Tr*fs;                     % �������� 
N = T*fs; 
J = 1000;                       % FFT�ĵ��� 
NN = Nm*Nr/J;                   % Ƶ�������  Ϊô�� 
c= 340;                     % ���� 
d = 0.5*c/f0;                   % ��Ԫ��� 
x = zeros(M,1);                 % ����ʸ�� 
R = zeros(M,M);                 % ��������Э������� 
 
tic 
% �������н��յĿ������ 
x2 = LFMsource(M,f0,fl,B,fs,T,seta,snr,2); % �����źŵ�������ΪT������ʱ�䲻�� 
 
% ���������ź� 
x1 = LFMsource(M,f0,fl,B,fs,Tr,seta,snr,1); 
% u = 1:Nr; 
% for k=1:Kr 
% for n=1:Nr 
%     fai(k,n) = rand; 
%  s(k,n) = exp(i*2*pi*(fr*u(n)/fs+fai(k,n)));       % Դ�ź� 
% end 
% end 
% for k=1:Kr 
% for m=1:M 
%         A(m,k)=exp(-i*2*pi*d*fr*(m-1)*sin(seta(k))/c); 
%     end 
% end 
% % ���н����ź� 
% x1 = 10.^(snr(1)/20).*A*s;  
% ���н��յĺ��ź� 
t1 = 1000;                                 % ����ѡ��������źų���λ�� 
x1(:,(t1+1):(t1+N)) = x1(:,(t1+1):(t1+N)) + x2; 
for nm=1:Nm 
    x(:,((nm-1)*Nr+1):(nm*Nr)) = x1; 
end 
noise = randn(M,Nm*Nr)+i*randn(M,Nm*Nr);   % ���� 
x = x + noise; 
 
% ʱ���źű任ΪƵ���ź� 
fft_8_1; 
toc 
tic 
% ���췽��ʸ�� 
w = -90*pi/180:0.01:90*pi/180; 
WW = length(w); 
P = zeros(1,WW); 
Wav=zeros(M,1); 
% ���㲻ͬ��Ƶ��ļ�Ȩ����                                                               
F = fl:B/(J/2-1):fh; 
for k = 1:250                      %Ϊô��250�� 
    for m = 1:M                     % ������Ƶ���Ӧ��Э������� 
        for n = 1:NN 
            xf(n,m) = X(k,n,m); 
        end 
    end 
    R = xf.'*conj(xf)./NN;%   xf.'?? 
    Ri = inv(R); 
    for m=1:M 
        a0(m,1) = exp(-i*2*pi*d*F(k+250)*(m-1)*sin(w0)/c);% ָ������  
    end  
    W = Ri*a0/(a0'*Ri*a0);                                % ��Ȩ���� 
    for m=1:M 
        a(m,:) = exp(-i*2*pi*d*F(k+250)*(m-1)*sin(w)/c);  % �������������ڷ������� 
    end 
    Wav=Wav+W; 
    f((k+250),:) = abs(W'*a).^2; 
    f((k+250),:) =f((k+250),:)./max(f((k+250),:)); 
end 
 
for k = 1:250 
    for m = 1:M                     % ������Ƶ���Ӧ��Э������� 
        for n = 1:NN 
            xf(n,m) = X((k+750),n,m); 
        end 
    end 
    R = xf.'*conj(xf)./NN; 
    Ri = inv(R); 
    for m=1:M 
        a0(m,1) = exp(-i*2*pi*d*F(k)*(m-1)*sin(w0)/c);% ָ������  
    end  
    W = Ri*a0/(a0'*Ri*a0);                            % ��Ȩ���� 
    for m=1:M 
        a(m,:) = exp(-i*2*pi*d*F(k)*(m-1)*sin(w)/c);  % �������������ڷ������� 
    end 
    Wav=Wav+W; 
    f(k,:) = abs(W'*a).^2; 
    f(k,:)=f(k,:)./max(f(k,:)); 
end 
Wav=Wav./500; 
for m=1:M 
        a(m,:) = exp(-i*2*pi*d*f0*(m-1)*sin(w)/c);  % �������������ڷ������� 
end 
fav=abs(Wav'*a).^2; 
fav=fav./max(fav); 
 f1 = f(1,:)./max(f(1,:)); 
  f2 = f(500,:)./max(f(500,:)); 
   f3 = f(251,:)./max(f(251,:)); 
% figure; 
% plot(w*180/pi,10*log10(f1)); 
% % title('pattern of linear array(bearing45,interfere20),B=4M,f0=40M,���۽�,�źŲ����(0,40)dB'); 
% xlabel('\theta/deg');  
% ylabel('��������/dB'); 
% grid on 
% legend('���Ƶ��')  
% hold on 
%  
% figure; 
% plot(w*180/pi,10*log10(f2)); 
% xlabel('\theta/deg');  
% ylabel('��������/dB'); 
% grid on 
% legend('���Ƶ��')  
% hold on 
%  
% figure; 
% plot(w*180/pi,10*log10(f3)); 
% xlabel('\theta/deg');  
% ylabel('��������/dB'); 
% grid on 
% legend('����Ƶ��')  
% hold on 
%  
figure; 
plot(w*180/pi,10*log10(f1),w*180/pi,10*log10(f2),w*180/pi,10*log10(f3)); 
xlabel('\theta/deg');  
ylabel('��������/dB'); 
title('��ͬƵ���²����γ�')
grid on 
legend('���Ƶ��','���Ƶ��','����Ƶ��')  
hold on 
%  
% figure; 
% plot(w*180/pi,10*log10(fav)); 
% % title('pattern of linear array(bearing45,interfere20),B=4M,f0=40M,���۽�,�źŲ����(0,40)dB'); 
% xlabel('\theta/deg');  
% ylabel('��������/dB'); 
% grid on 
% legend('ISM�ο�Ƶ��')  
% hold on 
 
% figure; 
% plot(w*180/pi,10*log10(f3),w*180/pi,10*log10(fav)); 
% xlabel('\theta/deg');  
% ylabel('��������/dB'); 
% grid on 
% legend('����ƽ��������Ƶ��','ƽ���������Ƶ��')  
% hold on 
 
figure;  % ��ά����ͼ
[XX,Y] = meshgrid(w*180/pi,F); 
meshc(XX,Y,10*log10(f/max(max(f)))) 
title('��������γ�'); 
xlabel('\theta/deg');  
ylabel('Ƶ��/Hz'); 
zlabel('��������/dB')
toc

% ���ߣ�Ҷҹ�ϸ� 
% ��Դ��CSDN 
% ԭ�ģ�https://blog.csdn.net/YJJat1989/article/details/22174925 
% ��Ȩ����������Ϊ����ԭ�����£�ת���븽�ϲ������ӣ�
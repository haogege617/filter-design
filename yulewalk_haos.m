% 直接法IIR滤波器设计
% 直接法滤波器设计是直接针对滤波器频率响应进行设计，实现直接法滤波器设计函数为yulewalk，其调用格式如下：
% [b,a]=yulewalk(n,f,m);
% 其中，f为归一化频率点数，m为频率点处响应，两者长度一致
% 示例：设计一个5阶低通滤波器，并将其频率响应函数与设计目标响应做对比
clc;clear
    f=[0 0.2 0.4 0.6 0.8 1];
    m=[1 1 1 1 0 0];
    [b,a]=yulewalk(5,f,m);
    r0=roots(b);
    r1=roots(a);
    zplane(b,a);
    [h,w]=freqz(b,a,256);
    plot(f,m,'r',w/pi,abs(h),'b');
    legend('设计目标响应','滤波器响应');
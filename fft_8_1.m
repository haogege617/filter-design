% �Կ���������ݽ���FFT�任����һ���ӳ���һ�㱻�����������
% 2007.1.29
 
xx = zeros(J,NN,M); % x�ĵ���ά��M����Ԫ����һά��Ҫ����FFT�ĵ������ڶ�ά��Ҫ����J��FFT�Ĵ���
for n=1:NN
    for m=1:M
        xx(:,n,m) = x(m,(n-1)*J+1:(n-1)*J+J);
    end
end
X = fft(xx,J,1);    % FFT�任��� ��һά����Ƶ��ĸ���  
% figure
% plot((0:fs/J:fs-fs/J),abs(X(1:J,1,1)))


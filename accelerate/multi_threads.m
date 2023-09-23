Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
s = S + 2*randn(size(t));

tic;
for a = 1 : 200000
    s = fft(s);
end
toc

maxNumCompThreads(2*maxNumCompThreads);  % 两倍物理核数

tic;
for a = 1 : 200000
    s = fft(s);
end
toc

maxNumCompThreads('automatic');  % 设置为物理核数

tic;
for a = 1 : 200000
    s = fft(s);
end
toc


%% 自动启动软件
clc
clear
close all

%% 通过识别并点击来启动微信
% 通过将符号 & 附加到 WeChat.exe 命令，打开微信并立即将退出状态返回至 MATLAB
system('C:\Program Files (x86)\Tencent\WeChat\WeChat.exe &');
% !C:\Program Files (x86)\Tencent\WeChat\WeChat.exe &
disp('Launch WeChat success!');
pause(3);  % 等待微信程序显示在屏幕上


%% 获取屏幕截图
import java.awt.Robot;
robot = Robot; %Creating a Robot object

import java.awt.Rectangle;
rect = Rectangle; %Creating a Rectangle object 

import java.awt.Toolkit.getDefaultToolkit;
tool = getDefaultToolkit;  % 创建默认工具对象

screenDim = tool.getScreenSize; % 得到屏幕大小

width = screenDim.width; % 屏幕宽度
height = screenDim.height; % 屏幕高度

rect.setRect(0, 0, width, height);  % 设置屏幕截图的大小

screen = robot.createScreenCapture(rect); % 截屏

% 转换为8比特数据
pixelsData = reshape(typecast(screen.getData.getDataStorage, 'uint8'), 4, width, height);

img_data = zeros([height,width,3],'uint8');  % 创建图像变量
img_data(:,:,1) = transpose(reshape(pixelsData(3, :, :), width, height));
img_data(:,:,2) = transpose(reshape(pixelsData(2, :, :), width, height));
img_data(:,:,3) = transpose(reshape(pixelsData(1, :, :), width, height));
%Save image data B-G-R Plane wise
% imshow(img_data);  pause(3);
% close all;


%% 定位"进入微信"按钮的位置
% imtool -> 文件 -> 从工作区导入 -> 鼠标落的位置左下角显示坐标和RGB信息
% [7 193 96]
% (通过色彩分割器（colorThresholder）获得按钮的掩膜：点击左上角的点云按钮并拖动一个闭合区域)
% 所有满足像素值的坐标取平均值
obj_pixel_cnt = 0;
w_acc = 0;  h_acc = 0;
for w = 1 : size(img_data, 2)
    for h = 1 : size(img_data, 1)
        if img_data(h, w, 1) == 7 && img_data(h, w, 2) == 193 && img_data(h, w, 3) == 96
            obj_pixel_cnt = obj_pixel_cnt + 1;
            w_acc = w_acc + w;
            h_acc = h_acc + h;
        end
    end
end
button_w = w_acc / obj_pixel_cnt;
button_h = h_acc / obj_pixel_cnt;

% 将鼠标移动到"进入微信"按钮的中心位置
robot.mouseMove(button_w, button_h);

% 点击鼠标左键
robot.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);
robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);







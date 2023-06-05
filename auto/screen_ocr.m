%% 使用飞桨进行OCR
% 返回当前屏幕识别的结果
function results = screen_ocr()
import java.awt.Robot;
vks = Robot; %Creating a Robot object

import java.awt.Rectangle;
rect = Rectangle; %Creating a Rectangle object 

import java.awt.Toolkit.getDefaultToolkit;
tool = getDefaultToolkit;  % 创建默认工具对象

screenDim = tool.getScreenSize; % 得到屏幕大小

width = screenDim.width; % 屏幕宽度
height = screenDim.height; % 屏幕高度

rect.setRect(0, 0, width, height);  % 设置屏幕截图的大小

screen = vks.createScreenCapture(rect); % 截屏

% 转换为8比特数据
pixelsData = reshape(typecast(screen.getData.getDataStorage, 'uint8'), 4, width, height);

imgData = zeros([height,width,3],'uint8');  % 创建图像变量
imgData(:,:,1) = transpose(reshape(pixelsData(3, :, :), width, height));
imgData(:,:,2) = transpose(reshape(pixelsData(2, :, :), width, height));
imgData(:,:,3) = transpose(reshape(pixelsData(1, :, :), width, height));
%Save image data B-G-R Plane wise

% imshow(imgData) %Show the captured screenshot
% imwrite(imgData, 'ScreenCaptureMatlab.jpg'); %Save the captured screenshot
cap_path = fullfile(tempdir, 'ScreenCaptureMatlab.jpg');
imwrite(imgData, cap_path);

%% OCR
% 检测+方向分类器+识别全流程：
% 参考：https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.6/doc/doc_ch/quickstart.md
% python -m pip install paddlepaddle -i https://mirror.baidu.com/pypi/simple
% pip install "paddleocr>=2.0.1"
% --use_angle_cls true设置使用方向分类器识别180度旋转文字，
% --use_gpu false设置不使用GPU
% paddleocr --image_dir D:/dong/matlab/utils/OcrLiteOnnx-1.6.1/images/1.jpg --use_angle_cls true --use_gpu false

% 初始化环境
% 使用 python 获取文件传输助手中的消息
py_info = pyversion; % pyversion  % 查看python环境的信息
if isempty(py_info)
    pyversion(fullfile(matlabroot, 'python', 'python.exe'));
end

% [status, cmdout] = system(['paddleocr --image_dir ' cap_path ' --use_angle_cls true --use_gpu false']);

import py.screen_recognition.*


results = ocr(cap_path);
results = cell(results);

end
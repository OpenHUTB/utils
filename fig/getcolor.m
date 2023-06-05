% 获取鼠标所在位置的RGB值
% 微信截图也可以
% 参考：https://www.ilovematlab.cn/thread-608991-1-1.html
% https://ww2.mathworks.cn/matlabcentral/fileexchange/78212-get-rgb-color
function getcolor
global RGBColor
import java.awt.MouseInfo;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
mousepoint=MouseInfo.getPointerInfo().getLocation();
robot=Robot();
% 获取像素点颜色
tempColor=robot.getPixelColor(mousepoint.x, mousepoint.y);
% 获取RGB值
RGBColor=[tempColor.getRed(),tempColor.getGreen(),tempColor.getBlue()];
end
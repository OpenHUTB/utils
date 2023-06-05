% https://undocumentedmatlab.com/articles/gui-automation-robot
import java.awt.Robot;
import java.awt.event.*;

robot = java.awt.Robot;


import java.awt.Toolkit.getDefaultToolkit;
tool = getDefaultToolkit;  % 创建默认工具对象

screenDim = tool.getScreenSize; % 得到屏幕大小

width = screenDim.width; % 屏幕宽度
height = screenDim.height; % 屏幕高度
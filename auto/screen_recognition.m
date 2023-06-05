% 屏幕识别
clc
clear
close all

import java.awt.Robot;
import java.awt.event.*;

robot = java.awt.Robot;



obj_text = '2022';
[status, pos] = locate_text(obj_text);
pos = cell2mat(pos);

obj_pos_w = mean([pos(1), pos(3), pos(5), pos(7)]);
obj_pos_h = mean([pos(2), pos(4), pos(6), pos(8)]);

robot.mouseMove(obj_pos_w, obj_pos_h);
robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);










% 湖南省高校师资培训避免看视频中断
% 参考：https://blog.csdn.net/u011389706/article/details/57399942

init_robot

wait_time = 30;
while true
    pause(wait_time);
    robot.mouseMove(20, 20);
    pause(wait_time);
    robot.mouseMove(0.1*width, 0.65*height);
    pause(wait_time);
    robot.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);
    robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
end



%% Control mouse
% single press

% robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
% robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
% 
% % double press
% figure(gcf);
% drawnow;
% robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
% robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
% robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
% robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
% 
% %% Control Keyboard 
% robot.keyPress(java.awt.event.KeyEvent.VK_CONTROL);
% robot.keyPress(java.awt.event.KeyEvent.VK_P);



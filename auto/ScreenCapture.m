function outputImage=ScreenCapture(subRegion,outputFile)
% SCREENCAPTURE    
% 对指定区域subRegion（从屏幕左上角开始[x,y,w,h]）进行截图，保存到outputFile中
% 示例：ScreenCapture([10, 10, 300, 300], 'tmp.jpg')
% 参考：https://ww2.mathworks.cn/matlabcentral/fileexchange/36391-screen-capture
% 
% outputImage=ScreenCapture(subRegion,outputFile)
% 
% Both input arguments are optional.
% If the output argument is used, it will spit out a Matlab-formatted image matrix
% If you want to write a file out, but don't want to define a subregion, pass in an empty vector [] for subregion
%
% SUBREGION has the following format:
%  x=subRegion(1);
%  y=subRegion(2);
%  w=subRegion(3);
%  h=subRegion(4);
% OUTPUTFILE is just a string pointing to a file to write out.
%
% --Chethan Pandarinath, 2012-04-25
%
% Based on this screencapture script by Saurabh Kumar:
%    http://www.mathworks.com/matlabcentral/fileexchange/11363-screencapture
%
% Java image to Matlab image reference:
%    http://www.mathworks.com/support/solutions/en/data/1-2WPAYR/

    if exist('subRegion','var') & ~isempty(subRegion)
        x=subRegion(1);
        y=subRegion(2);
        w=subRegion(3);
        h=subRegion(4);
    end

    robo = java.awt.Robot;

    if ~exist('subRegion','var') | isempty(subRegion)
        t = java.awt.Toolkit.getDefaultToolkit();
        rectangle = java.awt.Rectangle(t.getScreenSize());
    else
        rectangle = java.awt.Rectangle(x,y,w,h);
    end
    image1 = robo.createScreenCapture(rectangle);
    
    if nargout
        h=image1.getHeight();
        w=image1.getWidth();
        data=image1.getData();
        pix=data.getPixels(0,0,w,h,[]);
        tmp=reshape(pix(:),3,w,h);
        for ii=1:3
            outputImage(:,:,ii)=squeeze(tmp(ii,:,:))';
        end
    end
    
    if exist('outputFile','var')
        filehandle = java.io.File(outputFile);
        javax.imageio.ImageIO.write(image1,'jpg',filehandle);
    end

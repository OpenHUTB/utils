% 对screen_ocr识别的结果进行展示

tic
results = screen_ocr();
toc

%% 

cap_path = fullfile(tempdir, 'ScreenCaptureMatlab.jpg');
cap_img = imread(cap_path);
imshow(cap_path);
positions = zeros(length(results), 2);
double_exp = '(-?\d+(\.\d*)?)|(-?\.\d+)';  % 匹配double值: https://www.mathworks.com/matlabcentral/answers/1770165-how-to-use-regex-to-obtain-double-values?s_tid=srchtitle
texts = cell(length(results), 1);
% text_exp = '^(.+\,';
for i = 1 : length(results)
    cur_res = string(results{i});
    match_str = regexp(cur_res(1), double_exp, 'match');
    positions(i, 1) = str2double(match_str(1));
    positions(i, 2) = str2double(match_str(2));
    split_1 = split(cur_res{2}, ',');
    text_str = split_1{1};
    texts{i} = text_str(3 : end-1);
end

cap_img = insertText(cap_img, positions, texts, ...
    FontSize=13, TextColor="red");
imshow(cap_img);
% cap_img = insertObjectAnnotation(cap_img, "rectangle");
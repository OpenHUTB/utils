%% 使用飞桨进行OCR
% 确定文本在屏幕中的位置
% pos的顺序为：
% p1, p2
% p4, p3
function [status, pos] = locate_text(obj_text)

results = screen_ocr();

for i = 1 : length(results)
    cur_res = cell(results{i});

    cur_bbox_cell = cell(cur_res{1});
    cur_bbox = cell(1, length(cur_bbox_cell));
    for j = 1 : length(cur_bbox_cell)
        cur_bbox{j} = double(cur_bbox_cell{j});
    end

    cur_text_conf_cell = cell(cur_res{2});
    cur_text_conf = cell(1, length(cur_text_conf_cell));
    for j = 1 : length(cur_text_conf_cell)
        cur_text_conf{j} = string(cur_text_conf_cell{j});
        if contains(cur_text_conf{j}, obj_text)
            status = 1;
            pos = cur_bbox;
        end
    end
end

is_debug = true;
if is_debug
    
end

end
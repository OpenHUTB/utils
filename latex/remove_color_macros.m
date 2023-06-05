%% 替换无效（暂时用notepad 正则表达式模式进行替换）
% 1. 将\textcolor{red}{sentence}替换成 {sentence}
% \\textcolor\{red\}([\s\S]*?)\}
% $1}

% 2. 将\color{red}{sentence}替换成 {sentence}
% \\color\{red\}([\s\S]*?)\}
% $1}

% 3. 将\color{red}123替换成 123
% \\color\{red\}
% 空白

%%
str = 'MOT approaches \textcolor{red}{only} use the \textcolor{red}{accessible} data \textcolor{red}{at} the current moment.';
% expression = '\\textcolor{red}';
str = fileread('ycviu-template-with-authorship.tex');

% ？表示懒惰模式，匹配到第一个"就结束了一次匹配。不会继续向后匹配。因为他懒惰嘛。
% expression = '\\textcolor{red}{(.*?)}';  % 嵌套的话有bug
% 匹配包括换行在内的所有字符（参考：https://www.williamlong.info/archives/5781.html）
% \\textcolor\{red\}([\s\S]*?)\}
% \\color\{red\}([\s\S]*?)\}

% 将\textcolor{red}{sentence}替换成 {sentence}
textcolor_expression = '\\textcolor\{red\}([\s\S]*?)\}';
replace = '$1}';
newStr = regexprep(str, textcolor_expression, replace);

% 将\color{red}{sentence}替换成 {sentence}
color_expression = '\\color\{red\}([\s\S]*?)\}';
replace = '$1}';
newStr = regexprep(newStr, color_expression, replace);

% 将\color{red}123替换成 123
raw_color_expression = '\\color\{red\}';
replace = '';
newStr = regexprep(newStr, raw_color_expression, replace);

%% 替换无效（暂时用notepad进行替换）
% '\\textcolor\{red\}([\s\S]*?)\}';
% '$1}'

% 将\color{red}{sentence}替换成 {sentence}
% '\\color\{red\}([\s\S]*?)\}';
% '$1}'

% '\\color\{red\}'


% fid=fopen('ycviu-template-with-authorship.tex', 'wt');
% fprintf(fid, '%s', newStr);
% fclose(fid);
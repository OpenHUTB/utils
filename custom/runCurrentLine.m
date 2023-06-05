% runCurrentLine
%% add comment for a script by press "Alt + 1"
% Home -> Favorites -> New Favorite -> 
% Label: runCurLine
% Code:  runCurrentLine
% select 'Add to quick access toolbar'
% and 'Show label on quick acces toolbar'.


evalin('caller', 'addpath(pwd)');  % TODO: solve 'underfine function' defined in m script

activeEditor = matlab.desktop.editor.getActive;

selectionPosition = activeEditor.Selection;
selectLineIdx = selectionPosition(1);
scriptContents = activeEditor.Text;
contentsCell = splitlines(scriptContents);
% clc;
disp(contentsCell{selectLineIdx})   % display the running code
eval(contentsCell{selectLineIdx});  % run the line at cursor

clear activeEditor contentsCell scriptContents selectionPosition selectLineIdx


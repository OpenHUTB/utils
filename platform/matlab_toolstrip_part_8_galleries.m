% 参考：https://undocumentedmatlab.com/articles/matlab-toolstrip-part-8-galleries
import matlab.ui.internal.toolstrip.*
popup = GalleryPopup('ShowSelection',true);
% Create gallery categories
cat1 = GalleryCategory('CATEGORY #1 SINGLE'); popup.add(cat1);
cat2 = GalleryCategory('CATEGORY #2 SINGLE'); popup.add(cat2);
cat3 = GalleryCategory('CATEGORY #3 SINGLE'); popup.add(cat3);
% Create a button-group to control item selectability
group = matlab.ui.internal.toolstrip.ButtonGroup;
% Add items to the gallery categories
fpath = [fullfile(matlabroot,'toolbox','matlab','toolstrip','web','image') filesep];  % icons path
item1 = ToggleGalleryItem('Biology', Icon([fpath 'biology_app_24.png']), group);
item1.Description = 'Select the Biology gizmo';
item1.ItemPushedFcn = @(x,y) ItemPushedCallback(x,y);
cat1.add(item1);
item2 = ToggleGalleryItem('Code Generation', Icon([fpath 'code_gen_app_24.png']), group);
cat1.add(item2);
item3 = ToggleGalleryItem('Control', Icon([fpath 'control_app_24.png']), group);
cat1.add(item3);
item4 = ToggleGalleryItem('Database', Icon([fpath 'database_app_24.png']), group);
cat1.add(item4);
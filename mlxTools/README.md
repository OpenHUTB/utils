# mlxTools.m
 Convert mlx files to m files and vice versa

 `mlx2m(method, rename, foldersWithSubFolder, foldersWithoutSubFolder)`

 `m2mlx(method, rename, foldersWithSubFolder, foldersWithoutSubFolder)`

## Arguments
  - method: can be `"all","all_exclude","specific","GUI_all","GUI_specific"`
  - folders (optional):
   - if method is `"all_exclude"`: pass the folder names that should be excluded
   - if method is `"specific"`: pass the folder names that should be included.
       - 3rd argument are the folders that their subfolders are considered
       - 4th argument are the folders that their subfolders are ignored.

  Folders specified can have a relative as well as absolute path.

## Example
 Choose the method, and run the function.
 ```matlab
 mlx2m("all", true);
 ```

 Pass a 2nd and 3rd input to include/exclude specific folders if you chose "all_exclude" or "specific"
 ```matlab
 mlx2m("specified", true, ["Functions"],[pwd]);
 mlx2m("specified", true, ["Functions"],[]);
 mlx2m("exclude", true, ["Functions"],[]);
 ```

# License
 This is written as part of my Master's thesis and it is licensed under Apache V2, so cite this paper if you use it:
 ```
 A. Yahyaabadi, P. Ferguson, ”An intelligent multi-vehicle drone testbed for space systems and remote sensing veriﬁcation,” in Canadian Aeronautics and Space Institute (CASI) ASTRO, Canada, 2019
 ```
 In case of changes, either make pull requests to this repository or state the changes.

function [dupNames, dupNdxs] = getDuplicates(aList)
    [uniqueList,~,uniqueNdx] = unique(aList);
    N = histc(uniqueNdx,1:numel(uniqueList));
    dupNames = uniqueList(N>1);
    dupNdxs = arrayfun(@(x) find(uniqueNdx==x), find(N>1), ...
        'UniformOutput',false);
end
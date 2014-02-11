function res = isForContainerInfo( inArg )
%ISFORCONTAINERINFO Summary of this function goes here
%   Detailed explanation goes here
res = false;

if ~iscell(inArg) % has to be cell
    return;
end

if isempty(inArg) || length(inArg) > 2 % has to have 1 or 2 elements
    return;
end

if ~(isa(inArg{1},'SeisDataContainer')) % first element has to be a data container
    return;
end

if length(inArg) == 2
    inds = inArg{2}; % extract the indicies vector
    if ~(isvector(inds) && ~isa(inds,'SeisDataContainer'))
        return;
    end
end

res = true; % if nothing fail, consider inArg as properly containing container usage info
return;
end


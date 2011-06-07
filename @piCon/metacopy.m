function y = metacopy(x,y)
%METACOPY   Function that copies metadata between data containers
%
%   y = metacopy(x,y) will copy the metadata of data container x into y and
%   return y.

if ~isa(y,'piCon')
    y.imdims    = x.imdims;
    y.perm      = x.perm;
    y.strict    = x.strict;
else
    y.imdims    = x.imdims;
    y.perm      = x.perm;
    y.strict    = x.strict;
    y.imcoddims = x.imcoddims;
    y.imcodpart = pSPOT.utils.defaultDistribution(size(y,y.imcoddims));
end
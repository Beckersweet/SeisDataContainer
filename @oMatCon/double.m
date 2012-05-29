function y = double(x)
%DOUBLE   Returns the data contained in the data container
%
%   DOUBLE(X) returns the double precision value for X
%
% ***Note that for now double gives the data itself but this will change
% later and will probably change the file precision
%

import SeisDataContainer.io.NativeBin.serial.*

imsize        = x.header.size;
x.header.size = size(x);
HeaderWrite(path(x.pathname),x.header);
y             = FileRead(path(x.pathname));
x.header.size = imsize;
HeaderWrite(path(x.pathname),x.header);

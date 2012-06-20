function y = double(x)
%DOUBLE   Returns the data contained in the data container
%
%   DOUBLE(X) returns the double precision value for X
%
% ***Note that for now double gives the data itself but this will change
% later and will probably change the file precision
%
imsize = x.header.size;
x.header.size = size(x);
SDCpckg.io.NativeBin.serial.HeaderWrite...
            (path(x.pathname),x.header);
y = SDCpckg.io.NativeBin.serial.FileRead(path(x.pathname));
x.header.size = imsize;
SDCpckg.io.NativeBin.serial.HeaderWrite...
            (path(x.pathname),x.header);

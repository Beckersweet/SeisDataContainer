function y = double(x)
%DOUBLE   Returns the data contained in the data container
%
%   DOUBLE(X) returns the double precision value for X
%
% ***Note that for now double gives the data itself but this will change
% later and will probably change the file precision
%
y = DataContainer.io.memmap.serial.FileRead(path(x.pathname));

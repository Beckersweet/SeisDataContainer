function y = double(x)
%DOUBLE     Returns the data contained in the data container
%
%   DOUBLE(X) returns the double precision value for X
y = DataContainer.io.memmap.serial.FileRead(x.pathname);
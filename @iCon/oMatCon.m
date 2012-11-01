function y = oMatCon(x)
%OMATCON oMatCon wrapper for iCon
%   y = oMatCon(x) wraps iCon x and returns an oMatCon while conserving
%   header metadata

td         = ConDir();
header     = x.header;
oldsize    = size(x);
x          = reshape(x,header.size);
SDCpckg.io.NativeBin.serial.FileWrite(path(td),double(x),header);
y          = oMatCon.load(td);
y          = reshape(y,oldsize);
y.pathname = td;
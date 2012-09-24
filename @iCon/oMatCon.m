function y = oMatCon(x)
%OMATCON oMatCon wrapper for iCon
%   y = oMatCon(x) wraps iCon x and returns an oMatCon while conserving

td         = ConDir();
header     = x.header;
SDCpckg.io.NativeBin.serial.FileWrite(path(td),double(x),header);
y          = oMatCon.load(td);
y.pathname = td;
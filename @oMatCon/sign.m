function y = sign(a)
%SIGN   Returns an oMatCon that contains the signs of the input oMatCon
%
td = ConDir();
SDCpckg.io.NativeBin.serial.FileSign(path(a.pathname),path(td));
y = oMatCon.load(td);
end

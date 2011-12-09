function y = sign(a)
%FILESIGN Finds the sign of the input oMatCon
%
td = ConDir();
DataContainer.io.memmap.serial.FileSign(path(a.pathname),path(td));
y = oMatCon.load(td);
end

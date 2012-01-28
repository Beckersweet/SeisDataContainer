function y = real(a)
%REAL Gives the real part of the input oMatCon
%
if(~isa(a,'oMatCon'))
    error('Input parameter should be data container')
end
td = ConDir();
SeisDataContainer.io.NativeBin.serial.FileReal(path(a.pathname),path(td));    
y = oMatCon.load(td);
end

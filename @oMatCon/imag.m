function y = imag(x)
%IMAG   Gives the imaginary part of oMatCon
%

if(~isa(x,'oMatCon'))
    error('Input parameter should be data container')
end
td = ConDir();
SeisDataContainer.io.NativeBin.serial.FileImag(path(x.pathname),path(td));    
y = oMatCon.load(td);
y.exsize = x.exsize;
y.perm   = x.perm;
y.strict = x.strict;
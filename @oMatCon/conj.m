function y = conj(x)
%CONJ   Complex conjugate
%
%   conj(A) Creates a new oMatCon which is the complex conjugate of input
%   oMatCon a
%
%   A  - Input oMatCon
%

aa       = path(x.pathname);
td       = ConDir();    
SeisDataContainer.io.NativeBin.serial.FileConj(aa,path(td));
y        = oMatCon.load(td);
y.exsize = x.exsize;
y.perm   = x.perm;
y.strict = x.strict;
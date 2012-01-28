function y = conj(a)
%CONJ   Complex conjugate
%
%   conj(A) Creates a new oMatCon which is the complex conjugate of input
%   oMatCon a
%
%   A  - Input oMatCon
%
aa = path(a.pathname);
td = ConDir();    
SeisDataContainer.io.NativeBin.serial.FileConj(aa,path(td));
y  = oMatCon.load(td);
end

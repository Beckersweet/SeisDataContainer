function y = conj(a)
%CONJ
%
%   conj(A) Creates a new oMatCon which is the complex conjugate of input
%   oMatCon a
%
%   A  - Input oMatCon
%
aa = path(a.pathname);
td = ConDir();    
DataContainer.io.memmap.serial.FileConj(aa,path(td));
y  = oMatCon.load(td);
end
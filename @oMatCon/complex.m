function y = complex(a,b)
%POWER   Construct complex result from real and imaginary parts. If b is
%complex, the result will be an oMatCon with real part of a and complex
%part of b
%
aa=a;
bb=b;
if(isa(a,'oMatCon'))
    aa = path(a.pathname);
end
if(isa(b,'oMatCon'))
    bb = path(b.pathname);
end
td = ConDir();    
SDCpckg.io.NativeBin.serial.FileComplex...
    (aa,bb,path(td));
y  = oMatCon.load(td);
end

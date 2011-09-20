function y = uminus(A)
%UMINUS 
%-  Unary minus.
%   -A negates the elements of A.

    if(isa(A,'oMatCon'))
        A = A.dirname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileMtimes...
        (-1,A,td);
    y  = oMatCon.load(td);
end


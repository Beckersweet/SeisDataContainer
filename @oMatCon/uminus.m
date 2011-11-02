function y = uminus(A)
%UMINUS 
%-  Unary minus.
%   -A negates the elements of A.

    if(isa(A,'oMatCon'))
        A = A.pathname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileTimes...
        (-1,A,td);
    y  = oMatCon.load(td);
end


function x = randn(varargin)
%OMATCON.RANDN  Ones array.
%
%   oMatCon.randn(N) is an N-by-N matrix containing pseudorandom.
%
%   oMatCon.randn(M,N) is an M-by-N matrix of pseudorandom.
%
%   oMatCon.randn(M,N,P,...) is an M-by-N-by-P-by-... array of pseudorandom.
%
%   oMatCon.randn(SIZE(A)) is the same size as A and all pseudorandom.
%
%   oMatCon.randn(M,N,...,PRECISION) is an M-by-N-by-... array of zeros of 
%   PRECISION type. Supported precisions are 'single' or 'double'   
%
%   oMatCon.randn with no arguments is a pseudorandom scalar.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.
%
stringIndex = SDCpckg.utils.getFirstStringIndex(varargin{:});    
if(stringIndex)
    xsize = cell2mat(varargin(1:stringIndex-1));
    if(length(xsize) == 1)
        xsize(2) = xsize;
    end
    p = inputParser;
    p.addParamValue('precision','double',@ischar);
    p.KeepUnmatched = true;
    p.parse(varargin{stringIndex:end});
    xprecision = p.Results.precision;
else
    xsize = cell2mat(varargin);
    if(length(xsize) == 1)
        xsize(2) = xsize;           
    end
    xprecision = 'double';
end

td     = ConDir();
header = SDCpckg.basicHeaderStruct(xsize,xprecision,0);
SDCpckg.io.NativeBin.serial.FileRandn(path(td),header);
if(stringIndex)
    x = oMatCon.load(td,p.Unmatched);
else
    x = oMatCon.load(td);
end
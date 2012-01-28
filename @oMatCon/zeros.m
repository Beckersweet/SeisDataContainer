function x = zeros(varargin)
%OMATCON.ZEROS  Zeros array.
%
%   oMatCon.zeros(N) is an N-by-N matrix of zeros.
%
%   oMatCon.zeros(M,N) or iCon.zeros([M,N]) is an M-by-N matrix of zeros.
%
%   oMatCon.zeros(M,N,P,...) or iCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of zeros.
%
%   oMatCon.zeros(SIZE(A)) is the same size as A and all zeros.
%
%   oMatCon.zeros(M,N,...,PRECISION) or ZEROS([M,N,...],PRECISION) is an
%   M-by-N-by-... array of zeros of PRECISION type.
%   Supported precisions are 'single' or 'double'   
%
%   oMatCon.zeros with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.
%
stringIndex = SeisDataContainer.utils.getFirstStringIndex(varargin{:});    
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
header = SeisDataContainer.basicHeaderStruct...
    (xsize,xprecision,0);
SeisDataContainer.io.memmap.serial.FileAlloc(path(td),header);
if(stringIndex)
    x = oMatCon.load(td,p.Unmatched);
else
    x = oMatCon.load(td);
end
end

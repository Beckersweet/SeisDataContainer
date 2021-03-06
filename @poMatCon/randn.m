function x = randn(varargin)
%POMATCON.RANDN  Ones array.
%
%   poMatCon.randn(N) is an N-by-N distributed matrix containing pseudorandom.
%
%   poMatCon.randn(M,N) or poMatCon.zeros([M,N]) is an M-by-N matrix of pseudorandom.
%
%   poMatCon.randn(M,N,P,...) or poMatCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of pseudorandom.
%
%   poMatCon.randn(SIZE(A)) is the same size as A and all pseudorandom.
%
%   poMatCon.randn(M,N,...,PRECISION) or ZEROS([M,N,...],PRECISION) is an
%   M-by-N-by-... array of zeros of PRECISION type.
%   Supported precisions are 'single' or 'double'   
%
%   poMatCon.randn with no arguments is a pseudorandom scalar.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.
    stringIndex = SDCpckg.utils.getFirstStringIndex(varargin{:});    
    if(stringIndex)
        xsize = cell2mat(varargin(1:stringIndex-1));
        p = inputParser;
        p.addParamValue('precision','double',@ischar);
        p.KeepUnmatched = true;
        p.parse(varargin{stringIndex:end});
        xprecision = p.Results.precision;
    else
        xsize = cell2mat(varargin);
        xprecision = 'double';
    end
    
    td = SDCpckg.io.makeDir();
    header = SDCpckg.basicHeaderStruct...
        (xsize,xprecision,0);
    SDCpckg.io.NativeBin.serial.FileRandn(td,header);
    if(stringIndex)
        x = oMatCon.load(td,p.Unmatched);
    else
        x = oMatCon.load(td);
    end
end



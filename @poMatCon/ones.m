function x = ones(varargin)
%POMATCON.ONES  Ones array.
%
%   poMatCon.ones(N) is an N-by-N matrix of zeros.
%
%   poMatCon.ones(M,N) or iCon.zeros([M,N]) is an M-by-N matrix of zeros.
%
%   poMatCon.ones(M,N,P,...) or poMatCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of zeros.
%
%   oMatCon.ones(SIZE(A)) is the same size as A and all zeros.
%
%   poMatCon.randn(M,N,...,PRECISION) or ZEROS([M,N,...],PRECISION) is an
%   M-by-N-by-... array of zeros of PRECISION type.
%   Supported precisions are 'single' or 'double'   
%
%   poMatCon.ones with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.
    stringIndex = SeisDataContainer.utils.getFirstStringIndex(varargin{:});    
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
    
    td = SeisDataContainer.io.makeDir();
    header = SeisDataContainer.basicHeaderStruct...
        (xsize,xprecision,0);
    header = SeisDataContainer.addDistHeaderStruct...
        (header,header.dims,[]);
    SeisDataContainer.io.memmap.serial.FileOnes(td,header);
    if(stringIndex)
        x = oMatCon.load(td,p.Unmatched);
    else
        x = oMatCon.load(td);
    end
end

function x = ones(varargin)
%OMATCON.ONES  Ones array.
%
%   oMatCon.ones(N) is an N-by-N matrix of zeros.
%
%   oMatCon.ones(M,N) or iCon.zeros([M,N]) is an M-by-N matrix of zeros.
%
%   oMatCon.ones(M,N,P,...) or iCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of zeros.
%
%   oMatCon.ones(SIZE(A)) is the same size as A and all zeros.
%
%   oMatCon.randn(M,N,...,PRECISION) or ZEROS([M,N,...],PRECISION) is an
%   M-by-N-by-... array of zeros of PRECISION type.
%   Supported precisions are 'single' or 'double'   
%
%   oMatCon.ones with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.
    if(ischar(varargin{end}))
        xprecision = varargin{end};
        xsize      = cell2mat(varargin(1:end-1));
    else
        xprecision = 'double';
        xsize      = cell2mat(varargin);
    end
    
    td = DataContainer.io.makeDir();
    header = DataContainer.io.basicHeaderStruct...
        (xsize,xprecision,0);
    DataContainer.io.memmap.serial.FileOnes(td,header);
    x = oMatCon.load(td,'precision',xprecision);
end

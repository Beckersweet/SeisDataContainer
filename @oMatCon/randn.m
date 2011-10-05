function x = randn(varargin)
%OMATCON.RANDN  Ones array.
%
%   oMatCon.randn(N) is an N-by-N matrix containing pseudorandom.
%
%   oMatCon.randn(M,N) or iCon.zeros([M,N]) is an M-by-N matrix of pseudorandom.
%
%   oMatCon.randn(M,N,P,...) or iCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of pseudorandom.
%
%   oMatCon.randn(SIZE(A)) is the same size as A and all pseudorandom.
%
%   oMatCon.randn(M,N,...,PRECISION) or ZEROS([M,N,...],PRECISION) is an
%   M-by-N-by-... array of zeros of PRECISION type.
%   Supported precisions are 'single' or 'double'   
%
%   oMatCon.randn with no arguments is a pseudorandom scalar.
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
    header = DataContainer.basicHeaderStruct...
        (xsize,xprecision,0);
    DataContainer.io.memmap.serial.FileRandn(td,header);
    x = oMatCon.load(td,'precision',xprecision);
end



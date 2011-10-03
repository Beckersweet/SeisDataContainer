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
    header = DataContainer.io.addDistHeaderStruct...
        (header,header.dims,[]);
    DataContainer.io.memmap.serial.FileRandn(td,header);
    x = poMatCon.load(td,'precision',xprecision);
end



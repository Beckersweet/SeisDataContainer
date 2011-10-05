function x = zeros(varargin)
%POMATCON.ZEROS  Zeros array.
%
%   poMatCon.zeros(N) is an N-by-N matrix of zeros.
%
%   poMatCon.zeros(M,N) or poMatCon.zeros([M,N]) is an M-by-N matrix of zeros.
%
%   poMatCon.zeros(M,N,P,...) or poMatCon.zeros([M N P ...]) is an 
%   M-by-N-by-P-by-... array of zeros.
%
%   poMatCon.zeros(SIZE(A)) is the same size as A and all zeros.
%
%   poMatCon.zeros(M,N,...,PRECISION) or ZEROS([M,N,...],PRECISION) is an
%   M-by-N-by-... array of zeros of PRECISION type.
%   Supported precisions are 'single' or 'double'   
%
%   poMatCon.zeros with no arguments is the scalar 0.
%
%   Note: The size inputs M, N, and P... should be nonnegative integers. 
%   Negative integers are treated as 0.
%     global SDCdefaultIOdist;
    
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
    header = DataContainer.io.addDistHeaderStruct...
        (header,header.dims,[]);
%     if SDCdefaultIOdist
%         %header = addDistFile
%         DataContainer.io.memmap.dist.FileAlloc(td,header);
%     else
%         DataContainer.io.memmap.serial.FileAlloc(td,header);
%     end
    DataContainer.io.memmap.serial.FileAlloc(td,header);
    x = poMatCon.load(td,'precision',xprecision);
end

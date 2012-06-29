function FileGather(dirin,dirout)
% FILEGATHER copies distributed file into serial
%
%   FileGather(DIRIN,DIROUT)
%   Converts distributed file to serial file
%
%   DIRIN   - A string specifying the input file directory
%   DIROUT  - A string specifying the output file directory
%
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirin), 'input directory name must be a string')
assert(ischar(dirout), 'output directory name must be a string')
assert(isdir(dirin),'Fatal error: input directory %s does not exist',dirin);
assert(matlabpool('size')>0,'matlabpool must be open')

% Read header
hdrin = SDCpckg.io.NativeBin.serial.HeaderRead(dirin);
assert(hdrin.distributedIO==1,'input file must be distributed')

% update headers
hdrout = hdrin;
hdrout = SDCpckg.deleteDistHeaderStruct(hdrout);
sldims = hdrin.size(hdrin.distribution.dim+1:end);

% Allocate file
SDCpckg.io.NativeBin.serial.FileAlloc(dirout,hdrout);

% Copy file
dirnames = SDCpckg.utils.Cell2Composite(hdrin.directories);
csize_in = SDCpckg.utils.Cell2Composite(hdrin.distribution.size);
cindx_rng_in = SDCpckg.utils.Cell2Composite(hdrin.distribution.indx_rng);
spmd
for s=1:prod(sldims)
    slice = SDCpckg.utils.getSliceIndexS2V(sldims,s);
    x=SDCpckg.io.NativeBin.dist.DataReadLeftSlice(1,dirnames,'real',...
        hdrin.size,csize_in,[],hdrin.distribution.dim,hdrin.distribution.partition,...
        slice,hdrin.precision,hdrin.precision);
    SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(0,dirout,'real',x,...
        hdrin.size,csize_in,cindx_rng_in,hdrin.distribution.dim,...
        slice,hdrin.precision);
    if hdrin.complex
        x=SDCpckg.io.NativeBin.dist.DataReadLeftSlice(1,dirnames,'imag',...
            hdrin.size,csize_in,[],hdrin.distribution.dim,hdrin.distribution.partition,...
            slice,hdrin.precision,hdrin.precision);
        SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(0,dirout,'imag',x,...
            hdrin.size,csize_in,cindx_rng_in,hdrin.distribution.dim,...
            slice,hdrin.precision);
    end
end
end

end

function FileDistribute(dirin,dirout,dirsout,distdim)
% FILEDISTRIBUTE copies serial file into distributed
%
%   FileDistribute(DIRIN,DIROUT,DISTDIM)
%   Converts serial file to distributed file on a given dimension
%
%   DIRIN   - A string specifying the input file directory
%   DIROUT  - A string specifying the output file directory
%   DISTDIM - A scalar specifying the distribution dimension
%
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirin), 'input directory name must be a string')
assert(ischar(dirout), 'output directory name must be a string')
assert(iscell(dirsout), 'distributed output directories names must form cell')
assert(isscalar(distdim),'distribution dimension must be a scalar')
assert(distdim>0,'distribution dimension must be bigger than 0')
assert(isdir(dirin),'Fatal error: input directory %s does not exist',dirin);
assert(matlabpool('size')>0,'matlabpool must be open')

% Read header
hdrin = SDCpckg.io.NativeBin.serial.HeaderRead(dirin);
assert(hdrin.distributedIO==0,'input file must be serial')
assert(distdim<=hdrin.dims,'distributin dimension bigger than input diemsions')

% Update headers
partition = SDCpckg.utils.defaultDistribution(hdrin.size(distdim));
hdrin = SDCpckg.addDistHeaderStruct(hdrin,distdim,partition);
hdrout = SDCpckg.addDistFileHeaderStruct(hdrin,dirsout);
sldims = hdrin.size(distdim+1:end);

% Allocate file
SDCpckg.io.NativeBin.dist.FileAlloc(dirout,hdrout);

% Copy file
for s=1:prod(sldims)
    slice = SDCpckg.utils.getSliceIndexS2V(sldims,s);
    x=SDCpckg.io.NativeBin.dist.DataReadLeftSlice(0,dirin,'real',...
        hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
    SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(1,hdrout.directories,'real',x,...
        hdrout.size,hdrout.distribution,slice,hdrout.precision);
    if hdrin.complex
        x=SDCpckg.io.NativeBin.dist.DataReadLeftSlice(0,dirin,'imag',...
            hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
        SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(1,hdrout.directories,'imag',x,...
            hdrout.size,hdrout.distribution,slice,hdrout.precision);
    end
end

end

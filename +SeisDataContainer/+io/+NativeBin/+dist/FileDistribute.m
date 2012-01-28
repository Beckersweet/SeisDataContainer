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
hdrin = SeisDataContainer.io.NativeBin.serial.HeaderRead(dirin);
assert(hdrin.distributedIO==0,'input file must be serial')
assert(distdim<=hdrin.dims,'distributin dimension bigger than input diemsions')
% Make Directory
if isdir(dirout); rmdir(dirout,'s'); end;
status = mkdir(dirout);
assert(status,'Fatal error while creating directory %s',dirout);
% update headers
partition = SeisDataContainer.utils.defaultDistribution(hdrin.size(distdim));
hdrin = SeisDataContainer.addDistHeaderStruct(hdrin,distdim,partition);
hdrout = SeisDataContainer.io.addDistFileHeaderStruct(hdrin,dirsout);
sldims = hdrin.size(distdim+1:end);
% Allocate file
SeisDataContainer.io.NativeBin.dist.DataAlloc(hdrout.directories,'real',...
    hdrout.distribution.size,hdrout.precision);
if hdrin.complex
    SeisDataContainer.io.NativeBin.dist.DataAlloc(hdrout.directories,'imag',...
        hdrout.distribution.size,hdrout.precision);
end
% Copy file
for s=1:prod(sldims)
    slice = SeisDataContainer.utils.getSliceIndexS2V(sldims,s);
    x=SeisDataContainer.io.NativeBin.dist.DataReadLeftSlice(0,dirin,'real',...
        hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
    SeisDataContainer.io.NativeBin.dist.DataWriteLeftSlice(1,hdrout.directories,'real',x,...
        hdrout.size,hdrout.distribution,slice,hdrout.precision);
    if hdrin.complex
        x=SeisDataContainer.io.NativeBin.dist.DataReadLeftSlice(0,dirin,'imag',...
            hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
        SeisDataContainer.io.NativeBin.dist.DataWriteLeftSlice(1,hdrout.directories,'imag',x,...
            hdrout.size,hdrout.distribution,slice,hdrout.precision);
    end
end
%Write header
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirout,hdrout);

end

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
hdrin = SeisDataContainer.io.NativeBin.serial.HeaderRead(dirin);
assert(hdrin.distributedIO==1,'input file must be distributed')
% Make Directory
if isdir(dirout); rmdir(dirout,'s'); end;
status = mkdir(dirout);
assert(status,'Fatal error while creating directory %s',dirout);
% update headers
hdrout = hdrin;
sldims = hdrin.size(hdrin.distribution.dim+1:end);
% Allocate file
SeisDataContainer.io.NativeBin.serial.DataAlloc(dirout,'real',...
    hdrout.size,hdrout.precision);
if hdrin.complex
    SeisDataContainer.io.NativeBin.serial.DataAlloc(dirout,'imag',...
        hdrout.size,hdrout.precision);
end
% Copy file
for s=1:prod(sldims)
    slice = SeisDataContainer.utils.getSliceIndexS2V(sldims,s);
    x=SeisDataContainer.io.NativeBin.dist.DataReadLeftSlice(1,hdrin.directories,'real',...
        hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
    SeisDataContainer.io.NativeBin.dist.DataWriteLeftSlice(0,dirout,'real',x,...
        hdrout.size,hdrout.distribution,slice,hdrout.precision);
    if hdrin.complex
        x=SeisDataContainer.io.NativeBin.dist.DataReadLeftSlice(1,hdrin.directories,'imag',...
            hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
        SeisDataContainer.io.NativeBin.dist.DataWriteLeftSlice(0,dirout,'imag',x,...
            hdrout.size,hdrout.distribution,slice,hdrout.precision);
    end
end
%Write header
hdrout = SeisDataContainer.io.deleteDistHeaderStruct(hdrout);
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirout,hdrout);
 
end

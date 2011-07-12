function FileGather(dirin,dirout)
% FileGather - copy distributed file into serial
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirin), 'input directory name must be a string')
assert(ischar(dirout), 'output directory name must be a string')
assert(isdir(dirin),'Fatal error: input directory %s does not exist',dirin);

% Read header
hdrin = DataContainer.io.memmap.serial.HeaderRead(dirin);
assert(hdrin.distributed==1,'input file must be distributed')
% Make Directory
if isdir(dirout); rmdir(dirout,'s'); end;
status = mkdir(dirout);
assert(status,'Fatal error while creating directory %s',dirout);
% update headers
hdrout = hdrin;
sldims = hdrin.size(hdrin.distribution.dim+1:end);
% Allocate file
DataContainer.io.memmap.serial.DataAlloc(dirout,'real',...
    hdrout.size,hdrout.precision);
if hdrin.complex
    DataContainer.io.memmap.serial.DataAlloc(dirout,'imag',...
        hdrout.size,hdrout.precision);
end
% Copy file
for s=1:prod(sldims)
    slice = DataContainer.utils.getSliceIndexS2V(sldims,s);
    x=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'real',...
        hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
    DataContainer.io.memmap.dist.DataWriteLeftSlice(0,dirout,'real',x,...
        hdrout.size,hdrout.distribution,slice,hdrout.precision);
    if hdrin.complex
        x=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'imag',...
            hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
        DataContainer.io.memmap.dist.DataWriteLeftSlice(0,dirout,'imag',x,...
            hdrout.size,hdrout.distribution,slice,hdrout.precision);
    end
end
%Write header
hdrout = DataContainer.io.deleteDistHeaderStruct(hdrout);
DataContainer.io.memmap.serial.HeaderWrite(dirout,hdrout);
 
end

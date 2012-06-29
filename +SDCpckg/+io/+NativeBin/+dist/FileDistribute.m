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
hdrout = SDCpckg.addDistHeaderStruct(hdrin,distdim,partition);
hdrout = SDCpckg.addDistFileHeaderStruct(hdrout,dirsout);
sldims = hdrin.size(distdim+1:end);

% Allocate file
SDCpckg.io.NativeBin.dist.FileAlloc(dirout,hdrout);

% Copy file
dirnames = SDCpckg.utils.Cell2Composite(hdrout.directories);
csize_out = SDCpckg.utils.Cell2Composite(hdrout.distribution.size);
cindx_rng_out = SDCpckg.utils.Cell2Composite(hdrout.distribution.indx_rng);
spmd
for s=1:prod(sldims)
    slice = SDCpckg.utils.getSliceIndexS2V(sldims,s);
    x=SDCpckg.io.NativeBin.dist.DataReadLeftSlice(0,dirin,'real',...
        hdrout.size,[],cindx_rng_out,hdrout.distribution.dim,hdrout.distribution.partition,...
        slice,hdrout.precision,hdrout.precision);
    SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(1,dirnames,'real',x,...
        hdrout.size,csize_out,[],hdrout.distribution.dim,...
        slice,hdrout.precision);
    if hdrout.complex
        x=SDCpckg.io.NativeBin.dist.DataReadLeftSlice(0,dirin,'imag',...
            hdrout.size,[],cindx_rng_out,hdrout.distribution.dim,hdrout.distribution.partition,...
            slice,hdrout.precision,hdrout.precision);
        SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(1,dirnames,'imag',x,...
            hdrout.size,csize_out,[],hdrout.distribution.dim,...
            slice,hdrout.precision);
    end
end
end

end

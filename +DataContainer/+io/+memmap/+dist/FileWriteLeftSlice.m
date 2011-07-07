function FileWriteLeftSlice(dirname,x,slice)
%FILEWRITELEFTSLICE  Write serial left slice data to binary file
%
%   FileWriteLeftSlice(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   Warning: If the specified dirname will be removed,
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdistributed(x), 'data must be distributed')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Read header
header = DataContainer.io.memmap.serial.HeaderRead(dirname);
distdim = header.dims - length(slice);
assert(distdim>0,'invalid distributed diemnsion; too many indecies in the slice?')
partition = DataContainer.utils.defaultDistribution(header.size(distdim));
if ~header.distributed
    header = DataContainer.io.addDistHeaderStruct(distdim,partition,header);
else
    assert(distdim==header.distribution.dim,...
        'distributed dimension of reading request (%d) does not match (%d) in stored file',distdim,header.distribution.dim)
    assert(isequal(partition,header.distribution.partition),'partitioning of reading request does not match stored file')
end
% Read file
if header.distributed
    DataContainer.io.memmap.dist.DataWriteLeftSlice(1,header.directories,'real',real(x),...
        header.size,header.distribution,slice,header.precision);
    if header.complex
        DataContainer.io.memmap.dist.DataWriteLeftSlice(1,header.directories,'imag',imag(x),...
            header.size,header.distribution,slice,header.precision);
    end
else
    DataContainer.io.memmap.dist.DataWriteLeftSlice(0,dirname,'real',real(x),...
        header.size,header.distribution,slice,header.precision);
    if header.complex
        DataContainer.io.memmap.dist.DataWriteLeftSlice(0,dirname,'imag',imag(x),...
            header.size,header.distribution,slice,header.precision);
    end
end

end

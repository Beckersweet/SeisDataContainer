function FileAlloc(dirname,header)
%FILEALLOC Allocates binary file in the specified directory
%
%   FILEALLOC(DIRNAME,HEADER) allocates binary files for distributed writing.
%   The file sizes are specified in the header.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the file properties
%

error(nargchk(2, 2, nargin, 'struct'));
%assert(matlabpool('size')>0,'matlabpool must be open')
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
assert(header.distributedIO==1,'header is missing file distribution')
SeisDataContainer.io.isFileClean(dirname);
SeisDataContainer.io.setFileDirty(dirname);

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% convert to composite
cdirnames = SeisDataContainer.utils.Cell2Composite(header.directories);
cdimensions = SeisDataContainer.utils.Cell2Composite(header.distribution.size);
hprecision = header.precision;
hcomplex = header.complex;

% Write header
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirname,header);

% Write file
spmd
    SeisDataContainer.io.NativeBin.serial.DataAlloc(cdirnames,'real',cdimensions,hprecision);
    if hcomplex
        SeisDataContainer.io.NativeBin.serial.DataAlloc(cdirnames,'imag',cdimensions,hprecision);
    end
end

SeisDataContainer.io.setFileClean(dirname);
end

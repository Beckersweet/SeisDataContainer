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
SDCpckg.io.isFileClean(dirname);
SDCpckg.io.setFileDirty(dirname);

% Check Directory
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% convert to composite
cdirnames = SDCpckg.utils.Cell2Composite(header.directories);
cdimensions = SDCpckg.utils.Cell2Composite(header.distribution.size);
hprecision = header.precision;
hcomplex = header.complex;

% Write header
SDCpckg.io.NativeBin.serial.HeaderWrite(dirname,header);

% Write file
spmd
    SDCpckg.io.NativeBin.serial.DataAlloc(cdirnames,'real',cdimensions,hprecision);
    if hcomplex
        SDCpckg.io.NativeBin.serial.DataAlloc(cdirnames,'imag',cdimensions,hprecision);
    end
end

SDCpckg.io.setFileClean(dirname);
end

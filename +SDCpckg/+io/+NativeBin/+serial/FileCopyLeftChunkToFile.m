function FileCopyLeftChunkToFile(dirin,dirout,range,slice)
%FileCopyLeftChunkFromFile Extracts serial left chunk data
%                          from larger file to prealocated file
%
%   FileCopyLeftChunkFromFile(DIRNAME,DATA,RANGE,SLICE) copies
%   serial left chunk from DIRIN into full serial file DIROUT
%
%   DIRIN  - A string specifying the input directory name
%   DIROUT - A string specifying the output directory name
%   RANGE   - A vector with two elements representing the range of
%             data that we want to write            
%   SLICE   - A vector specifying the slice
%

error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirin), 'input directory name must be a string')
assert(ischar(dirout), 'ouput directory name must be a string')
assert(isdir(dirin),'Fatal error: input directory %s does not exist',dirin);
assert(isdir(dirout),'Fatal error: ouput directory %s does not exist',dirout);
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
SDCpckg.io.isFileClean(dirin);
SDCpckg.io.isFileClean(dirout);
SDCpckg.io.setFileDirty(dirout);

% Read headers
HEADER = SDCpckg.io.NativeBin.serial.HeaderRead(dirin);
header = SDCpckg.io.NativeBin.serial.HeaderRead(dirout);
assert(strcmp(header.precision,HEADER.precision),...
      'source and destination precision do not match')
assert(HEADER.complex==header.complex,...
      'source and destination complex flags do not match')

[cdims, corg] = SDCpckg.utils.getLeftChunkInfo(HEADER.size,range,slice);
clen = prod(cdims);
assert(clen==prod(header.size),'input file does not match chunk size')

% Copy data
SDCpckg.io.NativeBin.serial.DataBufferedCopy(dirin,dirout,'real',...
    corg,0,clen,HEADER.precision);
if HEADER.complex
    SDCpckg.io.NativeBin.serial.DataBufferedCopy(dirin,dirout,'imag',...
        corg,0,clen,HEADER.precision);
end 
SDCpckg.io.setFileClean(dirout);
end

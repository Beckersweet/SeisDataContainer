function x = DataReadStriped(dirname,filename,dimensions,offset,count,skip,file_precision,x_precision)
%DATAREAD Reads serial data buffer from binary file
%           starting from offset, count elements,
%           and skip every skip-1 elements
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,
%           OFFSET,COUNT,SKIP,
%           FILE_PRECISION,X_PRECISION) reads
%   the serial real vector striped buffer from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   FILENAME    - A string specifying the file name
%   DIMENSIONS  - A vector specifying the dimensions
%   OFFSET      - A scalar specifying starting element
%   COUNT       - A scalar specifying numer of elements to read
%   SKIP        _ A scalar specifying number of elements to skip
%   DIMENSIONS  - A vector specifying the dimensions
%   DIMENSIONS  - A vector specifying the dimensions
%   *_PRECISION - An string specifying the precision of one unit of data,
%                 Supported precisions: 'double', 'single'
%
error(nargchk(8, 8, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(isscalar(offset), 'offset must be a scalar')
assert(isscalar(count), 'coount must be a scalar')
assert(isscalar(skip), 'skip must be a scalar')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(ischar(x_precision), 'x_precision name must be a string')
assert(offset>0&&offset<=prod(dimensions),'offset out of element range')
assert((offset+(count-1)*skip)<=prod(dimensions),'last elements out of array bounds')

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

if(iscell(dimensions))
    dimensions = cell2mat(dimensions);
end
% Set byte size
bytesize = SDCpckg.utils.getByteSize(file_precision);
boffset = (offset-1)*bytesize;
bskip = (skip-1)*bytesize;


% Read local data
fid = fopen(filename,'r');
fseek(fid, boffset, 'bof');
x = fread(fid,count,file_precision,bskip);
fclose(fid);
assert(prod(size(x))==count,'could not read enough elements from file')

% swap x_precision
x = SDCpckg.utils.switchPrecisionIP(x,x_precision);

end

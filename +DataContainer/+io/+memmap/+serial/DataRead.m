function x = DataRead(dirname,filename,dimensions,file_precision,x_precision)
%DATAREAD Reads serial data from binary file
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   FILENAME    - A string specifying the file name
%   DIMENSIONS  - A vector specifying the dimensions
%   *_PRECISION - An string specifying the precision of one unit of data,
%                 Supported precisions: 'double', 'single'
%
error(nargchk(5, 5, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(ischar(x_precision), 'x_precision name must be a string')

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Check File
assert(exist(filename)==2,'Fatal error: file %s does not exist',filename);

if(iscell(dimensions))
    dimensions = cell2mat(dimensions);
end

% Read local data
fid = fopen(filename,'r');
x = fread(fid,prod(dimensions),file_precision);
if length(dimensions) > 1
    x = reshape(x,dimensions);
end
fclose(fid);

% swap x_precision
x = DataContainer.utils.switchPrecisionIP(x,x_precision);

end

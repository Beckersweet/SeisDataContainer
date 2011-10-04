function [x header] = FileReadLeftSlice(dirname,slice,varargin)
%FILEREADLEFTSLICE  Read serial left slice data from binary file
%
% Edited with JavaSeis by Trisha
%
%   [X, HEADER] = FileReadLeftSlice(DIRNAME,SLICE,X_PRECISION) reads
%   the serial left slice from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   SLICE       - A vector specifying the slice index
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>2
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('r');

% Read header
%header = DataContainer.io.memmap.serial.HeaderRead(dirname);
% header = seisio.readFrameHeaders(); % returns number of traces in the
% frame, or zero on end-of-file. 

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();
assert(isequal(dimensions,2)|isequal(dimensions,3)|isequal(dimensions,4)|...
    isequal(dimensions,5), 'Data in js file must have dimensions 2<=n<=5.')
position = zeros(1,dimensions);
position(dimensions-length(slice)+1:dimensions) = slice;

% Read file

seisio.readFrame(position); % reads one 2D "Frame", from N-dimensional dataset 
% this is a problem because we might want to read some N-n dimensions, not
% nec. 2d...
x = seisio.getTraceDataArray()';

end

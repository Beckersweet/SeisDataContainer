function [x header] = FileReadLeftChunk(dirname,range,slice,varargin)
%FILEREADLEFTCHUNK Reads serial left chunck data from binary file
%
% Edited for JavaSeis by Trisha
%
%   [X, HEADER] = FileReadLeftChunk(DIRNAME,RANGE,SLICE,X_PRECISION) reads
%   the serial left chunk from DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   RANGE       - A vector with two elements specifying the range of data
%   SLICE       - A vector specifying the slice index
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%
error(nargchk(3, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>3
    assert(ischar(varargin{1}),'Fatal error: precision is not a string?');
    x_precision = varargin{1};
end;

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('r');

% Read header
%header = DataContainer.io.javaseis.serial.HeaderRead(dirname);

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();
assert(isequal(slice,[]), 'Code only completed for slice == []');
asser(isequal(dimensions, 3), 'Code only completed for 3 dimensions');
position = zeros(dimensions,1);

% need to pre-set X to be 3d array of zeros with the correct dimensions
rangeCount=range(2)-range(1)+1;
x=zeros(seisio.getGridDefinition.getNumSamplesPerTrace(),...
    seisio.getGridDefinition.getNumTracesPerFrame(), rangeCount);
%x=zeros(226,676,rangeCount);
    % Matlab reads the frame in transposed, so traces then samples. This is
    % an issue to keep in mind. 
for i = range(1)+1:range(2)+1
    position(dimensions)=i-1;
    seisio.readFrame(position); % reads one 2D "Frame"
    x(:,:,i) = seisio.getTraceDataArray()'; 
end


 
end

function [x header] = FileRead(dirname,varargin)
%FILEREAD  Read serial data and header from binary file
%TODO: >3dims
%
%   [X, HEADER] = FileRead(DIRNAME,X_PRECISION) reads
%   the serial file from DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   X_PRECISION - An optional string specifying the precision of one unit of data,
%                 defaults to 'double' (8 bits)
%                 Supported precisions: 'double', 'single'
%
error(nargchk(1, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Setup variables
x_precision = 'double';

% Preprocess input arguments
if nargin>1
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
position = zeros(dimensions,1);

% need to pre-set X to be 3d array of zeros with the correct dimensions
x=zeros(seisio.getGridDefinition.getNumSamplesPerTrace(),...
    seisio.getGridDefinition.getNumTracesPerFrame(), ...
    seisio.getGridDefinition.getNumFramesPerVolume());
%x=zeros(226,676,rangeCount);
    % Matlab reads the frame in transposed, so traces then samples. This is
    % an issue to keep in mind. 
for i = 1:seisio.getGridDefinition.getNumFramesPerVolume()
    position(dimensions)=i-1;
    seisio.readFrame(position); % reads one 2D "Frame"
    x(:,:,i) = seisio.getTraceDataArray()'; 
end
 seisio.close();
end

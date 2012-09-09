function [x, header] = FileRead(dirname,varargin)
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
seisio = beta.javaseis.io.Seisio(dirname);
seisio.open('r');

% Read header
header = SDCpckg.io.JavaSeis.serial.HeaderRead(dirname)

% Get number of dimensions and set position accordingly
dimensions = header.dims ;
position = zeros(dimensions,1);

% Get Shape
shape = header.size ;

% Pre-set X to be 4d array of zeros with the correct dimensions
x=zeros(shape(1),...
    shape(2), ...
    shape(3), ...
    shape(4));
%x=zeros(226,676,rangeCount);
    % Matlab reads the frame in transposed, so traces then samples. This is
    % an issue to keep in mind. 

% Read up to 4D datasets    
for j=1:shape(4)
    position(4) = j-1
  for i = 1:shape(3)
    position(3) = i -1 ; 
    seisio.readFrame(position); % reads one 2D "Frame"
    x(:,:,i,j) = seisio.getTraceDataArray()';  
  end
end  
  seisio.close();
 
end

function [x header] = FileReadLeftSlice(dirname,slice,varargin)
%FILEREADLEFTSLICE  Read serial left slice data from binary file
%
% Edited with JavaSeis by Trisha, Barbara
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
header = SDCpckg.io.JavaSeis.serial.HeaderRead(dirname)

% Get number of dimensions and set position accordingly
dimensions = header.dims ;
position = zeros(dimensions,1);

% Get Shape
shape = header.size ;

%assert(isequal(slice,[]), 'Code only completed for slice == []');
%asser(isequal(dimensions, 3), 'Code only completed for 3 dimensions');
position = zeros(dimensions,1);

% Pre-set X to be 4d array of zeros with the correct dimensions
rangeCount=range(2)-range(1)+1; 
x = zeros(shape(1),shape(2),slice(1),slice(2)) ;

%x=zeros(226,676,rangeCount);
    % Matlab reads the frame in transposed, so traces then samples. This is
    % an issue to keep in mind. 

% Read up to 4D datasets    
for j= slice(2):slice(2)
    position(4) = j-1
  for i = slice(1):slice(1)
    position(3) = i - 1 ; 
    seisio.readFrame(position); % reads one 2D "Frame"
    x(:,:,i,j) = seisio.getTraceDataArray()' ;
 
  end
end  
  seisio.close();
 

end

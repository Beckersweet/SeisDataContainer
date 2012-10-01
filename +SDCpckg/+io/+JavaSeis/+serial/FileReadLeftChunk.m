function [x header] = FileReadLeftChunk(dirname,range,slice,varargin)
%FILEREADLEFTCHUNK Reads serial left chunck data from binary file
%
% Edited for JavaSeis by Trisha, Barbara
%
%   [X, HEADER] = FileReadLeftChunk(DIRNAME,RANGE,SLICE,X_PRECISION) reads
%   the serial left chunk from DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   RANGE       - A vector with two elements specifying the range of data
%   SLICE       - A vector specifying the slice index : slice(1) =  i -
%   slice(2) = j
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
header = SDCpckg.io.JavaSeis.serial.HeaderRead(dirname) ;

% Get number of dimensions and set position accordingly
dimensions = header.dims ;
position = zeros(dimensions,1);

% Get Shape
shape = header.size ;

%assert(isequal(slice,[]), 'Code only completed for slice == []');
%asser(isequal(dimensions, 3), 'Code only completed for 3 dimensions');
%position = zeros(dimensions,1);


% Pre-set X to be 4d array of zeros with the correct dimensions
rangeCount=range(2)-range(1)+1; 
if isequal(slice,[]) == 0 
   x = zeros(shape(2),rangeCount,1,1) ;
   sx = zeros(shape(1),shape(2),1,1) ;
   
   jstart = slice(2) ;
   jend = jstart ;
   istart = slice(1) ;
   iend = istart ;
   
else 
    x = zeros(shape(2),rangeCount,shape(3),shape(4)) ;
   sx = zeros(shape(1),shape(2),shape(3),shape(4)) ;
   
   
   jstart = 1;
   jend = shape(4);
   istart = 1;
   iend = shape(3) ;
   
end

%x=zeros(226,676,rangeCount);
    % Matlab reads the frame in transposed, so traces then samples. This is
    % an issue to keep in mind. 

% Read up to 4D datasets    
for j=jstart:jend
    position(4) = j-1 ;
  for i = istart:iend
    position(3) = i - 1 ; 
    seisio.readFrame(position); % reads one 2D "Frame"
    sx(:,:,i,j) = seisio.getTraceDataArray()' ;
  
    if isequal(slice,[]) == 0
        
        size_x = size(x);
        size_sx = size(sx(:,range(1):range(2),i,j));
        
        x = sx(:,range(1):range(2),i,j) ;
    else 
        
        size_x = size(x(:,:,i,j));
        size_sx = size(sx(:,range(1):range(2),i,j));
        
        
        x(:,:,i,j) = sx(:,range(1):range(2),i,j)   ; 
    end     
 
  end
end  
  seisio.close();
 
end


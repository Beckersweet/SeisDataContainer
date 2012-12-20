function [y header] = FileReadLeftSlice(dirname,slice,varargin)
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
import org.javaseis.io.Seisio.*;    
seisio = org.javaseis.io.Seisio( dirname );
seisio.open('r');

% Read header
% header = SDCpckg.io.JavaSeis.serial.HeaderRead(dirname)

% Get number of dimensions and set position accordingly
header.dims = seisio.getGridDefinition.getNumDimensions() ;

% Define number of Hypercubes, Volumes, Frames & Traces
header.size = seisio.getGridDefinition.getAxisLengths() ;

% Get number of dimensions and set position accordingly
dimensions = header.dims ;
position = zeros(dimensions,1);

% Get Shape
shape = header.size ;


% Define Grid Size
%testHsize = header.size;
% gridsize = [header.size]' ;
% gridsize = [header.size] ;

% if less than 4D: Reshape to 4D
  if size(shape) < 4
     for nullDim=size(shape):3
  
      shape(nullDim+1) =  1 
      header.origin(nullDim+1) = 0
      header.delta(nullDim+1) = 0
     
     end
  end    

%assert(isequal(slice,[]), 'Code only completed for slice == []');
%asser(isequal(dimensions, 3), 'Code only completed for 3 dimensions');
position = zeros(dimensions,1);

% Pre-set X to be 4d array of zeros with the correct dimensions
% x = zeros(shape(1),shape(2),slice(1),slice(2)) ;

 if isequal(slice,[]) == 0 
   x = zeros([shape(1),shape(2),1,1]) ;
  % test = 0
   jstart = slice(2) 
   jend = jstart 
   istart = slice(1) 
   iend = istart 
   
else 
    x = zeros(shape(1),shape(2),shape(3),shape(4)) ;
 
  % test = 1
   
   jstart = 1 
   jend = shape(4) 
   istart = 1 
   iend = shape(3) 
   
end


%x=zeros(226,676,rangeCount);
    % Matlab reads the frame in transposed, so traces then samples. This is
    % an issue to keep in mind. 

% Read up to 4D datasets    
for j= jstart:jend
    position(4) = j-1 ;
  for i = istart:iend
    position(3) = i - 1 ; 
    seisio.readFrame(position); % reads one 2D "Frame"
    x(:,:,i,j) = seisio.getTraceDataArray()' 
    y=x(:,:,i,j) ;
    
    testi =i
    testj = j
    
  end
end  

  % Case of multiple read of the same file
  % Take the last slice added in x
  if isequal(slice,[]) == 0 
  y = x(:,:,i,j) 
  end

  seisio.close();
 

end

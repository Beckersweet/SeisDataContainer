function x = DataReadLeftChunk(dirname,range,slice,buffer,x_precision,varargin)
%DATAREADLEFTCHUNCK Reads left chunck from binary file
%
%   X = DataReadLeftChunk(DIRNAME,FILENAME,DIMENSIONS,RANGE,SLICE,FILE_PRECISION,X_PRECISION)
%   reads the chunk (from last dimension) of the real serial array X from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   FILENAME    - A string specifying the file name
%   DIMENSIONS  - A vector specifying the dimensions
%   RANGE       - A vector with two elements specifying the range of data
%   SLICE       - A vector specifying the slice index
%   *_PRECISION - An string specifying the precision of one unit of data,
%                 Supported precisions: 'double', 'single'
%
%error(nargchk(7, 7, nargin, 'struct'));
%assert(ischar(dirname), 'directory name must be a string')
%assert(ischar(filename), 'file name must be a string')
%assert(isvector(dimensions), 'dimensions must be a vector')
%assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
%assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')
%assert(ischar(file_precision), 'file_precision name must be a string')
%assert(ischar(x_precision), 'x_precision name must be a string')

% Get data chunk
r =  SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,range,slice) ;

% Reshape to 4D
 totalsize = size(r) ;
 if length(size(r)) < 4
     for nullDim=length(size(r)):3
  
      totalsize(nullDim+1) =  1 ;
     
     
     end
  end    

% Reshape to Vector
if length(size(r))>1
   newsize = totalsize(1)*totalsize(2)*totalsize(3)*totalsize(4) ;
   r = reshape(r,[1 newsize]) ;
end


r = r(buffer(1):buffer(2)) ;

% swap x_precision
x = SDCpckg.utils.switchPrecisionIP(r,x_precision);

end

function FileAlloc(dirname,header)
%FILEALLOC Allocates file space with header
%
%   Allocate up to 4D Dataset
%
%   FileAlloc(DIRNAME,HEADER) allocates files for serial I/O.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the distribution
%

error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isstruct(header), 'header must be a header struct')
%assert(header.distributed==0,'header have file distribution for serial file alloc?')

% Load dynamic libraries
 javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');

% Make Directory
 if isdir(dirname) 
    rmdir(dirname,'s'); 
 end
 status = mkdir(dirname);
 assert(status,'Fatal error while creating directory %s',dirname);  
 
% Make sure the working directory is in your $PATH
% Otherwise you will get java.io.RandomAccessFile error.

% Define logical & physical coordinates
 origin = header.origin ;
 delta = header.delta ;
 neworigin = [origin]' ;
 newdelta = [delta]' ;

% Define Grid Size
%testHsize = header.size;
 gridsize = [header.size]'  ;
% gridsize = [header.size] ;

% if less than 4D: Reshape to 4D
  if size(gridsize) < 4
     for nullDim=size(gridsize):3
  
      gridsize(nullDim+1) =  1 ;
      neworigin(nullDim+1) = 1 ;
      newdelta(nullDim+1) = 1 ;
     
     end
  end    
 
% testgrid = size(gridsize) ;

% Grid definition 
  grid = beta.javaseis.grid.GridDefinition.standardGrid(1,gridsize,neworigin,newdelta,neworigin,newdelta) ;

% Create the JS header / dataset 
seisio = beta.javaseis.io.Seisio(dirname,grid);

% Create the file struture: allocate/construct the corresponding objects 
seisio.create();

end

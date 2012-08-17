function FileAlloc(dirname,header)
%FILEALLOC Allocates file space with header
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

% Import External Functions
import beta.javaseis.io.Seisio.*;
import beta.javaseis.grid.GridDefinition.* ;
%import java.io.RandomAccessFile.* ;
%import @iCon.*;

% Make Directory
 if isdir(dirname) 
    rmdir(dirname,'s'); 
 end
 status = mkdir(dirname);
 assert(status,'Fatal error while creating directory %s',dirname);  
 
% Make sure the working directory is in your $PATH
% Otherwise you will get java.io.RandomAccessFile error.

% Define logical & physical coordinates
% Need to Convert Header - MAT 2 JS 
% Do it in MEMORY
% Coordinates Transpose does nt change anything
 origin = header.origin 
 delta = header.delta 
 neworigin = [origin]' 
 newdelta = [delta]' 

% Define Grid Size
 gridsize = [header.size]'  
 
% if less than 4D: Reshape to 4D
  if size(gridsize) < 4
     for nullDim=size(gridsize):3
  
      gridsize(nullDim+1) =  1
      neworigin(nullDim+1) = 1
      newdelta(nullDim+1) = 1
     
     end
  end    
 
% TEST : Logical & physical coordinates from Chuck's example
% x = [250,30,100,10] ;
% gridsize = x ; 

% Grid definition 
  grid = beta.javaseis.grid.GridDefinition.standardGrid(1,gridsize,neworigin,newdelta,neworigin,newdelta) ;
%  grid = beta.javaseis.grid.GridDefinition.standardGrid(1,gridsize,neworigin,newdelta,neworigin,newdelta) ;
% grid = beta.javaseis.grid.GridDefinition.standardGrid(1,gridsize,[0,1,1,1],[4,4,1,2],[0,0,0,0],[4,100,25,50])

% Create the JS header / dataset 
seisio = beta.javaseis.io.Seisio(dirname,grid);

% Create the file struture: allocate/construct the corresponding objects 
seisio.create();

end

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
import java.io.RandomAccessFile.* ;

% Make Directory
 if isdir(dirname) 
    rmdir(dirname,'s'); 
 end
 status = mkdir(dirname);
 assert(status,'Fatal error while creating directory %s',dirname);
 
% Create a brand new file for serial I/O in dirname
% Make sure the working directory is in your $PATH
delete('TraceFile');
java.io.RandomAccessFile('TraceFile','rw');

% Define logical & physical coordinates
% Need to Convert Header - MAT 2 JS 
% neworigin = convert2JS(header.dims) ;
% newdelta = convert2JS(header.delta) ;

% TEST : Manual logical & physical coordinates
x = [250,30,100,10] ;
gridsize = x ; 
origin = header.origin ;
delta = header.delta ;
neworigin = origin ;
newdelta = delta ;

% Grid definition 
%grid = beta.javaseis.grid.GridDefinition.standardGrid(1,gridsize,origin,delta,neworigin,newdelta) ;
grid = beta.javaseis.grid.GridDefinition.standardGrid(1,gridsize,[0,1,1,1],[4,4,1,2],[0,0,0,0],[4,100,25,50])

% Create the dataset 
seisio = beta.javaseis.io.Seisio(dirname,grid);

% Create the file struture: allocate/construct the corresponding objects 
seisio.create();

end

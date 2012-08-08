function FileAlloc(dirname,header)
%FILEALLOC Allocates file space for header
%
%   FileAlloc(DIRNAME,HEADER) allocates file for serial header writing.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the distribution
%

error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
%assert(isstruct(header), 'header must be a header struct')
%assert(header.distributed==0,'header have file distribution for serial file alloc?')

% Add dynamic libraries
% javaaddpath('$Path/dhale-jtk-78bca79.jar');
% javaaddpath('$Path/betajavaseis1819.jar');

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
 
% %Write file
% DataContainer.io.memmap.serial.DataAlloc(dirname,'real',header.size,header.precision);
% if header.complex
%     DataContainer.io.memmap.serial.DataAlloc(dirname,'imag',header.size,header.precision);
% end
% %Write header
% DataContainer.io.memmap.serial.HeaderWrite(dirname,header);

% Create a brand new file for serial I/O in dirname
delete('TraceFile');
java.io.RandomAccessFile('TraceFile','rw');

% Convert header - MAT 2 JS 
% neworigin = convert2JS(header.dims) ;
% newdelta = convert2JS(header.delta) ;

% Define physical coordinates from logical coordinates

% No need to go further as long as the above points are not fixed

% Grid definition 
grid = beta.javaseis.grid.GridDefinition.standardGrid(1,header.size,neworigin,newdelta,neworigin,newdelta) ;

% Create the dataset 
seisio = beta.javaseis.io.Seisio(dirname,grid);

% Create the file struture: allocate/construct the corresponding objects 
seisio.create();

end

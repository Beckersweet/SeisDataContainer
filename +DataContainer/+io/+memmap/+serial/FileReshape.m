function FileReshape(dirnameIn,dirnameOut,shape)
%FILERESHAPE Reshape the data to desired shape
%
%   FileReshape(DIRNAMEIN,DIRNAMEOUT,SHAPE)
%   Changes the size parameter in input header to SHAPE and writes in the
%   output directory.
%
%   DIRNAMEIN  - A string specifying the input directory
%   DIRNAMEOUT - A string specifying the output directory
%   SHAPE      - A vector specifying the new shape size

error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirnameIn), 'input directory name must be a string')
assert(isdir(dirnameIn),'Fatal error: input directory %s does not exist',dirnameIn);
assert(ischar(dirnameOut), 'output directory name must be a string')
assert(isvector(shape), 'shape must be a vector')

% Read header
headerOut = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);

% Making sure the new shape has the same length
assert(isequal(prod(shape),prod(headerOut.size)),...
    'The new shape should have the same length as the original size')

% Changing shape
headerOut.size = shape;

% Writing to output directory
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);

end

function FileTranspose(dirnameIn,dirnameOut,sepDim)
%DATATRANSPOSE Transposes input data and writes it to output file
%
%   FileTranspose(dirIn,dirOut,SEPDIM)
%   allocates binary file for serial data writing.
%
%   dirIn  - A string specifying the input directory
%   dirOut - A string specifying the output directory
%   SEPDIM - A scalar specifying the separation dimension
%
%   Warning: If the specified output file already exists, it will be 
%            overwritten.

import SeisDataContainer.io.*
import SeisDataContainer.io.NativeBin.serial.*

isFileClean(dirIn);
isFileClean(dirOut);
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirIn), 'input directory name must be a string')
assert(isdir(dirIn),'Fatal error: input directory %s does not exist',dirIn);
assert(ischar(dirOut), 'output directory name must be a string')
assert(isscalar(sepDim), 'dimensions must be given as a vector')

% Read header
headIn = HeaderRead(dirIn);

% Making the transpose vector
dim2D    = [prod(headIn.size(1:sepDim)) prod(headIn.size(sepDim+1:end))];

% Setting up the output header
headOut        = headIn;
headOut.size   = [headIn.size(  sepDim+1:end) headIn.size(  1:sepDim)];
headOut.origin = [headIn.origin(sepDim+1:end) headIn.origin(1:sepDim)];
headOut.delta  = [headIn.delta( sepDim+1:end) headIn.delta( 1:sepDim)];
headOut.unit   = [headIn.unit(  sepDim+1:end) headIn.unit(  1:sepDim)];
headOut.label  = [headIn.label( sepDim+1:end) headIn.label( 1:sepDim)];
HeaderWrite(dirOut,headOut);

% Transpose file
SeisDataContainer.io.NativeBin.serial.FileAlloc(dirnameOut,headerOut);
SeisDataContainer.io.setFileDirty(dirnameOut);
SeisDataContainer.io.NativeBin.serial.DataTranspose(dirnameIn,dirnameOut,'real',...
    dim2D,headerOut.precision);
if headerOut.complex
    SeisDataContainer.io.NativeBin.serial.DataTranspose(dirnameIn,dirnameOut,'imag',...
        dim2D,headerOut.precision);
end
SeisDataContainer.io.setFileClean(dirnameOut);

end

function FileTranspose(dirnameIn,dirnameOut,sepDim)
%DATATRANSPOSE Transposes input data and writes it to output file
%
%   FileTranspose(DIRNAMEIN,DIRNAMEOUT,SEPDIM)
%   allocates binary file for serial data writing.
%
%   DIRNAMEIN  - A string specifying the input directory
%   DIRNAMEOUT - A string specifying the output directory
%   SEPDIM     - A scalar specifying the separation dimension
%
%   Warning: If the specified output file already exists, it will be overwritten.
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirnameIn), 'input directory name must be a string')
assert(isdir(dirnameIn),'Fatal error: input directory %s does not exist',dirnameIn);
assert(ischar(dirnameOut), 'output directory name must be a string')
assert(isscalar(sepDim), 'dimensions must be given as a vector')

% Read header
headerIn = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);

% Making the transpose vector
dim2D = [prod(headerIn.size(1:sepDim)) prod(headerIn.size(sepDim+1:end))];

% Setting up the output header
headerOut = headerIn;
headerOut.size = [headerIn.size(sepDim+1:end) headerIn.size(1:sepDim)];
headerOut.offset = [headerIn.offset(sepDim+1:end) headerIn.offset(1:sepDim)];
headerOut.interval = [headerIn.interval(sepDim+1:end) headerIn.interval(1:sepDim)];
headerOut.unit = [headerIn.unit(sepDim+1:end) headerIn.unit(1:sepDim)];
headerOut.label = [headerIn.label(sepDim+1:end) headerIn.label(1:sepDim)];
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);

% Transpose file
if(headerOut.complex)
    DataContainer.io.memmap.serial.DataTranspose(dirnameIn,dirnameOut,'complex',...
        dim2D,headerOut.precision);
else
    DataContainer.io.memmap.serial.DataTranspose(dirnameIn,dirnameOut,'real',...
    dim2D,headerOut.precision);
end % if

end
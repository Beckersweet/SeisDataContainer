<<<<<<< HEAD
function FileTranspose(dirnameIn,dirnameOut,sepDim)%DATATRANSPOSE Transposes input data and writes it to output file%%   FileTranspose(DIRNAMEIN,DIRNAMEOUT,SEPDIM)%   allocates binary file for serial data writing.%%   DIRNAMEIN  - A string specifying the input directory%   DIRNAMEOUT - A string specifying the output directory%   SEPDIM     - A scalar specifying the separation dimension%%   Warning: If the specified output file already exists, it will be overwritten.error(nargchk(3, 3, nargin, 'struct'));assert(ischar(dirnameIn), 'input directory name must be a string')assert(isdir(dirnameIn),'Fatal error: input directory %s does not exist',dirnameIn);assert(ischar(dirnameOut), 'output directory name must be a string')assert(isscalar(sepDim), 'dimensions must be given as a vector')% Read headerheaderIn  = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);headerOut = headerIn;% Making the transpose vectorspmd    dim2D = [prod(headerOut.distribution.size{labindex}(1:sepDim)) prod(headerOut.distribution.size{labindex}(sepDim+1:end))];end% Setting up the output headerdistdim            = headerOut.size(headerOut.distribution.dim+1:end);headerOut.size     = [headerOut.size(sepDim+1:end) headerOut.size(1:sepDim)];headerOut          = DataContainer.io.addDistFileHeaderStruct(headerOut);headerOut.origin   = [headerOut.origin(sepDim+1:end) headerOut.origin(1:sepDim)];headerOut.delta    = [headerOut.delta(sepDim+1:end) headerOut.delta(1:sepDim)];headerOut.unit     = [headerOut.unit(sepDim+1:end) headerOut.unit(1:sepDim)];headerOut.label    = [headerOut.label(sepDim+1:end) headerOut.label(1:sepDim)];partition          = DataContainer.utils.defaultDistribution(headerOut.size(distdim));headerOut          = DataContainer.addDistHeaderStruct(headerOut,headerOut.dims,partition);DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);% Allocate fileDataContainer.io.memmap.dist.DataAlloc(headerOut.directories,'real',...    headerOut.distribution.size,headerOut.precision);if headerOut.complex    DataContainer.io.memmap.dist.DataAlloc(headerOut.directories,'imag',...        headerOut.distribution.size,headerOut.precision);end% Transpose fileDataContainer.io.memmap.dist.DataTranspose(dirnameIn,dirnameOut,'real',...    dim2D,sepDim,headerOut.precision);if headerOut.complex    DataContainer.io.memmap.dist.DataTranspose(dirnameIn,dirnameOut,...        'imag',dim2D,sepDim,headerOut.precision);endend
=======
function FileTranspose(dirnameIn,dirnameOut,distdirnameOut,sepDim)
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
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirnameIn), 'input directory name must be a string')
assert(isdir(dirnameIn),'Fatal error: input directory %s does not exist',dirnameIn);
assert(ischar(dirnameOut), 'output directory name must be a string')
assert(iscell(distdirnameOut), 'distributed output directories names must form cell')
assert(isscalar(sepDim), 'dimensions must be given as a vector')

% Read header
headerIn  = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);
headerOut = headerIn;

% Making the transpose vector
spmd
    dim2D = [prod(headerOut.distribution.size{labindex}(1:sepDim)) prod(headerOut.distribution.size{labindex}(sepDim+1:end))];
end
% Setting up the output header
distdim            = headerOut.size(headerOut.distribution.dim+1:end);
headerOut.size     = [headerOut.size(sepDim+1:end) headerOut.size(1:sepDim)];
headerOut          = DataContainer.io.addDistFileHeaderStruct(headerOut,distdirnameOut);
headerOut.offset   = [headerOut.offset(sepDim+1:end) headerOut.offset(1:sepDim)];
headerOut.interval = [headerOut.interval(sepDim+1:end) headerOut.interval(1:sepDim)];
headerOut.unit     = [headerOut.unit(sepDim+1:end) headerOut.unit(1:sepDim)];
headerOut.label    = [headerOut.label(sepDim+1:end) headerOut.label(1:sepDim)];
partition          = DataContainer.utils.defaultDistribution(headerOut.size(distdim));
headerOut          = DataContainer.addDistHeaderStruct(headerOut,headerOut.dims,partition);
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);

% Allocate file
DataContainer.io.memmap.dist.DataAlloc(headerOut.directories,'real',...
    headerOut.distribution.size,headerOut.precision);
if headerOut.complex
    DataContainer.io.memmap.dist.DataAlloc(headerOut.directories,'imag',...
        headerOut.distribution.size,headerOut.precision);
end

% Transpose file
DataContainer.io.memmap.dist.DataTranspose(dirnameIn,dirnameOut,'real',...
    dim2D,sepDim,headerOut.precision);
if headerOut.complex
    DataContainer.io.memmap.dist.DataTranspose(dirnameIn,dirnameOut,...
        'imag',dim2D,sepDim,headerOut.precision);
end
end
>>>>>>> origin/master

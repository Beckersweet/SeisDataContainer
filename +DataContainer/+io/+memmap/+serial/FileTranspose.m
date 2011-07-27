function FileTranspose(dirnameIn,dirnameOut,sepDim)
%DATATRANSPOSE Transposes input data and writes it to output file
%
%   FileTranspose(DIRNAMEIN,DIRNAMEOUT,FILE_PRECISION)
%   allocates binary file for serial data writing.
%
%   FILEIN         - A string specifying the input file name
%   FILEOUT        - A string specifying the output file name
%   DIMENSIONS     - A vector specifying the dimensions
%   FILE_PRECISION - An string specifying the file_precision of one unit of data,
%                    Supported precisions: 'double' or 'single'
%
%   Warning: If the specified output file already exists, it will be overwritten.
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirnameIn), 'input directory name must be a string')
assert(isdir(dirnameIn),'Fatal error: input directory %s does not exist',dirname);
assert(ischar(dirnameOut), 'output directory name must be a string')
assert(isscalar(sepDim), 'dimensions must be given as a vector')

% Read header
headerIn = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);

% Making the transpose vector
dim2D = [prod(headerIn.size(1:sepDim)) prod(headerIn.size(sepDim+1:end))];

% Making the output header
headerOut = DataContainer.io.basicHeaderStruct(...
    [headerIn.size(sepDim+1:end) headerIn.size(1:sepDim)], headerIn.precision, headerIn.complex);

% Transpose file
if(header.complex)
    DataContainer.io.memmap.serial.DataTranspose(dirnameIn,dirnameOut,'complex',...
        dim2D,headerOut.precision);
else
    DataContainer.io.memmap.serial.DataTranspose(dirnameIn,dirnameOut,'real',...
    dim2D,headerOut.precision);
end
end
function DataTranspose(dirnameIn,dirnameOut,filename,dimensions,sepDim,file_precision)
%DATATRANSPOSE Transposes input data and writes it to output file
%
%   DataTranspose(DIRNAMEIN,DIRNAMEOUT,FILENAME,DIMENSIONS,FILE_PRECISION)
%   allocates binary file for serial data writing.
%
%   DIRNAMEIN      - A string specifying the input directory
%   DIRNAMEOUT     - A string specifying the output directory
%   FILENAME       - A string specifying the file name 
%   DIMENSIONS     - A vector specifying the dimensions
%   SEPDIM         - A scalar specifying the separation dimension
%   FILE_PRECISION - An string specifying the file_precision of one unit
%                    of data. Supported precisions: 'double' or 'single'
%
%   Warning: If the specified output file already exists, it will be overwritten.
error(nargchk(6, 6, nargin, 'struct'));
assert(isdir(dirnameIn), 'input directory does not exist')
assert(isdir(dirnameOut), 'input directory does not exist')
assert(ischar(filename), 'output file name/directory should be string');
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(ischar(file_precision), 'file_precision must be a string');

% Set byte size
bytesize = SDCpckg.utils.getByteSize(file_precision);

headerIn  = SDCpckg.io.NativeBin.serial.HeaderRead(dirnameIn);
headerOut = SDCpckg.io.NativeBin.serial.HeaderRead(dirnameOut);

% size = prod(dimensions);
dirname = SDCpckg.utils.Cell2Composite(headerOut.directories);

for i=1:matlabpool('size')
    out  = fullfile(dirname{i},filename);
    fidw(i) = fopen(out,'r+');
end
spmd       
    in   = fullfile(headerIn.directories{labindex},filename);
    % Opening input file for reading and output file for writing
    fidr = fopen(in,'r');
end

% Calculating the relative share of each output file!
parts    = headerOut.distribution.partition;
sumParts = sum(parts(:));
parts    = parts * (prod(headerIn.size(1:sepDim))/sumParts);
for l = 1:length(parts)
    parts(l) = sum(parts(1:l));
end

% Transpose
for i=1:prod(headerIn.size(1:sepDim))
    spmd
        % Setting the pointer to the start of each row
        fseek(fidr,(i-1)*bytesize,'bof');
        for j=1:dimensions(2)
            % Read one row
            row(j) = fread(fidr,1,file_precision,(dimensions(1)-1)*bytesize);
        end        
    end
    % Decide which file will get the next row based on their share!
    for k=1:length(parts)
        if(i <= parts(k))
            index = k;
            break;
        end
    end
    % Writing the row to output file, which will be a column in output file
    fwrite(fidw(index),[row{:}],file_precision);
    clear row;
end
% Closing all output files
for i=1:matlabpool('size')
    fclose(fidw(i));
end
end

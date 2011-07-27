function DataTranspose(dirIn,dirOut,filename,dimensions,file_precision)
%DATATRANSPOSE Transposes input data and writes it to output file
%
%   DataTranspose(DIRIN,DIROUT,FILENAME,DIMENSIONS,FILE_PRECISION)
%   allocates binary file for serial data writing.
%
%   DIRIN          - A string specifying the input directory
%   DIROUT         - A string specifying the output directory
%   FILENAME       - A string specifying the file name 
%   DIMENSIONS     - A vector specifying the dimensions
%   FILE_PRECISION - An string specifying the file_precision of one unit of data,
%                    Supported precisions: 'double' or 'single'
%
%   Warning: If the specified output file already exists, it will be overwritten.
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(fileIn), 'input file name/directory should be string')
assert(ischar(fileOut), 'output file name/directory should be string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(ischar(file_precision), 'file_precision must be a string')

size = prod(dimensions);
dirIn = fullfile(dirIn,filename);
dirOut = fullfile(dirOut,filename);

% Allocating output file
DataContainer.io.allocFile(fileOut,size,file_precision);

% Opening input file for reading and output file for writing
fidr = fopen(dirIn,'r');
fidw = fopen(dirOut,'w');

for i=1:dimensions(1)
    % Setting the pointer to the start of each row
    fseek(fidr, (i-1)*file_precision, 'bof');
    for j=1:dimensions(2)
        % Read one row
        a(j) = fread(fidr, 1, file_precision, (dimensions(1)-1)*file_precision);
    end
    % Write the row to output file
    fwrite(fidw, a, file_precision);
    clear a;
end

% Closing both input and output file
fclose(fidr);
fclose(fidw);

end
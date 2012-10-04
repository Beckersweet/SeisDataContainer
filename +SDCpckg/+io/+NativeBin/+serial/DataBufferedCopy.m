function x = DataBufferedCopy(dirin,dirout,filename,posin,posout,ecount,precision)
%DATAREADLEFTSLICE Reads left slice from binary file
%
%   X = DataReadLeftSlice(dirin,dirout,filename,posin,posout,ecount,precision)
%   copies contigous data block from DIRIN/FILENAME to DIROUT/FILENAME.
%   The copy is buffered using SDCbufferSize.
%
%   DIRIN     - A string specifying the input directory name
%   DIROUT    - A string specifying the output directory name
%   FILENAME  - A string specifying the file name
%   POSIN     - An integer specifying the block starting position in input
%   POSOUT    - An integer specifying the block starting position in output
%   ECOUNT    - An integer specifying the # of elements to copy
%   PRECISION - A string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
error(nargchk(7, 7, nargin, 'struct'));
assert(ischar(dirin), 'DIRIN name must be a string')
assert(ischar(dirout), 'DIROUT name must be a string')
assert(ischar(filename), 'FILENAME must be a string')
assert(isscalar(posin), 'POSIN must be a scalar')
assert(isscalar(posout), 'POSOUT must be a scalar')
assert(isscalar(ecount), 'ECOUNT must be a scalar')
assert(ischar(precision), 'PRECISION name must be a string')

% Prepare Files
filein=fullfile(dirin,filename);
assert(exist(filein)==2,'Fatal error: file %s does not exist',filein);
fileout=fullfile(dirout,filename);
assert(exist(fileout)==2,'Fatal error: file %s does not exist',fileout);

% Set bytesize
bytesize = SDCpckg.utils.getByteSize(precision);
byte_origin_in = posin*bytesize;
byte_origin_out = posout*bytesize;

% Open files and skip to position
fin = fopen(filein,'r');
fseek(fin,byte_origin_in,-1);
fout = fopen(fileout,'r+');
fseek(fout,byte_origin_out,-1);

% Read/Write buffers
global SDCbufferSize;
ebuffer = SDCbufferSize/bytesize;
reminder = ecount;
while (reminder > 0)
    ebuffer = min(ebuffer,reminder);
    x = fread(fin,ebuffer,precision);
    fwrite(fout,x,precision);
    reminder = reminder - ebuffer;
end

% Close Files
fclose(fin);
fclose(fout);

end

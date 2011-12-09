function FileSign(dirnameIn,dirnameOut)
%FILESIGN Allocates file space finds the sign of the input file
%
%   FileSign(DIRNAMEIN,DIRNAMEOUT)
%
%   DIRNAMEIN  - A string specifying the input directory name
%   DIRNAMEOUT - A string specifying the output directory name
% 
if(~isdir(dirnameIn))
    error('Error: Directory does not exist')
end

global SDCbufferSize;
headerIn     = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);

% Set byte size
bytesize     = DataContainer.utils.getByteSize(headerIn.precision);

DataContainer.io.memmap.serial.FileAlloc(dirnameOut,headerIn);
header       = headerIn;
header.size  = [1 prod(headerIn.size)];
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,header);

% Set the sizes
dims         = [1 prod(headerIn.size)];
reminder     = prod(headerIn.size);
maxbuffer    = SDCbufferSize/bytesize;
rstart       = 1;

while (reminder > 0)
    buffer   = min(reminder,maxbuffer);
    rend     = rstart + buffer - 1;
    r1       = DataContainer.io.memmap.serial.DataReadLeftChunk...
        (dirnameIn,'real',dims,[rstart rend],[],headerIn.precision,...
        headerIn.precision);
    if headerIn.complex
    dummy    = DataContainer.io.memmap.serial.DataReadLeftChunk...
        (dirnameIn,'imag',dims,[rstart rend],[],headerIn.precision,...
        headerIn.precision);
        r1   = complex(r1,dummy);
    end
    DataContainer.io.memmap.serial.FileWriteLeftChunk...
        (dirnameOut,sign(r1),[rstart rend],[]);
    reminder = reminder - buffer;
    rstart   = rend + 1;
end
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerIn);
end

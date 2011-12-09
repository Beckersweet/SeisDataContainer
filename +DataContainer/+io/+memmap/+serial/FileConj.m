function FileConj(dirnameIn,dirnameOut)
%FILECONJ
%
%   FileConj(A,TD) allocates file and calculates the complex conjugate of
%   the input file. 
%
%   DIRNAMEIN   - A string specifying the input directory name
%   DIRNAMEOUT  - A string specifying the output directory name
%
global SDCbufferSize;
% Set byte size
header          = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);
bytesize        = DataContainer.utils.getByteSize(header.precision);
headerx         = header;
headerx.complex = 1;
headerx.size    = [1 prod(header.size)];
DataContainer.io.memmap.serial.FileAlloc(dirnameOut,headerx);
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerx);

% Set the sizes
sizez     = [1 prod(header.size)];
reminder  = prod(header.size);
maxbuffer = SDCbufferSize/bytesize;
rstart = 1;

while (reminder > 0)
    buffer = min(reminder,maxbuffer);
    rend   = rstart + buffer - 1;
    r1     = DataContainer.io.memmap.serial.DataReadLeftChunk...
        (dirnameIn,'real',sizez,[rstart rend],[],...
        header.precision,header.precision);
    if header.complex
    dummy  = DataContainer.io.memmap.serial.DataReadLeftChunk...
        (dirnameIn,'imag',sizez,[rstart rend],[],...
        header.precision,header.precision);
        r1 = complex(r1,dummy);
    end
    DataContainer.io.memmap.serial.FileWriteLeftChunk...
        (dirnameOut,conj(r1),[rstart rend],[]);
    reminder = reminder - buffer;
    rstart   = rend + 1;
end
headerx         = header;
headerx.complex = 1;
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerx);
end

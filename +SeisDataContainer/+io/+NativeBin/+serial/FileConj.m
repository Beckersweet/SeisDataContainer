function FileConj(dirnameIn,dirnameOut)
%FILECONJ
%
%   FileConj(DIRNAMEIN,DIRNAMEOUT) allocates file and calculates the 
%   complex conjugate of the input file. 
%
%   DIRNAMEIN   - A string specifying the input directory name
%   DIRNAMEOUT  - A string specifying the output directory name
%
global SDCbufferSize;
% Set byte size
header          = SeisDataContainer.io.NativeBin.serial.HeaderRead(dirnameIn);
bytesize        = SeisDataContainer.utils.getByteSize(header.precision);
headerx         = header;
headerx.complex = 1;
headerx.size    = [1 prod(header.size)];
SeisDataContainer.io.NativeBin.serial.FileAlloc(dirnameOut,headerx);
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirnameOut,headerx);

% Set the sizes
sizez     = [1 prod(header.size)];
reminder  = prod(header.size);
maxbuffer = SDCbufferSize/bytesize;
rstart = 1;

while (reminder > 0)
    buffer = min(reminder,maxbuffer);
    rend   = rstart + buffer - 1;
    r1     = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
        (dirnameIn,'real',sizez,[rstart rend],[],...
        header.precision,header.precision);
    if header.complex
    dummy  = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
        (dirnameIn,'imag',sizez,[rstart rend],[],...
        header.precision,header.precision);
        r1 = complex(r1,dummy);
    end
    SeisDataContainer.io.NativeBin.serial.FileWriteLeftChunk...
        (dirnameOut,conj(r1),[rstart rend],[]);
    reminder = reminder - buffer;
    rstart   = rend + 1;
end
headerx         = header;
headerx.complex = 1;
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirnameOut,headerx);
end

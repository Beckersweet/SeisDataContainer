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
header          = SDCpckg.io.NativeBin.serial.HeaderRead(dirnameIn);
bytesize        = SDCpckg.utils.getByteSize(header.precision);
headerx         = header;
headerx.complex = 1;
headerx.size    = [1 prod(header.size)];
SDCpckg.io.NativeBin.serial.FileAlloc(dirnameOut,headerx);
SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerx);

% Set the sizes
sizez     = [1 prod(header.size)];
reminder  = prod(header.size);
maxbuffer = SDCbufferSize/bytesize;
rstart = 1;

while (reminder > 0)
    buffer = min(reminder,maxbuffer);
    rend   = rstart + buffer - 1;
    r1     = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
        (dirnameIn,'real',sizez,[rstart rend],[],...
        header.precision,header.precision);
    if header.complex
    dummy  = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
        (dirnameIn,'imag',sizez,[rstart rend],[],...
        header.precision,header.precision);
        r1 = complex(r1,dummy);
    end
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk...
        (dirnameOut,conj(r1),[rstart rend],[]);
    reminder = reminder - buffer;
    rstart   = rend + 1;
end
headerx         = header;
headerx.complex = 1;
SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerx);
end

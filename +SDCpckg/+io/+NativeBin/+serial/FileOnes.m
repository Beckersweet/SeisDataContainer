function FileOnes(dirname,header)
%FILEONES Allocates file space containing ones
%   FileOnes( DIRNAME,HEADER ) allocates file for serial header writing.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the distribution
%  

SDCpckg.io.isFileClean(dirname);
global SDCbufferSize;
SDCpckg.io.NativeBin.serial.FileAlloc(dirname,header);

% Set byte size
bytesize  = SDCpckg.utils.getByteSize(header.precision);

xsize       = header.size;
header.size = [1 prod(xsize)];
SDCpckg.io.NativeBin.serial.HeaderWrite(dirname,header);

% Set the sizes
reminder  = prod(xsize);
maxbuffer = SDCbufferSize/bytesize;
rstart = 1;

while (reminder > 0)
    buffer = min(reminder,maxbuffer);
    rend = rstart + buffer - 1;
    r1 = ones(1,buffer);
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk...
        (dirname,r1,[rstart rend],[]);
    reminder = reminder - buffer;
    rstart   = rend + 1;
end
header.size = xsize;
SDCpckg.io.NativeBin.serial.HeaderWrite(dirname,header);
end

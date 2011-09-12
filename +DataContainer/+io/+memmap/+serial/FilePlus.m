function FilePlus(dirnameA,headerA,dirnameB,headerB,dirnameOut,headerOut)
%FILEPLUS Allocates file space and adds up the two input files
%   FileOnes(DIRNAMEA,HEADERA,DIRNAMEB,HEADERB,DIRNAMEOUT,HEADEROUT)
%
%   DIRNAMEA,DIRNAMEB - A string specifying the directory name of the input
%                       files
%   HEADERA, HEADERB  - Input file headers
%   DIRNAMEOUT        - A string specifying the output directory name
%   HEADEROUT         - Output header
%   
    global SDCbufferSize;
    DataContainer.io.memmap.serial.FileAlloc(dirnameOut,headerOut);
    
    % Set byte size
    bytesize  = DataContainer.utils.getByteSize(headerOut.precision);
    
    xsize       = headerOut.size;
    headerOut.size = [1 prod(xsize)];
    DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);
    
    % Set the sizes
    dims      = [1 prod(xsize)];
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart = 1;
    
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (dirnameA,'real',dims,[rstart rend],[],headerA.precision,...
            headerA.precision);
        if headerA.complex
        dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (dirnameA,'imag',dims,[rstart rend],[],headerA.precision,...
            headerA.precision);
            r1 = complex(r1,dummy);
        end
        r2 = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (dirnameB,'real',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
        if headerB.complex
        dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (dirnameB,'imag',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
            r2 = complex(r2,dummy);
        end
        DataContainer.io.memmap.serial.FileWriteLeftChunk...
            (dirnameOut,r1+r2,[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    headerOut.size = xsize;
    DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);
end


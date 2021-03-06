function FilePlus(A,B,dirnameOut)
%FILEPLUS Allocates file space and adds up the two input files
%   FilePlus(A,B,DIRNAMEOUT)
%
%   A,B        - Either string specifying the directory name of the input
%                files or a scalar
%   DIRNAMEOUT - A string specifying the output directory name
%    

SDCpckg.io.isFileClean(dirnameOut);
global SDCbufferSize;
    
if(isnumeric(B))
    temp = B;
    B    = A;
    A    = temp;
end
    
if isscalar(A)
    A = A*ones(size(B));
end
    
if(isnumeric(A))
    if(~isdir(B))
        error('Fail: Wrong input type')
    end
    SDCpckg.io.isFileClean(B);
    % Reading input headers
    headerB   = SDCpckg.io.NativeBin.serial.HeaderRead(B);
    headerOut = headerB;

    % Set byte size
    bytesize  = SDCpckg.utils.getByteSize(headerOut.precision);

    SDCpckg.io.NativeBin.serial.FileAlloc(dirnameOut,headerOut);
    xsize       = headerOut.size;
    headerOut.size = [1 prod(xsize)];
    SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerOut);

    % Set the sizes
    dims      = [1 prod(xsize)];
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;            
        r2 = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (B,'real',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
        if headerB.complex
        dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (B,'imag',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
            r2 = complex(r2,dummy);
        end
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk...
            (dirnameOut,plus(A(rstart:rend),r2),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    headerOut.size = xsize;
    SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerOut);        
elseif(isdir(A))
    if(~isdir(B))
        error('Fail: Wrong input type')
    end
    SDCpckg.io.isFileClean(A);
    SDCpckg.io.isFileClean(B);
    % Reading input headers
    headerA   = SDCpckg.io.NativeBin.serial.HeaderRead(A);
    headerB   = SDCpckg.io.NativeBin.serial.HeaderRead(B);
    if(headerA.size ~= headerB.size)
            error('Epic fail: The inputs does not have the same size')
    end
    headerOut = headerA;

    % Set byte size
    bytesize  = SDCpckg.utils.getByteSize(headerOut.precision);

    SDCpckg.io.NativeBin.serial.FileAlloc(dirnameOut,headerOut);
    xsize       = headerOut.size;
    headerOut.size = [1 prod(xsize)];
    SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerOut);

    % Set the sizes
    dims      = [1 prod(xsize)];
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (A,'real',dims,[rstart rend],[],headerA.precision,...
            headerA.precision);
        if headerA.complex
        dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (A,'imag',dims,[rstart rend],[],headerA.precision,...
            headerA.precision);
            r1 = complex(r1,dummy);
        end
        r2 = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (B,'real',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
        if headerB.complex
        dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (B,'imag',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
            r2 = complex(r2,dummy);
        end
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk...
            (dirnameOut,plus(r1,r2),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    headerOut.size = xsize;
    SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerOut);
else
    error('Fail: Wrong input type')
end
end



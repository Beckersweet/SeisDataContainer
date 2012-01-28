function FilePower(A,B,dirnameOut)
%FILEPOWER Calculates power(x,y) and writes it to output directory
%   FilePower(A,B,DIRNAMEOUT)
%
%   A,B        - Either string specifying the directory name of the input
%                files or a scalar
%   DIRNAMEOUT - A string specifying the output directory name
%

SeisDataContainer.io.isFileClean(dirnameOut);
global SDCbufferSize;

% Taking care of the complex part
if(isscalar(A))
    SeisDataContainer.io.isFileClean(B);
    % Allocating output file
    SeisDataContainer.io.memmap.serial.FileCopy(B,dirnameOut)

    % Reading headers
    headerB         = SeisDataContainer.io.memmap.serial.HeaderRead(B);
    headerOut       = headerB;
    xsize           = headerOut.size;
    headerOut.size  = prod(xsize);
    SeisDataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);
    
    % Set byte size
    bytesize  = SeisDataContainer.utils.getByteSize(headerOut.precision);

    % Set the sizes
    dims      = [1 prod(xsize)];
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r2 = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
            (B,'real',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
        if headerB.complex
        dummy = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
            (B,'imag',dims,[rstart rend],[],headerB.precision,...
            headerB.precision);
            r2 = complex(r2,dummy);
        end
        SeisDataContainer.io.memmap.serial.FileWriteLeftChunk...
            (dirnameOut,power(A,r2),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    headerOut.size = xsize;
    SeisDataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);
elseif(isdir(A))
    SeisDataContainer.io.isFileClean(A);
    if(isscalar(B))
        % Allocating output file
        SeisDataContainer.io.memmap.serial.FileCopy(A,dirnameOut)
        
        % Reading headers
        headerA         = SeisDataContainer.io.memmap.serial.HeaderRead(A);
        headerOut       = headerA;
        xsize           = headerOut.size;
        headerOut.size  = prod(xsize);
        SeisDataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);

        % Set byte size
        bytesize  = SeisDataContainer.utils.getByteSize(headerOut.precision);

        % Set the sizes
        dims      = [1 prod(xsize)];
        reminder  = prod(xsize);
        maxbuffer = SDCbufferSize/bytesize;
        rstart = 1;

        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            r1 = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
                (A,'real',dims,[rstart rend],[],headerA.precision,...
                headerA.precision);
            if headerA.complex
            dummy = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
                (A,'imag',dims,[rstart rend],[],headerA.precision,...
                headerA.precision);
                r1 = complex(r1,dummy);
            end
            SeisDataContainer.io.memmap.serial.FileWriteLeftChunk...
                (dirnameOut,power(r1,B),[rstart rend],[]);
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
        headerOut.size = xsize;
        SeisDataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);            
    elseif(isdir(B))
        SeisDataContainer.io.isFileClean(B);   
        % Reading headers
        headerA         = SeisDataContainer.io.memmap.serial.HeaderRead(A);
        headerB         = SeisDataContainer.io.memmap.serial.HeaderRead(B);
        if(headerA.size ~= headerB.size)
            error('Epic fail: The inputs does not have the same size')
        end
        headerOut       = headerA;
        xsize           = headerOut.size;
        headerOut.size  = prod(xsize);
            
        % Allocating output file
        SeisDataContainer.io.memmap.serial.FileCopy(A,dirnameOut)
        SeisDataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);

        % Set byte size
        bytesize  = SeisDataContainer.utils.getByteSize(headerOut.precision);

        % Set the sizes
        dims      = [1 prod(xsize)];
        reminder  = prod(xsize);
        maxbuffer = SDCbufferSize/bytesize;
        rstart = 1;

        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            r1 = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
                (A,'real',dims,[rstart rend],[],headerA.precision,...
                headerA.precision);
            if headerA.complex
            dummy = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
                (A,'imag',dims,[rstart rend],[],headerA.precision,...
                headerA.precision);
                r1 = complex(r1,dummy);
            end
            r2 = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
                (B,'real',dims,[rstart rend],[],headerB.precision,...
                headerA.precision);
            if headerA.complex
            dummy = SeisDataContainer.io.memmap.serial.DataReadLeftChunk...
                (B,'imag',dims,[rstart rend],[],headerB.precision,...
                headerA.precision);
                r2 = complex(r2,dummy);
            end
            SeisDataContainer.io.memmap.serial.FileWriteLeftChunk...
                (dirnameOut,power(r1,r2),[rstart rend],[]);
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
        headerOut.size = xsize;
        SeisDataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut); 
    else
        error('Wrong type of input for B')
    end
else
    error('Wrong type of input for A')
end    
end

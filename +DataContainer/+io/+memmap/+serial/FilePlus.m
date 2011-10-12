function FilePlus(A,B,dirnameOut)
%FILEPLUS Allocates file space and adds up the two input files
%   FilePlus(A,B,DIRNAMEOUT)
%
%   A,B        - Either string specifying the directory name of the input
%                files or a scalar
%   DIRNAMEOUT - A string specifying the output directory name
%    
    global SDCbufferSize;
    
    if(isnumeric(B))
        temp = B;
        B    = A;
        A    = temp;
    end
    
    if(isnumeric(A))
        if(~isdir(B))
            error('Fail: Wrong input type')
        end
        % Reading input headers
        headerB   = DataContainer.io.memmap.serial.HeaderRead(B);
        headerOut = headerB;

        % Set byte size
        bytesize  = DataContainer.utils.getByteSize(headerOut.precision);

        DataContainer.io.memmap.serial.FileAlloc(dirnameOut,headerOut);
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
            r2 = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (B,'real',dims,[rstart rend],[],headerB.precision,...
                headerB.precision);
            if headerB.complex
            dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (B,'imag',dims,[rstart rend],[],headerB.precision,...
                headerB.precision);
                r2 = complex(r2,dummy);
            end
            DataContainer.io.memmap.serial.FileWriteLeftChunk...
                (dirnameOut,plus(A(rstart:rend),r2),[rstart rend],[]);
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
        headerOut.size = xsize;
        DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);        
    elseif(isdir(A))
        if(~isdir(B))
            error('Fail: Wrong input type')
        end
        % Reading input headers
        headerA   = DataContainer.io.memmap.serial.HeaderRead(A);
        headerB   = DataContainer.io.memmap.serial.HeaderRead(B);
        if(headerA.size ~= headerB.size)
                error('Epic fail: The inputs does not have the same size')
        end
        headerOut = headerA;

        % Set byte size
        bytesize  = DataContainer.utils.getByteSize(headerOut.precision);

        DataContainer.io.memmap.serial.FileAlloc(dirnameOut,headerOut);
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
                (A,'real',dims,[rstart rend],[],headerA.precision,...
                headerA.precision);
            if headerA.complex
            dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (A,'imag',dims,[rstart rend],[],headerA.precision,...
                headerA.precision);
                r1 = complex(r1,dummy);
            end
            r2 = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (B,'real',dims,[rstart rend],[],headerB.precision,...
                headerB.precision);
            if headerB.complex
            dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (B,'imag',dims,[rstart rend],[],headerB.precision,...
                headerB.precision);
                r2 = complex(r2,dummy);
            end
            DataContainer.io.memmap.serial.FileWriteLeftChunk...
                (dirnameOut,plus(r1,r2),[rstart rend],[]);
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
        headerOut.size = xsize;
        DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);
    else
        error('Fail: Wrong input type')
    end
end


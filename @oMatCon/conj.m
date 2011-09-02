function y = conj(a)
    global SDCbufferSize;
    % Set byte size
    bytesize  = DataContainer.utils.getByteSize(a.header.precision);
    a.header.complex
    y = oMatCon.zeros(a.dimensions);
    header = a.header;
    header.complex = 1;
    DataContainer.io.memmap.serial.FileAlloc(y.dirname,header);
    header.size = [1 prod(a.header.size)];
    DataContainer.io.memmap.serial.HeaderWrite(y.dirname,header);
    
    % Set the sizes
    dims      = [1 prod(a.dimensions)];
    reminder  = prod(a.dimensions);
    maxbuffer = SDCbufferSize/bytesize;    
    rstart = 1;
    
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (a.dirname,'real',dims,[rstart rend],[],a.header.precision,a.header.precision);
        if a.header.complex
        dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (a.dirname,'imag',dims,[rstart rend],[],a.header.precision,a.header.precision);
            r1 = complex(r1,dummy);
        end
        DataContainer.io.memmap.serial.FileWriteLeftChunk...
            (y.dirname,conj(r1),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    header = a.header;
    header.complex = 1;
    DataContainer.io.memmap.serial.HeaderWrite(y.dirname,header);
    y.header.complex = 1;
end
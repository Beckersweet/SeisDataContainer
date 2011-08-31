function y = minus(a,b)
    if(~isa(a,'oCon') && ~isa(b,'oCon'))
        error('both parameters should be data containers')
    end
    
    if(~isequal(a.dimensions,b.dimensions))
        error('sizes do not match')
    end
    
    global SDCbufferSize;
    % Set byte size
    bytesize  = DataContainer.utils.getByteSize(a.header.precision);
    
    y = oMatCon.zeros(a.dimensions);
    header = a.header;
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
            r1 = complex(r,dummy);
        end
        r2 = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (b.dirname,'real',dims,[rstart rend],[],b.header.precision,b.header.precision);
        if b.header.complex
        dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (b.dirname,'imag',dims,[rstart rend],[],b.header.precision,b.header.precision);
            r2 = complex(r,dummy);
        end
        DataContainer.io.memmap.serial.FileWriteLeftChunk...
            (y.dirname,r1-r2,[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    DataContainer.io.memmap.serial.HeaderWrite(y.dirname,a.header);
end
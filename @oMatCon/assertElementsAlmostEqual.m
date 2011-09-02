function assertElementsAlmostEqual(a,b)
    if(~isa(a,'oCon') && ~isa(b,'iCon'))
        error('both parameters should be data containers')
    end
    
    if(~isequal(a.dimensions,b.dimensions))
        error('sizes does not match')
    end
    
    global SDCbufferSize;
    % Set byte size
    bytesize  = DataContainer.utils.getByteSize(a.header.precision);
    
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
        r2 = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (b.dirname,'real',dims,[rstart rend],[],b.header.precision,b.header.precision);
        if b.header.complex
        dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (b.dirname,'imag',dims,[rstart rend],[],b.header.precision,b.header.precision);
            r2 = complex(r2,dummy);
        end
        assertElementsAlmostEqual(r1,r2)
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
end


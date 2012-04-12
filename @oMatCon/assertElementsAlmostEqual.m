function assertElementsAlmostEqual(a,b)
global SDCbufferSize;
if(isa(a,'oCon') && isa(b,'oCon'))    
    if(~isequal(a.header.size,b.header.size))
        error('sizes does not match')
    end       
    % Set byte size
    bytesize  = SeisDataContainer.utils.getByteSize(a.header.precision);

    % Set the sizes
    dims      = [1 prod(a.header.size)];
    reminder  = prod(a.header.size);
    maxbuffer = SDCbufferSize/bytesize;    
    rstart = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = SeisDataContainer.io.NativeBin.serial.FileReadSequentialBuffer...
            (path(a.pathname),dims,[rstart rend],a.header.precision);
        r2 = SeisDataContainer.io.NativeBin.serial.FileReadSequentialBuffer...
            (path(b.pathname),dims,[rstart rend],a.header.precision);
        assertElementsAlmostEqual(r1,r2)
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
elseif(isa(a,'oCon') || isa(b,'oCon'))        
    if(isa(b,'oCon'))
        x = a;
        a = b;
        b = x;
    end
    % Set byte size
    bytesize  = SeisDataContainer.utils.getByteSize(a.header.precision);
    % Set the sizes
    dims      = [1 prod(a.header.size)];
    reminder  = prod(a.header.size);
    maxbuffer = SDCbufferSize/bytesize;    
    rstart    = 1;
    if(~isequal(a.header.size,size(b)))
        error('sizes does not match')
    end
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = SeisDataContainer.io.NativeBin.serial.FileReadSequentialBuffer...
            (path(a.pathname),dims,[rstart rend],a.header.precision);
        assertElementsAlmostEqual(r1,b(rstart:rend))
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
else
    error('At least one input should be oCon');
end    
end

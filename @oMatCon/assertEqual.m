function assertEqual(a,b)
    global SDCbufferSize;    
    if(isa(a,'oCon') && isa(b,'oCon'))
        % Set byte size
        bytesize  = DataContainer.utils.getByteSize(a.header.precision);
        % Set the sizes
        dims      = [1 prod(a.header.size)];
        reminder  = prod(a.header.size);
        maxbuffer = SDCbufferSize/bytesize;    
        rstart    = 1;
        if(~isequal(a.header.size,b.header.size))
            error('sizes does not match')
        end
        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            r1 = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (a.pathname,'real',dims,[rstart rend],[],a.header.precision,a.header.precision);
            if a.header.complex
            dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (a.pathname,'imag',dims,[rstart rend],[],a.header.precision,a.header.precision);
                r1 = complex(r1,dummy);
            end
            r2 = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (b.pathname,'real',dims,[rstart rend],[],b.header.precision,b.header.precision);
            if b.header.complex
            dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (b.pathname,'imag',dims,[rstart rend],[],b.header.precision,b.header.precision);
                r2 = complex(r2,dummy);
            end
            assert(isequal(r1,r2),'The datacontainers are not equal')
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
    else
        if(isa(b,'oCon'))
            x = a;
            a = b;
            b = x;
        end
        % Set byte size
        bytesize  = DataContainer.utils.getByteSize(a.header.precision);
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
            r1 = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (a.pathname,'real',dims,[rstart rend],[],a.header.precision,a.header.precision);
            if a.header.complex
            dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
                (a.pathname,'imag',dims,[rstart rend],[],a.header.precision,a.header.precision);
                r1 = complex(r1,dummy);
            end
            assert(isequal(r1,b(rstart:rend)),'Assertion failed')
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
        
    end
end
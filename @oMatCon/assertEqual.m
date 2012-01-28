function assertEqual(a,b)
% ASSERTEQUAL    assert equals the two inputs. Note that at least one input
% should be an oCon
%
global SDCbufferSize;    
if(isa(a,'oCon') && isa(b,'oCon'))
    % Set byte size
    bytesize  = SeisDataContainer.utils.getByteSize(a.header.precision);
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
        r1 = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (path(a.pathname),'real',dims,[rstart rend],[],a.header.precision,a.header.precision);
        if a.header.complex
        dummy = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (path(a.pathname),'imag',dims,[rstart rend],[],a.header.precision,a.header.precision);
            r1 = complex(r1,dummy);
        end
        r2 = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (path(b.pathname),'real',dims,[rstart rend],[],b.header.precision,b.header.precision);
        if b.header.complex
        dummy = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (path(b.pathname),'imag',dims,[rstart rend],[],b.header.precision,b.header.precision);
            r2 = complex(r2,dummy);
        end
        assert(isequal(r1,r2),'The datacontainers are not equal')
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
        r1 = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (path(a.pathname),'real',dims,[rstart rend],[],a.header.precision,a.header.precision);
        if a.header.complex
        dummy = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (path(a.pathname),'imag',dims,[rstart rend],[],a.header.precision,a.header.precision);
            r1 = complex(r1,dummy);
        end
        r1 = reshape(r1,size(b(rstart:rend)));
        assert(isequal(r1,b(rstart:rend)),'Assertion failed')
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
else
    error('At least one input should be an oCon');
end
end

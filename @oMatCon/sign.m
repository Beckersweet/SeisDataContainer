function y = sign(a)
    if(~isa(a,'oCon'))
        error('both parameters should be data containers')
    end
    
    global SDCbufferSize;
    % Set byte size
    bytesize  = DataContainer.utils.getByteSize(precision(a));
    
    y = oMatCon.zeros(size(a));
    if(~isreal(a))
        y = complex(y,0);
    end
    header = a.header;
    header.size = [1 prod(size(a))];
    DataContainer.io.memmap.serial.HeaderWrite(y.pathname,header);    
    
    % Set the sizes
    dims      = [1 prod(size(a))];
    reminder  = prod(size(a));
    maxbuffer = SDCbufferSize/bytesize;    
    rstart = 1;
    
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (a.pathname,'real',dims,[rstart rend],[],precision(a),precision(a));
        if ~isreal(a)
        dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (a.pathname,'imag',dims,[rstart rend],[],precision(a),precision(a));
            r1 = complex(r1,dummy);
        end        
        DataContainer.io.memmap.serial.FileWriteLeftChunk...
            (y.pathname,sign(r1),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    DataContainer.io.memmap.serial.HeaderWrite(y.pathname,a.header);
end

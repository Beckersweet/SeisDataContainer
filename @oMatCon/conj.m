function y = conj(a)
    global SDCbufferSize;
    % Set byte size
    bytesize  = DataContainer.utils.getByteSize(precision(a));
    y = oMatCon.zeros(size(a));
    header = a.header;
    header.complex = 1;
    DataContainer.io.memmap.serial.FileAlloc(y.pathname,header);
    header.size = [1 prod(size(a))];
    DataContainer.io.memmap.serial.HeaderWrite(y.pathname,header);
    
    % Set the sizes
    sizez      = [1 prod(size(a))];
    reminder  = prod(size(a));
    maxbuffer = SDCbufferSize/bytesize;    
    rstart = 1;
    
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (a.pathname,'real',sizez,[rstart rend],[],precision(a),precision(a));
        if ~isreal(a)
        dummy = DataContainer.io.memmap.serial.DataReadLeftChunk...
            (a.pathname,'imag',sizez,[rstart rend],[],precision(a),precision(a));
            r1 = complex(r1,dummy);
        end
        DataContainer.io.memmap.serial.FileWriteLeftChunk...
            (y.pathname,conj(r1),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    header = a.header;
    header.complex = 1;
    DataContainer.io.memmap.serial.HeaderWrite(y.pathname,header);
    y.header.complex = 1;
end
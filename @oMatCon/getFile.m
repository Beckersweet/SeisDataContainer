function y = getFile(obj,x)
%GETDATA is called whenever we try to access data via subreferencing
%
%   getData(OBJ,X)
%
%   OBJ - An oMatCon object
%   X   - Subreferences cell
    i = 0;
    while(cell2mat(x(i+1)) == ':')
        i = i+1;
    end
    
    chunk = cell2mat(x(i+1));
    chunk = [chunk(1) chunk(end)];
    
    if(length(x)>=i+2)
        slice = cell2mat(x(i+2:end));
    else
        slice = [];
    end
    
    y = DataContainer.io.memmap.serial.FileReadLeftChunk...
        (obj.dirname,[chunk(1) chunk(end)],slice);
end

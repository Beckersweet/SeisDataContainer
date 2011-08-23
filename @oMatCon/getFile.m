function y = getFile(obj,x)
%GETDATA is called whenever we try to access data via subreferencing
%
%   setData(OBJ,X)
%
%   OBJ - An oMatCon object
%   X   - Subreferences cell
%
    i=2;
    while(cell2mat(x(i+1)) == ':')
        i = i+1;
    end
    
    chunk = cell2mat(x(i));
    slice = cell2mat(x(i+1:end));
    y = DataContainer.io.memmap.serial.FileReadLeftChunk...
        (obj.dirname,[chunk(1) chunk(end)],slice);
    
    if(cell2mat(x(1)) ~= ':')
        y = y(cell2mat(x(1)),:);
    end
end

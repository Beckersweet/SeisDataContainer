function y = getFile(obj,x)
%GETDATA is called whenever we try to access data via subreferencing
%
%   getData(OBJ,X)
%
%   OBJ - An oMatCon object
%   X   - Subreferences cell
    if(cell2mat(x(1)) == ':')
        i=2;
        while(cell2mat(x(i+1)) == ':')
            i = i+1;
        end
    elseif(length(cell2mat(x(1))) > 1)
        i = 1;
    else
        error('Unsupported indexing: first element should either be a range (i:j where j>i) or a chunk (:) ')
    end
    
    chunk = cell2mat(x(i));
    slice = cell2mat(x(i+1:end));
    y = DataContainer.io.memmap.serial.FileReadLeftChunk...
        (obj.dirname,[chunk(1) chunk(end)],slice);
    
    if(cell2mat(x(1)) ~= ':')
        y = y(cell2mat(x(1)),:);
    end
end

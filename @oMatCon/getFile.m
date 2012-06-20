function y = getFile(obj,x)
%GETDATA is called whenever we try to access data via subreferencing
%
%   getData(OBJ,X)
%
%   OBJ - An oMatCon object
%   X   - Subreferences cell
%
if (length(x) == 1 && isnumeric(cell2mat(x(1))))
    error('Error: Single element indexing is not allowed in oMatCon')
elseif (length(x) == 1 && cell2mat(x(1)) == ':')
    y = vec(obj);
else
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

    % this gives us Matlab array
    y = SDCpckg.io.NativeBin.serial.FileReadLeftChunk...
        (path(obj.pathname),[chunk(1) chunk(end)],slice);

    % returning the result as iCon
    y = iCon(y);
end
end

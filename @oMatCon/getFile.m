function y = getFile(obj,s)
%GETDATA is called whenever we try to access data via subreferencing
%
%   getFile(x,s)
%
%   x - An oMatCon object
%   s - Subreferences cell
%

if (length(s) == 1 && isnumeric(cell2mat(s(1))))
    error('Error: Single element indexing is not allowed in oMatCon')
elseif (length(s) == 1 && cell2mat(s(1)) == ':')
    y = vec(obj);
else
    i = 0;
    while(cell2mat(s(i+1)) == ':')
        i = i+1;
    end

    chunk = cell2mat(s(i+1));
    chunk = [chunk(1) chunk(end)];

    if(length(s)>=i+2)
        slice = cell2mat(s(i+2:end));
    else
        slice = [];
    end

    % this gives us Matlab array
    y = SDCpckg.io.NativeBin.serial.FileReadLeftChunk...
        (path(obj.pathname),[chunk(1) chunk(end)],slice);

    % returning the result as iCon
    y = iCon(y);
end

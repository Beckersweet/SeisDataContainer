function putFile(obj,x,data)
%SETDATA is called whenever we assign data to an oMatCon
%
%   setData(X,DATA)
%
%   X    - Subreferences cell
%   DATA - The data we want to assign
%
%   Note that you cannot modify a read-only file!
    if(obj.readOnly)
        error('Epic Fail: Your file is read-only')
    else
        i=1;
        while(cell2mat(x(i)) == ':')
            i = i+1;
        end
        chunk = cell2mat(x(i));
        slice = cell2mat(x(i+1:end));
        DataContainer.io.memmap.serial.FileWriteLeftChunk...
            (obj.pathname,data,[chunk(1) chunk(end)],slice);
    end
end

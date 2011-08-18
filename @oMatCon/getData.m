function y = getData(obj,x)
%GETDATA is called whenever we try to access data via subreferencing
%
%   setData(OBJ,X)
%
%   OBJ - An oMatCon object
%   X   - Subreferences cell
%
    i=1;
    while(cell2mat(x(i)) == ':')
        i = i+1;
    end
    chunk = cell2mat(x(i));
    slice = cell2mat(x(i+1:end));
    y = DataContainer.io.memmap.serial.FileReadLeftChunk...
        (obj.dirnameIn,chunk,slice);
end


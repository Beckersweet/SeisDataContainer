function y = getData(obj,x)
%GETDATA Summary of this function goes here
%   Detailed explanation goes here
    i=1;
    while(cell2mat(x(i)) == ':')
        i = i+1;
    end
    chunk = cell2mat(x(i));
    slice = cell2mat(x(i+1:end));
    y = DataContainer.io.memmap.serial.FileReadLeftChunk...
        (obj.dirnameIn,chunk,slice);
end


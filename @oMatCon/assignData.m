function assignData(obj,x,data)
%ASSIGNDATA Summary of this function goes here
%   Detailed explanation goes here
    i=1;
    while(cell2mat(x(i)) == ':')
        i = i+1;
    end
    chunk = cell2mat(x(i));
    slice = cell2mat(x(i+1:end));
    DataContainer.io.memmap.serial.FileWriteLeftChunk...
        (obj.dirnameIn,data,[chunk(1) chunk(end)],slice);
end

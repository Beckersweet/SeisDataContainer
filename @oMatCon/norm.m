function x = norm(obj,norm)
    norm = cell2mat(norm);
    x = DataContainer.io.memmap.serial.FileNorm...
        (obj.dirname,obj.dimensions,norm,'double');
end


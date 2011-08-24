function disp(x)
    if(prod(x.dimensions)<2011)
        disp(DataContainer.io.memmap.serial.FileRead(x.dirname));
    else
        disp('Dear sir/madam you dont wanna display the entire data!!');
        disp('Make sure to put semicolon to avoid seeing this message');
    end
end


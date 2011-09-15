function disp(x)
%DISP Display array.
%   DISP(X) displays the array, without printing the array name.  In
%   all other ways it's the same as leaving the semicolon off an
%   expression except that empty arrays don't display.
    if(prod(x.dimensions)<2011)
        disp(DataContainer.io.memmap.serial.FileRead(x.dirname));
    else
        disp('Dear sir/madam you dont wanna display the entire data!!');
        disp('The current size limit for displaying data is 2011');
        disp('Make sure to put semicolon to avoid seeing this message');
    end
end


function save(obj,dirname)
%SAVE Saves the data container
%
%   save(dirname)
%
%   DIRNAME - The output directory name
%
%   Note that you cannot save in the same directory
    DataContainer.io.memmap.serial.FileCopy...
        (path(obj.pathname),cell2mat(dirname)); 
end


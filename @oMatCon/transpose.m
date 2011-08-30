function transpose(obj,dirnameOut,sepDim)
    DataContainer.io.memmap.serial.FileTranspose...
        (obj.dirname,dirnameOut,sepDim);
end
function y = reshape(x,varargin)
    shape = [varargin{:}];
    DataContainer.io.memmap.serial.FileReshape(x.dirname,x.dirname,shape)
    y = oMatCon.load(x.dirname);
end


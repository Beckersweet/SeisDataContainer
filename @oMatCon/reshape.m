function y = reshape(x,varargin)
    shape = [varargin{:}];
    DataContainer.io.memmap.serial.FileReshape(x.pathname,x.pathname,shape)
    y = oMatCon.load(x.pathname);
end


function y = reshape(x,varargin)
    shape = [varargin{:}];
    actualEnd = length(shape);
    if(shape(end) == 1)        
        for i = length(shape)-1:-1:1
            if(shape(i) == 1)
                actualEnd = actualEnd - 1;
            else
                break;
            end
        end
    end
    shape = shape(1:actualEnd);
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileCopy(x.pathname,td)
    DataContainer.io.memmap.serial.FileReshape(td,td,shape);
    y = oMatCon.load(td);
end


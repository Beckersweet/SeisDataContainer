function y = plus(a,b)
    if(~isa(a,'oMatCon') && ~isa(b,'oMatCon'))
        error('both parameters should be data containers')
    end
    
    if(~isequal(a.dimensions,b.dimensions))
        error('sizes do not match')
    end
    
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FilePlus...
        (a.dirname,b.dirname,td);
    y  = oMatCon.load(td);
end
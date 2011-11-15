function y = times(a,b)
    aa = a;
    bb = b;
    if(isa(a,'oMatCon'))
        aa = path(a.pathname);
    end
    if(isa(b,'oMatCon'))
        bb = path(b.pathname);
    end
    td = ConDir();
    DataContainer.io.memmap.serial.FileTimes...
        (aa,bb,path(td));
    y  = oMatCon.load(td);
end



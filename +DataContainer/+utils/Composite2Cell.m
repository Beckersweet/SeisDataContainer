function cl = Composite2Cell(co)
    L = length(co);
    assert(matlabpool('size')==L,'')
    cl = cell(1,L);
    for l=1:L
        cl{l} = co{l};
    end
end

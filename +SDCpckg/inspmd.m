function flag = inspmd()
    flag = matlabpool('size')==0;
    flag = flag && ~isempty(com.mathworks.toolbox.distcomp.pmode.SessionFactory.getCurrentSession)
end

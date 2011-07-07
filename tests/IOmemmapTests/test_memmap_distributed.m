function test_suite = test_memmap_distributed
initTestSuite;
end

function test_distributed_basicHeaderStruct_real
%%
    imat=distributed.rand(2,2,4);
    hdrb=DataContainer.io.basicHeaderStructFromX(imat);
    hdrx=DataContainer.io.addDistHeaderStructFromX(imat,hdrb);
    hdrd=DataContainer.io.addDistHeaderStruct(hdrx.distribution.dim,hdrx.distribution.partition,hdrb);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_distributed_basicHeaderStruct_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    hdrb=DataContainer.io.basicHeaderStructFromX(imat);
    hdrx=DataContainer.io.addDistHeaderStructFromX(imat,hdrb);
    hdrd=DataContainer.io.addDistHeaderStruct(hdrx.distribution.dim,hdrx.distribution.partition,hdrb);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_distributed_dataReadWrite_noDistribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_noDistribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_noDistribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_noDistribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_distribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_distribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_distribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_distribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_noDistribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_noDistribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    [x hdrn] = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadLeftSlice_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    for i=1:4
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i);
        assert(isequal(x,imat(:,:,i)))
    end    
    DataContainer.io.memmap.serial.FileDelete(td);    
end

function test_distributed_fileReadLeftSlice_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    for i=1:4
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i);
        assert(isequal(x,imat(:,:,i)))
    end    
    DataContainer.io.memmap.serial.FileDelete(td);    
end

function test_distributed_fileReadLeftSlice_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    for i=1:4
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i,'single');
        assert(isequal(x,single(imat(:,:,i))))
    end    
    DataContainer.io.memmap.serial.FileDelete(td);    
end

function test_distributed_fileReadLeftSlice_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    for i=1:4
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i,'single');
        assert(isequal(x,single(imat(:,:,i))))
    end    
    DataContainer.io.memmap.serial.FileDelete(td);    
end

function test_distributed_fileWriteLeftSlice_double_real
%%
    imat=distributed.rand(2,2,4);
    dmat=distributed.rand(2,2);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    for i=1:4
        DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i]);
        assert(isequal(x,dmat))
    end
    DataContainer.io.memmap.serial.FileDelete(td);    
end

function test_distributed_fileWriteLeftSlice_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    dmat=distributed.rand(2,2);
    dmat=complex(dmat,dmat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    for i=1:4
        DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i]);
        assert(isequal(x,dmat))
    end
    DataContainer.io.memmap.serial.FileDelete(td);    
end

function test_distributed_fileWriteLeftSlice_single_real
%%
    imat=distributed.rand(2,2,4);
    dmat=distributed.rand(2,2);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    for i=1:4
        DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i],'single');
        assert(isequal(x,single(dmat)))
    end
    DataContainer.io.memmap.serial.FileDelete(td);
end

function test_distributed_fileWriteLeftSlice_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    dmat=distributed.rand(2,2);
    dmat=complex(dmat,dmat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    for i=1:4
        DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
        [x hdrn] = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i],'single');
        assert(isequal(x,single(dmat)))
    end
    DataContainer.io.memmap.serial.FileDelete(td);
end   
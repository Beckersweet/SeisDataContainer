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
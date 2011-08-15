function test_suite = test_memmap_distributed
initTestSuite;
end

function test_distributed_basicHeaderStruct_real
%%
    imat=distributed.rand(2,2,4);
    hdrb=DataContainer.io.basicHeaderStructFromX(imat);
    hdrx=DataContainer.io.addDistHeaderStructFromX(hdrb,imat);
    hdrd=DataContainer.io.addDistHeaderStruct(hdrb,hdrx.distribution.dim,hdrx.distribution.partition);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_distributed_basicHeaderStruct_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    hdrb=DataContainer.io.basicHeaderStructFromX(imat);
    hdrx=DataContainer.io.addDistHeaderStructFromX(hdrb,imat);
    hdrd=DataContainer.io.addDistHeaderStruct(hdrb,hdrx.distribution.dim,hdrx.distribution.partition);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_distributed_dataReadWrite_noDistribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_noDistribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_noDistribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_noDistribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_distribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_distribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_distribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_distribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_noDistribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_noDistribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.serial.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    x = DataContainer.io.memmap.dist.FileRead(td);
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    x = DataContainer.io.memmap.dist.FileRead(td,'single');
    DataContainer.io.memmap.dist.FileDelete(td);
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadLeftSlice_double_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    i = randi(4);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i);
    assert(isequal(x,imat(:,:,i)))
    DataContainer.io.memmap.serial.FileDelete(td);
end

function test_distributed_fileReadLeftSlice_double_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    i = randi(4);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i);
    assert(isequal(x,imat(:,:,i)))
    DataContainer.io.memmap.serial.FileDelete(td);
end

function test_distributed_fileReadLeftSlice_single_real
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    i = randi(4);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i,'single');
    assert(isequal(x,single(imat(:,:,i))))
    DataContainer.io.memmap.serial.FileDelete(td);
end

function test_distributed_fileReadLeftSlice_single_complex
%%
    imat=distributed.rand(2,2,4);
    imat=complex(imat,imat);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    i = randi(4);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,i,'single');
    assert(isequal(x,single(imat(:,:,i))))
    DataContainer.io.memmap.serial.FileDelete(td);
end

function test_distributed_fileWriteLeftSlice_double_real
%%
    imat=distributed.rand(2,2,4);
    dmat=distributed.rand(2,2);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0);
    i = randi(4);
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i]);
    assert(isequal(x,dmat))
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
    i = randi(4);
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i]);
    assert(isequal(x,dmat))
    DataContainer.io.memmap.serial.FileDelete(td);
end

function test_distributed_fileWriteLeftSlice_single_real
%%
    imat=distributed.rand(2,2,4);
    dmat=distributed.rand(2,2);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,0,'single');
    i = randi(4);
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i],'single');
    assert(isequal(x,single(dmat)))
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
    i = randi(4);
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,dmat,[i]);
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[i],'single');
    assert(isequal(x,single(dmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
end

function test_distributed_fileDistribute
%%
    imat=rand(2,2,4);
    ts=DataContainer.io.makeDir();
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(ts,imat);
    i = randi(3);
    DataContainer.io.memmap.dist.FileDistribute(ts,td,i);
    x = DataContainer.io.memmap.dist.FileRead(td);
    assert(isequal(x,imat))
    DataContainer.io.memmap.dist.FileDelete(td);
    DataContainer.io.memmap.serial.FileDelete(ts);
end

function test_distributed_fileGather
%%
    imat=distributed.rand(2,2,4);
    td=DataContainer.io.makeDir();
    ts=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    DataContainer.io.memmap.dist.FileGather(td,ts);
    x = DataContainer.io.memmap.serial.FileRead(ts);
    assert(isequal(x,imat))
    DataContainer.io.memmap.dist.FileDelete(td);
    DataContainer.io.memmap.serial.FileDelete(ts);
end

function test_distributed_FileNorm_double_real
%%
    imat=distributed.rand(2,2,4,5,6);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],0,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),0))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],1,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),1))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],2,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),2))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],-inf,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),-inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],inf,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],'fro','double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),'fro'))
    DataContainer.io.memmap.dist.FileDelete(td);
end

function test_distributed_FileNorm_double_complex
%%
    imat=distributed.rand(2,2,4,5,6);
    imat=complex(imat,1);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1);
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],0,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),0))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],1,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),1))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],2,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),2))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],-inf,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),-inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],inf,'double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],'fro','double');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),'fro'))
    DataContainer.io.memmap.dist.FileDelete(td);
end

function test_distributed_FileNorm_single_real
%%
    imat=distributed.rand(2,2,4,5,6);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],0,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),0))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],1,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),1))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],2,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),2))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],-inf,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),-inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],inf,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],'fro','single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),'fro'))
    DataContainer.io.memmap.dist.FileDelete(td);
end

function test_distributed_FileNorm_single_complex
%%
    imat=distributed.rand(2,2,4,5,6);
    imat=complex(imat,1);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.dist.FileWrite(td,imat,1,'single');
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],0,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),0))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],1,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),1))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],2,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),2))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],-inf,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),-inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],inf,'single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),inf))
    x = DataContainer.io.memmap.dist.FileNorm(td,[2 2 4 5 6],'fro','single');
    assertElementsAlmostEqual(x,norm(vec(gather(imat)),'fro'))
    DataContainer.io.memmap.dist.FileDelete(td);
end
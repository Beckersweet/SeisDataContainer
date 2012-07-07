function test_suite = test_NativeBin_20_distributed
initTestSuite;
end

function test_distributed_fileReadWrite_noDistribute_double_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0);
    x    = SDCpckg.io.NativeBin.dist.FileRead(path(td));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0);
    x = SDCpckg.io.NativeBin.dist.FileRead(path(td));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_single_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    x = SDCpckg.io.NativeBin.dist.FileRead(path(td),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_noDistribute_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    x = SDCpckg.io.NativeBin.dist.FileRead(path(td),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_double_real
%%
    imat = distributed.rand(2,2,4);
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x = SDCpckg.io.NativeBin.dist.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x = SDCpckg.io.NativeBin.dist.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_single_real
%%
    imat = distributed.rand(2,2,4);
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x = SDCpckg.io.NativeBin.dist.FileRead(path(ts),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x = SDCpckg.io.NativeBin.dist.FileRead(path(ts),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadLeftSlice_double_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),i);
    assert(isequal(x,imat(:,:,i)))
end

function test_distributed_fileReadLeftSlice_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),i);
    assert(isequal(x,imat(:,:,i)))
end

function test_distributed_fileReadLeftSlice_single_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),i,'single');
    assert(isequal(x,single(imat(:,:,i))))
end

function test_distributed_fileReadLeftSlice_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),i,'single');
    assert(isequal(x,single(imat(:,:,i))))
end

function test_distributed_fileWriteLeftSlice_double_real
%%
    imat = distributed.rand(2,2,4);
    dmat = distributed.rand(2,2);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    SDCpckg.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),[i]);
    assert(isequal(x,dmat))
end

function test_distributed_fileWriteLeftSlice_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    dmat = distributed.rand(2,2);
    dmat = complex(dmat,dmat);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    SDCpckg.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),[i]);
    assert(isequal(x,dmat))
end

function test_distributed_fileWriteLeftSlice_single_real
%%
    imat = distributed.rand(2,2,4);
    dmat = distributed.rand(2,2);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    SDCpckg.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),[i],'single');
    assert(isequal(x,single(dmat)))
end

function test_distributed_fileWriteLeftSlice_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    dmat = distributed.rand(2,2);
    dmat = complex(dmat,dmat);
    td   = ConDir();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    SDCpckg.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SDCpckg.io.NativeBin.dist.FileReadLeftSlice(path(td),[i],'single');
    assert(isequal(x,single(dmat)))
end

function test_distributed_fileDistribute
%%
    imat  = rand(2,2,4);
    ts    = ConDir();
    td    = ConDir();
    tdist = ConDistDirs();
    SDCpckg.io.NativeBin.serial.FileWrite(path(ts),imat);
    i     = randi(3);
    SDCpckg.io.NativeBin.dist.FileDistribute(path(ts),path(td),path(tdist),i);
    x     = SDCpckg.io.NativeBin.dist.FileRead(path(td));
    assert(isequal(x,imat))
end

function test_distributed_fileGather
%%
    imat=distributed.rand(2,2,4);
    ts    = ConDir();
    td    = ConDir();
    tdist = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(td),imat,1,path(tdist));
    SDCpckg.io.NativeBin.dist.FileGather(path(td),path(ts));
    x     = SDCpckg.io.NativeBin.serial.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_FileNorm_double_real
%%
    imat = distributed.rand(2,2,4,5,6);
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),0);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),0))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),1);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),1))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),2);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),2))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),-inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),'fro');
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileNorm_double_complex
%%
    imat = distributed.rand(2,2,4,5,6);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),0);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),0))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),1);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),1))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),2);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),2))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),-inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),'fro');
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileNorm_single_real
%%
    imat = single(distributed.rand(2,2,4,5,6));
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),0);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),0))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),1);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),1))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),2);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),2))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),-inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),'fro');
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileNorm_single_complex
%%
    imat = single(distributed.rand(2,2,4,5,6));
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SDCpckg.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),0);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),0))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),1);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),1))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),2);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),2))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),-inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),inf);
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),inf))
    x    = SDCpckg.io.NativeBin.dist.FileNorm(path(ts),'fro');
    assertElementsAlmostEqual(x,norm(SDCpckg.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileTranspose_double_real
%%
    nn = [3 4 3 4];
    for t = 2:4
        tt = round(t/2);
        imat = randn(nn(1:t));
        td       = ConDir();
        tin      = ConDir();
        tDistIn  = ConDistDirs();
        tout     = ConDir();
        tDistOut = ConDistDirs();    
        tg       = ConDir();
        SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
        SDCpckg.io.NativeBin.dist.FileDistribute(path(td),path(tin),path(tDistIn),tt);
        SDCpckg.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut));
        SDCpckg.io.NativeBin.dist.FileGather(path(tout),path(tg));
        x    = SDCpckg.io.NativeBin.serial.FileRead(path(tg));
        imat = reshape(imat,[prod(nn(1:tt)) prod(nn(tt+1:t))]);
        imat = transpose(imat);
        imat = reshape(imat,[nn(tt+1:t) nn(1:tt)]);
        assertEqual(x,imat);
    end
    
end

function test_distributed_FileTranspose_double_complex
%%
    nn = [3 4 3 4];
    for t = 2:4
        tt = round(t/2);
        imat = randn(nn(1:t));
        imat = complex(imat,imat);
        td       = ConDir();
        tin      = ConDir();
        tDistIn  = ConDistDirs();
        tout     = ConDir();
        tDistOut = ConDistDirs();    
        tg       = ConDir();
        SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
        SDCpckg.io.NativeBin.dist.FileDistribute(path(td),path(tin),path(tDistIn),tt);
        SDCpckg.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut));
        SDCpckg.io.NativeBin.dist.FileGather(path(tout),path(tg));
        x    = SDCpckg.io.NativeBin.serial.FileRead(path(tg));
        imat = reshape(imat,[prod(nn(1:tt)) prod(nn(tt+1:t))]);
        imat = transpose(imat);
        imat = reshape(imat,[nn(tt+1:t) nn(1:tt)]);
        assertEqual(x,imat);
    end
    
end

function test_distributed_FileTranspose_single_real
%%
    nn = [3 4 3 4];
    for t = 2:4
        tt = round(t/2);
        imat = randn(nn(1:t));
        td       = ConDir();
        tin      = ConDir();
        tDistIn  = ConDistDirs();
        tout     = ConDir();
        tDistOut = ConDistDirs();    
        tg       = ConDir();
        SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat,'single');
        SDCpckg.io.NativeBin.dist.FileDistribute(path(td),path(tin),path(tDistIn),tt);
        SDCpckg.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut));
        SDCpckg.io.NativeBin.dist.FileGather(path(tout),path(tg));
        x    = SDCpckg.io.NativeBin.serial.FileRead(path(tg),'single');
        imat = reshape(imat,[prod(nn(1:tt)) prod(nn(tt+1:t))]);
        imat = transpose(imat);
        imat = reshape(imat,[nn(tt+1:t) nn(1:tt)]);
        assertEqual(x,single(imat));
    end
    
end
    
function test_distributed_FileTranspose_single_complex
%%
    nn = [3 4 3 4];
    for t = 2:4
        tt = round(t/2);
        imat = randn(nn(1:t));
        imat = complex(imat,imat);
        td       = ConDir();
        tin      = ConDir();
        tDistIn  = ConDistDirs();
        tout     = ConDir();
        tDistOut = ConDistDirs();    
        tg       = ConDir();
        SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat,'single');
        SDCpckg.io.NativeBin.dist.FileDistribute(path(td),path(tin),path(tDistIn),tt);
        SDCpckg.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut));
        SDCpckg.io.NativeBin.dist.FileGather(path(tout),path(tg));
        x    = SDCpckg.io.NativeBin.serial.FileRead(path(tg),'single');
        imat = reshape(imat,[prod(nn(1:tt)) prod(nn(tt+1:t))]);
        imat = transpose(imat);
        imat = reshape(imat,[nn(tt+1:t) nn(1:tt)]);
        assertEqual(x,single(imat));
    end
    
end

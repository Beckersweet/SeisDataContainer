function test_suite = test_NativeBin_distributed
initTestSuite;
end

function test_distributed_basicHeaderStruct_real
%%
    imat = distributed.rand(2,2,4);
    hdrb = SeisDataContainer.basicHeaderStructFromX(imat);
    hdrx = SeisDataContainer.addDistHeaderStructFromX(hdrb,imat);
    hdrd = SeisDataContainer.addDistHeaderStruct(hdrb,hdrx.distribution.dim,hdrx.distribution.partition);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_distributed_basicHeaderStruct_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    hdrb = SeisDataContainer.basicHeaderStructFromX(imat);
    hdrx = SeisDataContainer.addDistHeaderStructFromX(hdrb,imat);
    hdrd = SeisDataContainer.addDistHeaderStruct(hdrb,hdrx.distribution.dim,hdrx.distribution.partition);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_distributed_dataReadWrite_noDistribute_double_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(td));
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_noDistribute_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = SeisDataContainer.io.makeDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(td,imat,0);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(td);
    SeisDataContainer.io.NativeBin.serial.FileDelete(td);
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_noDistribute_single_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(td),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_noDistribute_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(td),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_distribute_double_real
%%
    imat = distributed.rand(2,2,4);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_distribute_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_dataReadWrite_distribute_single_real
%%
    imat = distributed.rand(2,2,4);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_dataReadWrite_distribute_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_noDistribute_double_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(td));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0);
    x = SeisDataContainer.io.NativeBin.dist.FileRead(path(td));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_noDistribute_single_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    x = SeisDataContainer.io.NativeBin.dist.FileRead(path(td),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_noDistribute_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    x = SeisDataContainer.io.NativeBin.dist.FileRead(path(td),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_double_real
%%
    imat = distributed.rand(2,2,4);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_fileReadWrite_distribute_single_real
%%
    imat = distributed.rand(2,2,4);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadWrite_distribute_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x = SeisDataContainer.io.NativeBin.dist.FileRead(path(ts),'single');
    assert(isequal(x,single(imat)))
end

function test_distributed_fileReadLeftSlice_double_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),i);
    assert(isequal(x,imat(:,:,i)))
end

function test_distributed_fileReadLeftSlice_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),i);
    assert(isequal(x,imat(:,:,i)))
end

function test_distributed_fileReadLeftSlice_single_real
%%
    imat = distributed.rand(2,2,4);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),i,'single');
    assert(isequal(x,single(imat(:,:,i))))
end

function test_distributed_fileReadLeftSlice_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),i,'single');
    assert(isequal(x,single(imat(:,:,i))))
end

function test_distributed_fileWriteLeftSlice_double_real
%%
    imat = distributed.rand(2,2,4);
    dmat = distributed.rand(2,2);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    SeisDataContainer.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),[i]);
    assert(isequal(x,dmat))
end

function test_distributed_fileWriteLeftSlice_double_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    dmat = distributed.rand(2,2);
    dmat = complex(dmat,dmat);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0);
    i    = randi(4);
    SeisDataContainer.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),[i]);
    assert(isequal(x,dmat))
end

function test_distributed_fileWriteLeftSlice_single_real
%%
    imat = distributed.rand(2,2,4);
    dmat = distributed.rand(2,2);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    SeisDataContainer.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),[i],'single');
    assert(isequal(x,single(dmat)))
end

function test_distributed_fileWriteLeftSlice_single_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    dmat = distributed.rand(2,2);
    dmat = complex(dmat,dmat);
    td   = ConDir();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,0,'single');
    i    = randi(4);
    SeisDataContainer.io.NativeBin.dist.FileWriteLeftSlice(path(td),dmat,[i]);
    x    = SeisDataContainer.io.NativeBin.dist.FileReadLeftSlice(path(td),[i],'single');
    assert(isequal(x,single(dmat)))
end

function test_distributed_fileDistribute
%%
    imat  = rand(2,2,4);
    ts    = ConDir();
    td    = ConDir();
    tdist = ConDistDirs();
    SeisDataContainer.io.NativeBin.serial.FileWrite(path(ts),imat);
    i     = randi(3);
    SeisDataContainer.io.NativeBin.dist.FileDistribute(path(ts),path(td),path(tdist),i);
    x     = SeisDataContainer.io.NativeBin.dist.FileRead(path(td));
    assert(isequal(x,imat))
end

function test_distributed_fileGather
%%
    imat=distributed.rand(2,2,4);
    ts    = ConDir();
    td    = ConDir();
    tdist = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(td),imat,1,path(tdist));
    SeisDataContainer.io.NativeBin.dist.FileGather(path(td),path(ts));
    x     = SeisDataContainer.io.NativeBin.serial.FileRead(path(ts));
    assert(isequal(x,imat))
end

function test_distributed_FileNorm_double_real
%%
    imat = distributed.rand(2,2,4,5,6);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],0,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),0))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],1,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),1))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],2,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),2))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],-inf,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],inf,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],'fro','double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileNorm_double_complex
%%
    imat = distributed.rand(2,2,4,5,6);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td));
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],0,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),0))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],1,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),1))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],2,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),2))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],-inf,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],inf,'double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],'fro','double');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileNorm_single_real
%%
    imat = distributed.rand(2,2,4,5,6);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],0,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),0))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],1,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),1))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],2,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),2))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],-inf,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],inf,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],'fro','single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileNorm_single_complex
%%
    imat = distributed.rand(2,2,4,5,6);
    imat = complex(imat,imat);
    ts   = ConDir();
    td   = ConDistDirs();
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(ts),imat,1,path(td),'single');
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],0,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),0))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],1,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),1))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],2,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),2))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],-inf,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),-inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],inf,'single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),inf))
    x    = SeisDataContainer.io.NativeBin.dist.FileNorm(path(ts),[2 2 4 5 6],'fro','single');
    assertElementsAlmostEqual(x,norm(SeisDataContainer.utils.vecNativeSerial(gather(imat)),'fro'))
end

function test_distributed_FileTranspose_double_real
%%
    display('  Warning: SeisDataContainer.io.NativeBin.dist.FileTranspose is not fully implemented')
    n1      = 3;
    n2      = 4;
    n3      = 5;
    n4      = 8;
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();    
    % 2D transpose
    imat = distributed.rand(n1,n2);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,transpose(imat));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 1
    imat = distributed.rand(n1,n2,n3);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,reshape(transpose(reshape(imat,n1,n2*n3)),n2,n3,n1));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 2
    imat = distributed.rand(n1,n2,n3);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),2);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,reshape(transpose(reshape(imat,n1*n2,n3)),n3,n1,n2));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 4D transpose with sepDim == 3
    imat = distributed.rand(n1,n2,n3,n4);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),3);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,reshape(transpose(reshape(imat,n1*n2*n3,n4)),n4,n1,n2,n3));
end

function test_distributed_FileTranspose_double_complex
%%
    display('  Warning: SeisDataContainer.io.NativeBin.dist.FileTranspose is not fully implemented')
    n1      = 3;
    n2      = 4;
    n3      = 5;
    n4      = 8;
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();    
    % 2D transpose
    imat = distributed.rand(n1,n2);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,transpose(imat));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 1
    imat = distributed.rand(n1,n2,n3);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,reshape(transpose(reshape(imat,n1,n2*n3)),n2,n3,n1));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 2
    imat = distributed.rand(n1,n2,n3);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),2);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,reshape(transpose(reshape(imat,n1*n2,n3)),n3,n1,n2));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 4D transpose with sepDim == 3
    imat = distributed.rand(n1,n2,n3,n4);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn));
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),3);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout));
    assertEqual(x,reshape(transpose(reshape(imat,n1*n2*n3,n4)),n4,n1,n2,n3));
end

function test_distributed_FileTranspose_single_real
%%
    display('  Warning: SeisDataContainer.io.NativeBin.dist.FileTranspose is not fully implemented')
    n1   = 3;
    n2   = 4;
    n3   = 5;
    n4   = 8;
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs(); 
    % 2D transpose
    imat = distributed.rand(n1,n2);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(transpose(imat)));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 1
    imat = distributed.rand(n1,n2,n3);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(reshape(transpose(reshape(imat,n1,n2*n3)),n2,n3,n1)));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 2
    imat = distributed.rand(n1,n2,n3);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),2);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(reshape(transpose(reshape(imat,n1*n2,n3)),n3,n1,n2)));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 4D transpose with sepDim == 3
    imat = distributed.rand(n1,n2,n3,n4);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),3);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(reshape(transpose(reshape(imat,n1*n2*n3,n4)),n4,n1,n2,n3)));
end

function test_distributed_FileTranspose_single_complex
%%
    display('  Warning: SeisDataContainer.io.NativeBin.dist.FileTranspose is not fully implemented')
    n1   = 3;
    n2   = 4;
    n3   = 5;
    n4   = 8;
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs(); 
    % 2D transpose
    imat = distributed.rand(n1,n2);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(transpose(imat)));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 1
    imat = distributed.rand(n1,n2,n3);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),1);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(reshape(transpose(reshape(imat,n1,n2*n3)),n2,n3,n1)));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 3D transpose with sepDim == 2
    imat = distributed.rand(n1,n2,n3);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),2);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(reshape(transpose(reshape(imat,n1*n2,n3)),n3,n1,n2)));
    
    tin      = ConDir();
    tDistIn  = ConDistDirs();
    tout     = ConDir();
    tDistOut = ConDistDirs();
    % 4D transpose with sepDim == 3
    imat = distributed.rand(n1,n2,n3,n4);
    imat = complex(imat,imat);
    SeisDataContainer.io.NativeBin.dist.FileWrite(path(tin),imat,1,path(tDistIn),'single');
    SeisDataContainer.io.NativeBin.dist.FileTranspose(path(tin),path(tout),path(tDistOut),3);
    x    = SeisDataContainer.io.NativeBin.dist.FileRead(path(tout),'single');
    assertEqual(x,single(reshape(transpose(reshape(imat,n1*n2*n3,n4)),n4,n1,n2,n3)));
end

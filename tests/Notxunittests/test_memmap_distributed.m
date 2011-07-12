function test_distributed()
assert(matlabpool('size')>0,'matlabpool has to be open first')
disp('Start');
I=13; J=11; K=9;
I=2; J=matlabpool('size')*1; K=matlabpool('size')*2;
imat3=distributed.rand(I,J,K);
imat3=complex(imat3,imat3);
spmd
    codistr = codistributor1d(2,codistributor1d.unsetPartition,[I J K]);
    myLocalPart = rand(I,1,K);
    imat2 = codistributed.build(myLocalPart, codistr);
end
td=DataContainer.io.makeDir()
tdo=DataContainer.io.makeDir()

hdrb=DataContainer.io.basicHeaderStructFromX(imat3);
hdrx=DataContainer.io.addDistHeaderStructFromX(hdrb,imat3);
hdrd=DataContainer.io.addDistHeaderStruct(hdrb,hdrx.distribution.dim,[]);
assert(isequal(hdrx,hdrd),'distributions do not match')

disp('serial')
DataContainer.io.memmap.dist.FileWrite(td,imat3,0);
[x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
for k=1:K
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(x,imat3(:,:,k)),'no match')
end
ls('-lR',td)
DataContainer.io.memmap.serial.FileDelete(td);

hdrs=DataContainer.io.basicHeaderStructFromX(imat3);
DataContainer.io.memmap.serial.FileAlloc(td,hdrs);
for k=1:K
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,imat2(:,:,k),[k])
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(imat2(:,:,k),x))
end
ls('-lR',td)
DataContainer.io.memmap.dist.FileDistribute(td,tdo,1);
ls('-lR',td)
DataContainer.io.memmap.dist.FileDistribute(td,tdo,2);
ls('-lR',tdo)
DataContainer.io.memmap.dist.FileDistribute(td,tdo,3);
cmat = DataContainer.io.memmap.dist.FileRead(tdo);
ls('-lR',tdo)
assert(isequal(gather(imat2),gather(cmat)))
ls('-lR',tdo)
DataContainer.io.memmap.serial.FileDelete(td);
DataContainer.io.memmap.serial.FileDelete(tdo);

disp('distributed')
DataContainer.io.memmap.dist.FileWrite(td,imat3,1);
[x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
ls('-lR',td)
DataContainer.io.memmap.dist.FileDelete(td);

hdrs=DataContainer.io.basicHeaderStructFromX(imat3);
hdrs=DataContainer.io.addDistHeaderStruct(hdrs,hdrs.dims-1,[]);
hdrs=DataContainer.io.addDistFileHeaderStruct(hdrs,td);
DataContainer.io.memmap.dist.FileAlloc(td,hdrs);
for k=1:K
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,imat2(:,:,k),[k])
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(imat2(:,:,k),x))
end
ls('-lR',td)
DataContainer.io.memmap.dist.FileGather(td,tdo);
cmat = DataContainer.io.memmap.serial.FileRead(tdo);
assert(isequal(gather(imat2),gather(cmat)))
ls('-lR',tdo)
DataContainer.io.memmap.dist.FileDelete(td);
DataContainer.io.memmap.serial.FileDelete(tdo);

disp('Garbage');
if isdir(td); ls('-R',td); rmdir(td,'s'); end;

disp('Done');
end

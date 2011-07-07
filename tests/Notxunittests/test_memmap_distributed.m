function test_distributed()
assert(matlabpool('size')>0,'matlabpool has to be open first')
disp('Start');
I=13; J=11; K=9;
I=2; J=2; K=4;
imat=distributed.rand(I,J,K);
imat=complex(imat,imat);
td=DataContainer.io.makeDir()

hdrb=DataContainer.io.basicHeaderStructFromX(imat);
hdrx=DataContainer.io.addDistHeaderStructFromX(imat,hdrb);
hdrd=DataContainer.io.addDistHeaderStruct(hdrx.distribution.dim,[],hdrb);
assert(isequal(hdrx,hdrd),'distributions do not match')

disp('serial')
DataContainer.io.memmap.dist.FileWrite(td,imat,0);
[x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
for k=1:K
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(x,imat(:,:,k)),'no match')
end
ls('-lR',td)
DataContainer.io.memmap.serial.FileDelete(td);

hdrs=DataContainer.io.basicHeaderStructFromX(imat);
DataContainer.io.memmap.serial.FileAlloc(td,hdrs);
for k=1:K
    mat = distributed.rand(I,J);
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,mat,[k])
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(mat,x))
end
ls('-lR',td)
DataContainer.io.memmap.serial.FileDelete(td);

disp('distributed')
DataContainer.io.memmap.dist.FileWrite(td,imat,1);
[x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
ls('-lR',td)
DataContainer.io.memmap.dist.FileDelete(td);

hdrs=DataContainer.io.basicHeaderStructFromX(imat);
hdrs=DataContainer.io.addDistHeaderStruct(hdrs.dims-1,[],hdrs);
hdrs=DataContainer.io.addDistFileHeaderStruct(td,hdrs);
DataContainer.io.memmap.dist.FileAlloc(td,hdrs);
for k=1:K
    mat = distributed.rand(I,J);
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,mat,[k])
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(mat,x))
end
ls('-lR',td)
DataContainer.io.memmap.dist.FileDelete(td);

disp('Garbage');
if isdir(td); ls('-R',td); rmdir(td,'s'); end;

disp('Done');
end

function test_distributed()
assert(matlabpool('size')>0,'matlabpool has to be open first')
disp('Start');
I=13; J=11; K=9;
imat=distributed.rand(I,J,K);
imat=complex(imat,imat);
td=DataContainer.io.makeDir()

hdrb=DataContainer.io.basicHeaderStructFromX(imat);
hdrx=DataContainer.io.addDistHeaderStructFromX(imat,hdrb);
hdrd=DataContainer.io.addDistHeaderStruct(hdrx.distribution.dim,hdrx.distribution.partition,hdrb);
assert(isequal(hdrx,hdrd),'distributions do not match')

DataContainer.io.memmap.dist.FileWrite(td,imat,0);
ls('-lR',td)
DataContainer.io.memmap.serial.FileDelete(td);

DataContainer.io.memmap.dist.FileWrite(td,imat,1);
ls('-lR',td)
DataContainer.io.memmap.dist.FileDelete(td);

%DataContainer.io.memmap.dist.FileDelete(td);
disp('Cleanup');
if isdir(td);ls('-R',td); rmdir(td,'s'); end;

disp('Done');
end

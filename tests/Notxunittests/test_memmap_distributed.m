function test_distributed()
if isempty(whos('global','SDCglobalTmpDir'))
    SeisDataContainer_init();
end
disp('Start');
gstart=tic;
assert(matlabpool('size')>0,'matlabpool has to be open first')
Il=2; Jl=2; Kl=2;
I=matlabpool('size')*Il; J=matlabpool('size')*Jl; K=matlabpool('size')*Kl;
disp([I J K])
imat3=distributed.rand(I,J,K);
imat3=complex(imat3,imat3);
spmd
    codistr = codistributor1d(2,codistributor1d.unsetPartition,[I J K]);
    myLocalPart = rand(I,Jl,K);
    imat2 = codistributed.build(myLocalPart, codistr);
end
td=DataContainer.io.makeDir();
fprintf('td :%s\n',td);
tdo=DataContainer.io.makeDir();
fprintf('tdo:%s\n',tdo);

disp('distributed header')
tic
hdrb=DataContainer.basicHeaderStructFromX(imat3);
hdrx=DataContainer.addDistHeaderStructFromX(hdrb,imat3);
hdrd=DataContainer.addDistHeaderStruct(hdrb,hdrx.distribution.dim,[]);
assert(isequal(hdrx,hdrd),'distributions do not match')
toc

disp('global write')
tic
DataContainer.io.memmap.dist.FileWrite(td,imat3,0);
toc
disp('global read')
tic
[x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
toc
disp('global read slice and verify')
tic
for k=1:K
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(x,imat3(:,:,k)),'no match')
    fprintf('%d ',k)
end
fprintf('\n')
toc
DataContainer.io.memmap.serial.FileDelete(td);

disp('global alloc')
tic
hdrs=DataContainer.basicHeaderStructFromX(imat3);
DataContainer.io.memmap.serial.FileAlloc(td,hdrs);
toc
disp('global write slice')
tic
for k=1:K
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,imat2(:,:,k),[k])
    fprintf('%d ',k)
end
fprintf('\n')
toc
disp('global read slice and verify')
tic
for k=1:K
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(imat2(:,:,k),x))
    fprintf('%d ',k)
end
fprintf('\n')
toc
disp('global distribute 1st')
tic
DataContainer.io.memmap.dist.FileDistribute(td,tdo,1);
toc
DataContainer.io.memmap.dist.FileDelete(tdo);
disp('global distribute 2nd')
tic
DataContainer.io.memmap.dist.FileDistribute(td,tdo,2);
toc
DataContainer.io.memmap.dist.FileDelete(tdo);
disp('global distribute 3rd')
tic
DataContainer.io.memmap.dist.FileDistribute(td,tdo,3);
toc
disp('global distribute 3rd verify')
tic
cmat = DataContainer.io.memmap.dist.FileRead(tdo);
assert(isequal(gather(imat2),gather(cmat)))
toc
DataContainer.io.memmap.serial.FileDelete(td);
DataContainer.io.memmap.dist.FileDelete(tdo);

disp('distributed write')
tic
DataContainer.io.memmap.dist.FileWrite(td,imat3,1);
toc
disp('distributed read')
tic
[x hdrn] = DataContainer.io.memmap.dist.FileRead(td);
toc
DataContainer.io.memmap.dist.FileDelete(td);

disp('distributed alloc')
tic
hdrs=DataContainer.basicHeaderStructFromX(imat3);
hdrs=DataContainer.addDistHeaderStruct(hdrs,hdrs.dims-1,[]);
hdrs=DataContainer.io.addDistFileHeaderStruct(hdrs);
DataContainer.io.memmap.dist.FileAlloc(td,hdrs);
toc
disp('distributed write slice')
tic
for k=1:K
    DataContainer.io.memmap.dist.FileWriteLeftSlice(td,imat2(:,:,k),[k])
    fprintf('%d ',k)
end
fprintf('\n')
toc
disp('distributed read slice')
tic
for k=1:K
    x = DataContainer.io.memmap.dist.FileReadLeftSlice(td,[k]);
    assert(isequal(imat2(:,:,k),x))
    fprintf('%d ',k)
end
fprintf('\n')
toc
disp('distributed gather')
tic
DataContainer.io.memmap.dist.FileGather(td,tdo);
toc
disp('distributed gather verify')
tic
cmat = DataContainer.io.memmap.serial.FileRead(tdo);
assert(isequal(gather(imat2),gather(cmat)))
toc
DataContainer.io.memmap.dist.FileDelete(td);
DataContainer.io.memmap.serial.FileDelete(tdo);

disp('Garbage');
if isdir(td); ls('-R',td); rmdir(td,'s'); end;
if isdir(tdo); ls('-R',tdo); rmdir(tdo,'s'); end;

disp('Done');
disp(toc(gstart));
end

function test_serial()
if isempty(whos('global','SDCglobalTmpDir'))
    SeisDataContainer_init();
end
disp('Start');
tic;
I=13; J=11; K=9;
imat=rand(I,J,K);
%for i=1:I
%   for j=1:J
%       for k=1:K
%           imat(i,j,k)=i*10+j*100+k*1000;
%       end
%   end
%end
whos imat
%disp(norm(imat(:)))

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File* single complex');
td=ConDir();
orig=complex(imat,1);
hdr=SeisDataContainer.basicHeaderStructFromX(orig);
hdr.precision='single';
SeisDataContainer.io.memmap.serial.FileWrite(path(td),orig,hdr);
new=SeisDataContainer.io.memmap.serial.FileRead(path(td),'single');
assert(isequal(single(orig),new))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File* double complex');
td=ConDir();
orig=complex(imat,1);
SeisDataContainer.io.memmap.serial.FileWrite(path(td),orig,SeisDataContainer.basicHeaderStructFromX(orig));
new=SeisDataContainer.io.memmap.serial.FileRead(path(td),'double');
assert(isequal(orig,new))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File* single real');
td=ConDir();
SeisDataContainer.io.memmap.serial.FileWrite(path(td),imat,'single');
new=SeisDataContainer.io.memmap.serial.FileRead(path(td),'single');
assert(isequal(single(imat),new))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File* double real');
td=ConDir();
SeisDataContainer.io.memmap.serial.FileWrite(path(td),imat);
new=SeisDataContainer.io.memmap.serial.FileRead(path(td),'double');
assert(isequal(imat,new))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File*LeftSlice last none');
td=ConDir();
SeisDataContainer.io.memmap.serial.FileWrite(path(td),imat);
slice=SeisDataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[]);
assert(isequal(imat,slice))
nmat = imat+1;
SeisDataContainer.io.memmap.serial.FileAlloc(path(td),SeisDataContainer.basicHeaderStructFromX(nmat));
SeisDataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat,[]);
smat = SeisDataContainer.io.memmap.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File*LeftSlice last one');
td=ConDir();
SeisDataContainer.io.memmap.serial.FileWrite(path(td),imat);
for k=1:K
    slice=SeisDataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[k]);
    orig=imat(:,:,k);
    assert(isequal(orig,slice))
end
nmat = imat+1;
SeisDataContainer.io.memmap.serial.FileAlloc(path(td),SeisDataContainer.basicHeaderStructFromX(nmat));
for k=1:K
    SeisDataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
end
smat = SeisDataContainer.io.memmap.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File*LeftSlice last two');
td=ConDir();
SeisDataContainer.io.memmap.serial.FileWrite(path(td),imat);
for k=1:K
    for j=1:J
    slice=SeisDataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[j,k]);
    orig=imat(:,j,k);
    assert(isequal(orig,slice))
    end
end
nmat = imat+1;
SeisDataContainer.io.memmap.serial.FileAlloc(path(td),SeisDataContainer.basicHeaderStructFromX(nmat));
for k=1:K
    for j=1:J
    SeisDataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
    end
end
smat = SeisDataContainer.io.memmap.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File*LeftChunk last none');
td=ConDir();
SeisDataContainer.io.memmap.serial.FileWrite(path(td),imat);
for k=1:K-2
    slice=SeisDataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[k k+2],[]);
    orig=imat(:,:,k:k+2);
    assert(isequal(orig,slice))
end
nmat = imat+1;
SeisDataContainer.io.memmap.serial.FileAlloc(path(td),SeisDataContainer.basicHeaderStructFromX(nmat));
SeisDataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
SeisDataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
smat = SeisDataContainer.io.memmap.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SeisDataContainer.io.memmap.serial.File*LeftChunk last one');
td=ConDir();
SeisDataContainer.io.memmap.serial.FileWrite(path(td),imat);
for k=1:K
    for j=1:J-2
        slice=SeisDataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
        orig=imat(:,j:j+2,k);
        assert(isequal(orig,slice))
    end
end
nmat = imat+1;
SeisDataContainer.io.memmap.serial.FileAlloc(path(td),SeisDataContainer.basicHeaderStructFromX(nmat));
for k=1:K
    SeisDataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
    SeisDataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
end
smat = SeisDataContainer.io.memmap.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('Done');
disp(toc);
end

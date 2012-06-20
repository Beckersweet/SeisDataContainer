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
disp('SDCpckg.io.NativeBin.serial.File* single complex');
td=ConDir();
orig=complex(imat,1);
hdr=SDCpckg.basicHeaderStructFromX(orig);
hdr.precision='single';
SDCpckg.io.NativeBin.serial.FileWrite(path(td),orig,hdr);
new=SDCpckg.io.NativeBin.serial.FileRead(path(td),'single');
assert(isequal(single(orig),new))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File* double complex');
td=ConDir();
orig=complex(imat,1);
SDCpckg.io.NativeBin.serial.FileWrite(path(td),orig,SDCpckg.basicHeaderStructFromX(orig));
new=SDCpckg.io.NativeBin.serial.FileRead(path(td),'double');
assert(isequal(orig,new))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File* single real');
td=ConDir();
SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat,'single');
new=SDCpckg.io.NativeBin.serial.FileRead(path(td),'single');
assert(isequal(single(imat),new))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File* double real');
td=ConDir();
SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
new=SDCpckg.io.NativeBin.serial.FileRead(path(td),'double');
assert(isequal(imat,new))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File*LeftSlice last none');
td=ConDir();
SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
slice=SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[]);
assert(isequal(imat,slice))
nmat = imat+1;
SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat,[]);
smat = SDCpckg.io.NativeBin.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File*LeftSlice last one');
td=ConDir();
SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
for k=1:K
    slice=SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[k]);
    orig=imat(:,:,k);
    assert(isequal(orig,slice))
end
nmat = imat+1;
SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
for k=1:K
    SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
end
smat = SDCpckg.io.NativeBin.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File*LeftSlice last two');
td=ConDir();
SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
for k=1:K
    for j=1:J
    slice=SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[j,k]);
    orig=imat(:,j,k);
    assert(isequal(orig,slice))
    end
end
nmat = imat+1;
SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
for k=1:K
    for j=1:J
    SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
    end
end
smat = SDCpckg.io.NativeBin.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File*LeftChunk last none');
td=ConDir();
SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
for k=1:K-2
    slice=SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[k k+2],[]);
    orig=imat(:,:,k:k+2);
    assert(isequal(orig,slice))
end
nmat = imat+1;
SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
smat = SDCpckg.io.NativeBin.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('*****');
disp('SDCpckg.io.NativeBin.serial.File*LeftChunk last one');
td=ConDir();
SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
for k=1:K
    for j=1:J-2
        slice=SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
        orig=imat(:,j:j+2,k);
        assert(isequal(orig,slice))
    end
end
nmat = imat+1;
SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
for k=1:K
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
end
smat = SDCpckg.io.NativeBin.serial.FileRead(path(td));
assert(isequal(smat,nmat))
dir(td)

disp('Done');
disp(toc);
end

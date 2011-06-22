function test_serial()
disp('Start');
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
disp(norm(imat(:)))

disp('*****');
disp('DataContainer.io.memmap.serial.File* single complex');
td=DataContainer.io.getTmpDir();
orig=complex(imat,1);
hdr=DataContainer.io.basicHeaderStructFromX(orig);
hdr.precision='single';
DataContainer.io.memmap.serial.FileWrite(td,orig,hdr);
new=DataContainer.io.memmap.serial.FileRead(td,'single');
assert(isequal(single(orig),new))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial.File* double complex');
td=DataContainer.io.getTmpDir();
orig=complex(imat,1);
DataContainer.io.memmap.serial.FileWrite(td,orig,DataContainer.io.basicHeaderStructFromX(orig));
new=DataContainer.io.memmap.serial.FileRead(td,'double');
assert(isequal(orig,new))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial.File* single real');
td=DataContainer.io.getTmpDir();
DataContainer.io.memmap.serial.FileWrite(td,imat,'single');
new=DataContainer.io.memmap.serial.FileRead(td,'single');
assert(isequal(single(imat),new))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial.File* double real');
td=DataContainer.io.getTmpDir();
DataContainer.io.memmap.serial.FileWrite(td,imat);
new=DataContainer.io.memmap.serial.FileRead(td,'double');
assert(isequal(imat,new))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial_oof.File*LeftSlice last none');
td=DataContainer.io.getTmpDir();
DataContainer.io.memmap.serial.FileWrite(td,imat);
slice=DataContainer.io.memmap.serial_oof.FileReadLeftSlice(td,[]);
assert(isequal(imat,slice))
nmat = imat+1;
DataContainer.io.memmap.serial_oof.FileWriteLeftSlice(td,nmat,[]);
smat = DataContainer.io.memmap.serial.FileRead(td);
assert(isequal(smat,nmat))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial_oof.File*LeftSlice last one');
td=DataContainer.io.getTmpDir();
DataContainer.io.memmap.serial.FileWrite(td,imat);
for k=1:K
    slice=DataContainer.io.memmap.serial_oof.FileReadLeftSlice(td,[k]);
    orig=imat(:,:,k);
    assert(isequal(orig,slice))
end
nmat = imat+1;
for k=1:K
    DataContainer.io.memmap.serial_oof.FileWriteLeftSlice(td,nmat(:,:,k),[k]);
end
smat = DataContainer.io.memmap.serial.FileRead(td);
assert(isequal(smat,nmat))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial_oof.Data*LeftSlice last two');
td=DataContainer.io.getTmpDir();
DataContainer.io.memmap.serial.FileWrite(td,imat);
for k=1:K
    for j=1:J
    slice=DataContainer.io.memmap.serial_oof.FileReadLeftSlice(td,[j,k]);
    orig=imat(:,j,k);
    assert(isequal(orig,slice))
    end
end
nmat = imat+1;
for k=1:K
    for j=1:J
    DataContainer.io.memmap.serial_oof.FileWriteLeftSlice(td,nmat(:,j,k),[j,k]);
    end
end
smat = DataContainer.io.memmap.serial.FileRead(td);
assert(isequal(smat,nmat))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial_oof.Data*LeftChunk last none');
td=DataContainer.io.getTmpDir();
DataContainer.io.memmap.serial.FileWrite(td,imat);
for k=1:K-2
    slice=DataContainer.io.memmap.serial_oof.FileReadLeftChunk(td,[k k+2],[]);
    orig=imat(:,:,k:k+2);
    assert(isequal(orig,slice))
end
nmat = imat+1;
DataContainer.io.memmap.serial_oof.FileWriteLeftChunk(td,nmat(:,:,1:2),[1 2],[]);
DataContainer.io.memmap.serial_oof.FileWriteLeftChunk(td,nmat(:,:,3:K),[3 K],[]);
smat = DataContainer.io.memmap.serial.FileRead(td);
assert(isequal(smat,nmat))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

disp('*****');
disp('DataContainer.io.memmap.serial_oof.Data*LeftChunk last one');
td=DataContainer.io.getTmpDir();
DataContainer.io.memmap.serial.FileWrite(td,imat);
for k=1:K
    for j=1:J-2
        slice=DataContainer.io.memmap.serial_oof.FileReadLeftChunk(td,[j j+2],[k]);
        orig=imat(:,j:j+2,k);
        assert(isequal(orig,slice))
    end
end
nmat = imat+1;
for k=1:K
    DataContainer.io.memmap.serial_oof.FileWriteLeftChunk(td,nmat(:,1:2,k),[1 2],[k]);
    DataContainer.io.memmap.serial_oof.FileWriteLeftChunk(td,nmat(:,3:J,k),[3 J],[k]);
end
smat = DataContainer.io.memmap.serial.FileRead(td);
assert(isequal(smat,nmat))
ls('-l',td)
rmdir(td,'s')
if isdir(td); dir(td); end;

clear all
disp('Done');
end

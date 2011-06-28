function test_suite = test_memmap_serial
initTestSuite;
end

function test_serial_file_single_complex
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    orig=complex(imat,1);
    hdr=DataContainer.io.basicHeaderStructFromX(orig);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,orig,hdr);
    new=DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(single(orig),new))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_double_complex
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    orig=complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(td,orig,DataContainer.io.basicHeaderStructFromX(orig));
    new=DataContainer.io.memmap.serial.FileRead(td,'double');
    assert(isequal(orig,new))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_single_real
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(td,imat,'single');
    new=DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(single(imat),new))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_double_real
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(td,imat);
    new=DataContainer.io.memmap.serial.FileRead(td,'double');
    assert(isequal(imat,new))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastNone_single_complex
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    orig=complex(imat,1);
    hdr=DataContainer.io.basicHeaderStructFromX(orig);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,orig,hdr);
    slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[]);
    assert(isequal(single(orig),slice))
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat,[]);
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastNone_double_complex
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    orig=complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(td,orig,DataContainer.io.basicHeaderStructFromX(orig));
    slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[]);
    assert(isequal(orig,slice))
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat,[]);
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastNone_single_real
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    hdr=DataContainer.io.basicHeaderStructFromX(imat);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,imat,hdr);
    slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[]);
    assert(isequal(single(imat),slice))
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat,[]);
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastNone_double_real
%%
    imat=rand(13,11,9);
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(td,imat);
    slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[]);
    assert(isequal(imat,slice))
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat,[]);
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastOne_single_complex
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    hdr=DataContainer.io.basicHeaderStructFromX(origc);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,origc,hdr);
    for k=1:K
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[k]);
        orig = complex(imat(:,:,k),1);
        assert(isequal(single(orig),slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,:,k),[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end


function test_serial_file_LeftSlice_lastOne_double_complex
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(td,origc,DataContainer.io.basicHeaderStructFromX(origc));
    for k=1:K
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[k]);
        orig = complex(imat(:,:,k),1);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,:,k),[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastOne_single_real
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    hdr=DataContainer.io.basicHeaderStructFromX(imat);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,imat,hdr);
    for k=1:K
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[k]);
        orig=imat(:,:,k);
        assert(isequal(single(orig),slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,:,k),[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastOne_double_real
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(td,imat);
    for k=1:K
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[k]);
        orig=imat(:,:,k);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,:,k),[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastTwo_single_complex
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    hdr=DataContainer.io.basicHeaderStructFromX(origc);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,origc,hdr);
    for k=1:K
        for j=1:J
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[j,k]);
        orig=complex(imat(:,j,k),1);
        assert(isequal(single(orig),slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        for j=1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,j,k),[j,k]);
        end
    end
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastTwo_double_complex
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(td,origc,DataContainer.io.basicHeaderStructFromX(origc));
    for k=1:K
        for j=1:J
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[j,k]);
        orig=complex(imat(:,j,k),1);
        assert(isequal(orig,slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        for j=1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,j,k),[j,k]);
        end
    end
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastTwo_single_real
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    hdr=DataContainer.io.basicHeaderStructFromX(imat);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,imat,hdr);
    for k=1:K
        for j=1:J
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[j,k]);
        orig=imat(:,j,k);
        assert(isequal(single(orig),slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        for j=1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,j,k),[j,k]);
        end
    end
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftSlice_lastTwo_double_real
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(td,imat);
    for k=1:K
        for j=1:J
        slice=DataContainer.io.memmap.serial.FileReadLeftSlice(td,[j,k]);
        orig=imat(:,j,k);
        assert(isequal(orig,slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        for j=1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(td,nmat(:,j,k),[j,k]);
        end
    end
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastNone_single_complex
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    hdr=DataContainer.io.basicHeaderStructFromX(origc);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,origc,hdr);
    for k=1:K-2
        slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[k k+2],[]);
        orig=complex(imat(:,:,k:k+2),1);
        assert(isequal(single(orig),slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastNone_double_complex
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(td,origc,DataContainer.io.basicHeaderStructFromX(origc));
    for k=1:K-2
        slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[k k+2],[]);
        orig=complex(imat(:,:,k:k+2),1);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastNone_single_real
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    hdr=DataContainer.io.basicHeaderStructFromX(imat);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,imat,hdr);
    for k=1:K-2
        slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[k k+2],[]);
        orig=imat(:,:,k:k+2);
        assert(isequal(single(orig),slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastNone_double_real
%%
    imat=rand(13,11,9);
    K=9;
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(td,imat);
    for k=1:K-2
        slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[k k+2],[]);
        orig=imat(:,:,k:k+2);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastOne_single_complex
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    hdr=DataContainer.io.basicHeaderStructFromX(origc);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,origc,hdr);
    for k=1:K
        for j=1:J-2
            slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[j j+2],[k]);
            orig=complex(imat(:,j:j+2,k),1);
            assert(isequal(single(orig),slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,3:J,k),[3 J],[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastOne_double_complex
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    origc=complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(td,origc,DataContainer.io.basicHeaderStructFromX(origc));
    for k=1:K
        for j=1:J-2
            slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[j j+2],[k]);
            orig=complex(imat(:,j:j+2,k),1);
            assert(isequal(orig,slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,3:J,k),[3 J],[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastOne_single_real
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    hdr=DataContainer.io.basicHeaderStructFromX(imat);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(td,imat,hdr);
    for k=1:K
        for j=1:J-2
            slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[j j+2],[k]);
            orig=imat(:,j:j+2,k);
            assert(isequal(single(orig),slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,3:J,k),[3 J],[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td,'single');
    assert(isequal(smat,single(nmat)))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

function test_serial_file_LeftChunk_lastOne_double_real
%%
    imat=rand(13,11,9);
    J=11;
    K=9;
    td=DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileWrite(td,imat);
    for k=1:K
        for j=1:J-2
            slice=DataContainer.io.memmap.serial.FileReadLeftChunk(td,[j j+2],[k]);
            orig=imat(:,j:j+2,k);
            assert(isequal(orig,slice))
        end
    end
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(td,DataContainer.io.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(td,nmat(:,3:J,k),[3 J],[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(td);
    assert(isequal(smat,nmat))
    DataContainer.io.memmap.serial.FileDelete(td);
    if isdir(td); dir(td); end;
end

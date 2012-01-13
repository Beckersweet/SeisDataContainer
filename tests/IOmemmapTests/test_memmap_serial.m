function test_suite = test_memmap_serial
initTestSuite;
end

function test_serial_basicHeaderStruct
%%
    imat=rand(13,11,9);
    hdrx=DataContainer.basicHeaderStructFromX(imat);
    hdrb=DataContainer.basicHeaderStruct(hdrx.size,hdrx.precision,hdrx.complex);
    assert(isequal(hdrx,hdrb))
end

function test_serial_file_single_complex
%%
    imat          = rand(13,11,9);
    td            = ConDir();
    orig          = complex(imat,1);
    hdr           = DataContainer.basicHeaderStructFromX(orig);
    hdr.precision = 'single';
    DataContainer.io.memmap.serial.FileWrite(path(td),orig,hdr);
    new=DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(single(orig),new))
end

function test_serial_file_double_complex
%%
    imat          = rand(13,11,9);
    td            = ConDir();
    orig          = complex(imat,1);
    hdr           = DataContainer.basicHeaderStructFromX(orig);
    DataContainer.io.memmap.serial.FileWrite(path(td),orig,hdr);
    new=DataContainer.io.memmap.serial.FileRead(path(td),'double');
    assert(isequal(orig,new))
end

function test_serial_file_single_real
%%
    imat = rand(13,11,9);
    td   = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(td),imat,'single');
    new  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(single(imat),new))
end

function test_serial_file_double_real
%%
    imat = rand(13,11,9);
    td   = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(td),imat);
    new  = DataContainer.io.memmap.serial.FileRead(path(td),'double');
    assert(isequal(imat,new))
end

function test_serial_file_LeftSlice_lastNone_single_complex
%%
    imat  = rand(13,11,9);
    td    = ConDir();
    orig=complex(imat,1);
    hdr   = DataContainer.basicHeaderStructFromX(orig);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(path(td),orig,hdr);
    slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[]);
    assert(isequal(single(orig),slice))
    nmat  = imat+1;
    td=ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat,[]);
    smat  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastNone_double_complex
%%
    imat  = rand(13,11,9);
    td    = ConDir();
    orig  = complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(path(td),orig,DataContainer.basicHeaderStructFromX(orig));
    slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[]);
    assert(isequal(orig,slice))
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat,[]);
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastNone_single_real
%%
    imat  = rand(13,11,9);
    td    = ConDir();
    hdr   = DataContainer.basicHeaderStructFromX(imat);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(path(td),imat,hdr);
    slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[]);
    assert(isequal(single(imat),slice))
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat,[]);
    smat  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastNone_double_real
%%
    imat  = rand(13,11,9);
    td    = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(td),imat);
    slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[]);
    assert(isequal(imat,slice))
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat,[]);
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastOne_single_complex
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    hdr=DataContainer.basicHeaderStructFromX(origc);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[k]);
        orig  = complex(imat(:,:,k),1);
        assert(isequal(single(orig),slice))
    end
    nmat  = imat+1;
    td=ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end


function test_serial_file_LeftSlice_lastOne_double_complex
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,DataContainer.basicHeaderStructFromX(origc));
    for k = 1:K
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[k]);
        orig  = complex(imat(:,:,k),1);
        assert(isequal(orig,slice))
    end
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastOne_single_real
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    hdr   = DataContainer.basicHeaderStructFromX(imat);
    hdr.precision='single';
    DataContainer.io.memmap.serial.FileWrite(path(td),imat,hdr);
    for k = 1:K
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[k]);
        orig  = imat(:,:,k);
        assert(isequal(single(orig),slice))
    end
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastOne_double_real
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(td),imat);
    for k = 1:K
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[k]);
        orig  = imat(:,:,k);
        assert(isequal(orig,slice))
    end
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastTwo_single_complex
%%
    imat          = rand(13,11,9);
    J             = 11;
    K             = 9;
    td            = ConDir();
    origc         = complex(imat,1);
    hdr           = DataContainer.basicHeaderStructFromX(origc);
    hdr.precision = 'single';
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K
        for j = 1:J
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = complex(imat(:,j,k),1);
        assert(isequal(single(orig),slice))
        end
    end
    nmat  = imat+1;
    td=ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j=1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastTwo_double_complex
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,DataContainer.basicHeaderStructFromX(origc));
    for k = 1:K
        for j = 1:J
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = complex(imat(:,j,k),1);
        assert(isequal(orig,slice))
        end
    end
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j=1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastTwo_single_real
%%
    imat          = rand(13,11,9);
    J             = 11;
    K             = 9;
    td            = ConDir();
    hdr           = DataContainer.basicHeaderStructFromX(imat);
    hdr.precision = 'single';
    DataContainer.io.memmap.serial.FileWrite(path(td),imat,hdr);
    for k = 1:K
        for j = 1:J
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = imat(:,j,k);
        assert(isequal(single(orig),slice))
        end
    end
    nmat  = imat+1;
    td=ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j = 1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastTwo_double_real
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(td),imat);
    for k = 1:K
        for j = 1:J
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = imat(:,j,k);
        assert(isequal(orig,slice))
        end
    end
    nmat = imat+1;
    td   = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j = 1:J
        DataContainer.io.memmap.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastNone_single_complex
%%
    imat          = rand(13,11,9);
    K             = 9;
    td            = ConDir();
    origc         = complex(imat,1);
    hdr           = DataContainer.basicHeaderStructFromX(origc);
    hdr.precision = 'single';
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K-2
        slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[k k+2],[]);
        orig  = complex(imat(:,:,k:k+2),1);
        assert(isequal(single(orig),slice))
    end
    td   = ConDir();
    nmat = imat+1;
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftChunk_lastNone_double_complex
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,DataContainer.basicHeaderStructFromX(origc));
    for k = 1:K-2
        slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[k k+2],[]);
        orig  = complex(imat(:,:,k:k+2),1);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    td   = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastNone_single_real
%%
    imat          = rand(13,11,9);
    K             = 9;
    td            = ConDir();
    hdr           = DataContainer.basicHeaderStructFromX(imat);
    hdr.precision = 'single';
    DataContainer.io.memmap.serial.FileWrite(path(td),imat,hdr);
    for k = 1:K-2
        slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[k k+2],[]);
        orig  = imat(:,:,k:k+2);
        assert(isequal(single(orig),slice))
    end
    nmat = imat+1;
    td   = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftChunk_lastNone_double_real
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(td),imat);
    for k = 1:K-2
        slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[k k+2],[]);
        orig  = imat(:,:,k:k+2);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    td   = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
    DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
    smat = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastOne_single_complex
%%
    imat          = rand(13,11,9);
    J             = 11;
    K             = 9;
    td            = ConDir();
    origc         = complex(imat,1);
    hdr           = DataContainer.basicHeaderStructFromX(origc);
    hdr.precision = 'single';
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K
        for j = 1:J-2
            slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
            orig  = complex(imat(:,j:j+2,k),1);
            assert(isequal(single(orig),slice))
        end
    end
    nmat = imat+1;
    td   = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k=1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
    end
    smat = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftChunk_lastOne_double_complex
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    DataContainer.io.memmap.serial.FileWrite(path(td),origc,DataContainer.basicHeaderStructFromX(origc));
    for k = 1:K
        for j = 1:J-2
            slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
            orig  = complex(imat(:,j:j+2,k),1);
            assert(isequal(orig,slice))
        end
    end
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastOne_single_real
%%
    imat          = rand(13,11,9);
    J             = 11;
    K             = 9;
    td            = ConDir();
    hdr           = DataContainer.basicHeaderStructFromX(imat);
    hdr.precision = 'single';
    DataContainer.io.memmap.serial.FileWrite(path(td),imat,hdr);
    for k = 1:K
        for j = 1:J-2
            slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
            orig  = imat(:,j:j+2,k);
            assert(isequal(single(orig),slice))
        end
    end
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftChunk_lastOne_double_real
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(td),imat);
    for k = 1:K
        for j = 1:J-2
            slice = DataContainer.io.memmap.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
            orig  = imat(:,j:j+2,k);
            assert(isequal(orig,slice))
        end
    end
    nmat  = imat+1;
    td    = ConDir();
    DataContainer.io.memmap.serial.FileAlloc(path(td),DataContainer.basicHeaderStructFromX(nmat));
    for k = 1:K
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
        DataContainer.io.memmap.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
    end
    smat  = DataContainer.io.memmap.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_Transpose_double_real
%%
    imat             = rand(13,11);
    header           = DataContainer.basicHeaderStructFromX(imat);
    in               = ConDir();
    out              = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    DataContainer.io.memmap.serial.FileTranspose(path(in),path(out),1);
    x                = DataContainer.io.memmap.serial.FileRead(path(out));
    assert(isequal(transpose(imat),x))
end

function test_serial_file_Transpose_double_complex
%%
    imat             = rand(13,11);
    imat             = complex(imat,1);
    header           = DataContainer.basicHeaderStructFromX(imat);
    in               = ConDir();
    out              = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    DataContainer.io.memmap.serial.FileTranspose(path(in),path(out),1);
    x                = DataContainer.io.memmap.serial.FileRead(path(out));
    assert(isequal(transpose(imat),x))
end

function test_serial_file_Transpose_single_real
%%
    imat             = rand(13,11);
    header           = DataContainer.basicHeaderStructFromX(imat);
    header.precision = 'single';
    in               = ConDir();
    out              = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    DataContainer.io.memmap.serial.FileTranspose(path(in),path(out),1);
    x                = DataContainer.io.memmap.serial.FileRead(path(out),'single');
    assert(isequal(single(transpose(imat)),x))
end

function test_serial_file_Transpose_single_complex
%%
    imat             = rand(13,11);
    imat             = complex(imat,1);
    header           = DataContainer.basicHeaderStructFromX(imat);
    header.precision = 'single';
    in               = ConDir();
    out              = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    DataContainer.io.memmap.serial.FileTranspose(path(in),path(out),1);
    x                = DataContainer.io.memmap.serial.FileRead(path(out),'single');
    assert(isequal(single(transpose(imat)),x))
end

function test_serial_file_Norm_double_real
%%
    imat   = rand(14,12,5);
    header = DataContainer.basicHeaderStructFromX(imat);
    in     = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],0,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),0);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],1,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),1);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],2,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),2);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],inf,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],-inf,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),-inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],'fro','double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),'fro');
    assertElementsAlmostEqual(x,n)
end

function test_serial_file_Norm_double_complex
%%
    imat   = rand(14,12,5);
    imat   = complex(imat,imat);
    header = DataContainer.basicHeaderStructFromX(imat);
    in     = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],0,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),0);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],1,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),1);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],2,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),2);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],inf,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],-inf,'double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),-inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],'fro','double');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),'fro');
    assertElementsAlmostEqual(x,n)
end

function test_serial_file_Norm_single_real
%%
    imat   = rand(14,12,5);
    header = DataContainer.basicHeaderStructFromX(imat);
    header.precision='single';
    in     = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],0,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),0);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],1,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),1);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],2,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),2);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],inf,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],-inf,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),-inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],'fro','single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),'fro');
    assertElementsAlmostEqual(x,n)
end

function test_serial_file_Norm_single_complex
%%
    imat   = rand(14,12,5);
    imat   = complex(imat,imat);
    header = DataContainer.basicHeaderStructFromX(imat);
    header.precision='single';
    in     = ConDir();
    DataContainer.io.memmap.serial.FileWrite(path(in),imat,header);
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],0,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),0);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],1,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),1);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],2,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),2);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],inf,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],-inf,'single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),-inf);
    assertElementsAlmostEqual(x,n)
    n      = DataContainer.io.memmap.serial.FileNorm(path(in),[14 12 5],'fro','single');
    x      = norm(DataContainer.utils.vecNativeSerial(imat),'fro');
    assertElementsAlmostEqual(x,n)
end

function test_suite = test_JS_10_serial
%initTestSuite;
% TESTS that currently work :
%test_serial_file_single_real ;
%test_serial_file_LeftSlice_lastNone_single_real ;
%test_serial_file_LeftSlice_lastOne_single_real ;
%test_serial_file_LeftChunk_lastOne_single_real ;
%test_serial_file_Norm_single_real ;
%test_suite = 1;
end

function test_serial_file_single_complex
%%
    SeisDataContainer_init ;
    path          = 'newtest'
    x             = [3,3,1]  
    imat          = rand(x);
    td            = ConDir();
    orig          = complex(imat,1);
    hdr           = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',1);
    hdr.precision = 'single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr)
    SDCpckg.io.JavaSeis.serial.FileWrite(path,orig,hdr);
    new=SDCpckg.io.JavaSeis.serial.FileRead(path,'single');
    assert(isequal(single(orig),new))
end

function test_serial_file_double_complex
%%
    path          = 'newtest'
    x             = [13,11,19] ;
    imat          = rand(x);
    td            = ConDir();
    orig          = complex(imat,1);
    hdr           = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',1);
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,header) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,orig,hdr);
    new=SDCpckg.io.JavaSeis.serial.FileRead(path,'double');
    assert(isequal(orig,new))
end

function test_serial_file_single_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    x    = [13,11,19] ;
    imat = rand(x);
    td   = ConDir();
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,'single');
    new  = SDCpckg.io.JavaSeis.serial.FileRead(path,'single');
    assert(isequal(single(imat),new))
end

function test_serial_file_double_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    x    = [13,11,19]
    imat = rand(x);
    td   = ConDir();
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',0);
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,'double');
    new  = SDCpckg.io.JavaSeis.serial.FileRead(path,'double');
    assert(isequal(imat,new))
end

function test_serial_file_LeftSlice_lastNone_single_complex
%%
    path   = 'newtest' ;
    x      = [13,11,19] ;
    imat  = rand(x);
    td    = ConDir();
    orig=complex(imat,1);
    hdr   = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',1);
    hdr.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,orig,hdr);
    slice = SDCpckg.io.JavaSeis.serial.FileReadLeftSlice(path,[]);
    assert(isequal(single(orig),slice))
    nmat  = imat+1;
    td=ConDir();
    hdr2   = SDCpckg.io.JavaSeis.serial.HeaderWrite(nmat,'single',1);
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr2);
    SDCpckg.io.JavaSeis.serial.FileWriteLeftSlice(path,nmat,[]);
    smat  = SDCpckg.io.JavaSeis.serial.FileRead(path,'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastNone_double_complex
%%
    path   = 'newtest'
    x      = [13,11,19]
    imat  = rand(x);
    td    = ConDir();
    orig  = complex(imat,1);
    hdr   = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',1);
    hdr.precision='double';
    SDCpckg.io.JavaSeis.serial.FileWrite(path,orig,hdr);
    slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path,[]);
    assert(isequal(orig,slice))
    nmat  = imat+1;
    td    = ConDir();
    hdr   = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',1);
    hdr.precision='double';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,SDCpckg.basicHeaderStructFromX(nmat));
    SDCpckg.io.JavaSeis.serial.FileWriteLeftSlice(path,nmat,[]);
    smat  = SDCpckg.io.JavaSeis.serial.FileRead(path);
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastNone_single_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    x    = [3,3,2] ;
  % x = [3,3,2] ;
    imat  = rand(x)
    td    = ConDir();
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,hdr);
    slice = SDCpckg.io.JavaSeis.serial.FileReadLeftSlice(path,[])
    assert(isequal(single(imat(:,:,end)),slice))
    nmat  = imat+1;
    SeisDataContainer_init ;
    td    = ConDir();
    hdr2  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr2.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr2);
    SDCpckg.io.JavaSeis.serial.FileWriteLeftSlice(path,nmat,[]);
    smat  = SDCpckg.io.JavaSeis.serial.FileRead(path,'single');
    assert(isequal(smat,single(nmat)))
   
end

function test_serial_file_LeftSlice_lastNone_double_real
%%
    imat  = rand(13,11,9);
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
    slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[]);
    assert(isequal(imat,slice))
    nmat  = imat+1;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat,[]);
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastOne_single_complex
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    hdr=SDCpckg.basicHeaderStructFromX(origc);
    hdr.precision='single';
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[k]);
        orig  = complex(imat(:,:,k),1);
        assert(isequal(single(orig),slice))
    end
    nmat  = imat+1;
    td=ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end


function test_serial_file_LeftSlice_lastOne_double_complex
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,SDCpckg.basicHeaderStructFromX(origc));
    for k = 1:K
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[k]);
        orig  = complex(imat(:,:,k),1);
        assert(isequal(orig,slice))
    end
    nmat  = imat+1;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastOne_single_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    x    = [13,11,19] ;
    imat  = rand(x) ;
    K     = 9 ;
    td    = ConDir() ;
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,hdr);
    for k = 1:K
        mytest = k
        slice = SDCpckg.io.JavaSeis.serial.FileReadLeftSlice(path,[k 1])
        orig  = imat(:,:,k)
        assert(isequal(single(orig),slice))
    end
    nmat  = imat+1
    
    SeisDataContainer_init ;
    td    = ConDir();
    hdr2  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr2.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr2) ;
    for k = 1:K
        mytest2 =k
        SDCpckg.io.JavaSeis.serial.FileWriteLeftSlice(path,nmat(:,:,k),[k 1]);
    end
    smat  = SDCpckg.io.JavaSeis.serial.FileRead(path,'single')
    single(nmat)
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastOne_double_real
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
    for k = 1:K
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[k]);
        orig  = imat(:,:,k);
        assert(isequal(orig,slice))
    end
    nmat  = imat+1;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,:,k),[k]);
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastTwo_single_complex
%%
    imat          = rand(13,11,9);
    J             = 11;
    K             = 9;
    td            = ConDir();
    origc         = complex(imat,1);
    hdr           = SDCpckg.basicHeaderStructFromX(origc);
    hdr.precision = 'single';
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K
        for j = 1:J
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = complex(imat(:,j,k),1);
        assert(isequal(single(orig),slice))
        end
    end
    nmat  = imat+1;
    td=ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j=1:J
        SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastTwo_double_complex
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,SDCpckg.basicHeaderStructFromX(origc));
    for k = 1:K
        for j = 1:J
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = complex(imat(:,j,k),1);
        assert(isequal(orig,slice))
        end
    end
    nmat  = imat+1;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j=1:J
        SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftSlice_lastTwo_single_real
%%
    imat          = rand(13,11,9);
    J             = 11;
    K             = 9;
    td            = ConDir();
    hdr           = SDCpckg.basicHeaderStructFromX(imat);
    hdr.precision = 'single';
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat,hdr);
    for k = 1:K
        for j = 1:J
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = imat(:,j,k);
        assert(isequal(single(orig),slice))
        end
    end
    nmat  = imat+1;
    td=ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j = 1:J
        SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftSlice_lastTwo_double_real
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
    for k = 1:K
        for j = 1:J
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftSlice(path(td),[j,k]);
        orig  = imat(:,j,k);
        assert(isequal(orig,slice))
        end
    end
    nmat = imat+1;
    td   = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        for j = 1:J
        SDCpckg.io.NativeBin.serial.FileWriteLeftSlice(path(td),nmat(:,j,k),[j,k]);
        end
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastNone_single_complex
%%
    imat          = rand(13,11,9);
    K             = 9;
    td            = ConDir();
    origc         = complex(imat,1);
    hdr           = SDCpckg.basicHeaderStructFromX(origc);
    hdr.precision = 'single';
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K-2
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[k k+2],[]);
        orig  = complex(imat(:,:,k:k+2),1);
        assert(isequal(single(orig),slice))
    end
    td   = ConDir();
    nmat = imat+1;
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
    smat = SDCpckg.io.NativeBin.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftChunk_lastNone_double_complex
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,SDCpckg.basicHeaderStructFromX(origc));
    for k = 1:K-2
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[k k+2],[]);
        orig  = complex(imat(:,:,k:k+2),1);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    td   = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
    smat = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastNone_single_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    x    = [13,11,9] ;
    imat  = rand(x) ;
    K     = 9 ;
    td    = ConDir() ;
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,hdr);
    mytest = 1
    for k = 1:K-2
        
        slice = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(path,[k k+2],[])
        orig  = imat(:,:,k:k+2);
        assert(isequal(single(orig),slice))
    end
 
    SeisDataContainer_init ;
    nmat = imat+1;
    td   = ConDir();
    hdr2  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr2.precision='single';
    mytest = 2
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr2) ;
    SDCpckg.io.JavaSeis.serial.FileWriteLeftChunk(path,nmat(:,:,1:2),[1 2],[])
    SDCpckg.io.JavaSeis.serial.FileWriteLeftChunk(path,nmat(:,:,3:K),[3 K],[]);
    smat = SDCpckg.io.JavaSeis.serial.FileRead(path,'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftChunk_lastNone_double_real
%%
    imat  = rand(13,11,9);
    K     = 9;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
    for k = 1:K-2
        slice = SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[k k+2],[]);
        orig  = imat(:,:,k:k+2);
        assert(isequal(orig,slice))
    end
    nmat = imat+1;
    td   = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,1:2),[1 2],[]);
    SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,:,3:K),[3 K],[]);
    smat = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastOne_single_complex
%%
    imat          = rand(13,11,9);
    J             = 11;
    K             = 9;
    td            = ConDir();
    origc         = complex(imat,1);
    hdr           = SDCpckg.basicHeaderStructFromX(origc);
    hdr.precision = 'single';
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,hdr);
    for k = 1:K
        for j = 1:J-2
            slice = SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
            orig  = complex(imat(:,j:j+2,k),1);
            assert(isequal(single(orig),slice))
        end
    end
    nmat = imat+1;
    td   = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k=1:K
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
    end
    smat = SDCpckg.io.NativeBin.serial.FileRead(path(td),'single');
    assert(isequal(smat,single(nmat)))
end

function test_serial_file_LeftChunk_lastOne_double_complex
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    origc = complex(imat,1);
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),origc,SDCpckg.basicHeaderStructFromX(origc));
    for k = 1:K
        for j = 1:J-2
            slice = SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
            orig  = complex(imat(:,j:j+2,k),1);
            assert(isequal(orig,slice))
        end
    end
    nmat  = imat+1;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_LeftChunk_lastOne_single_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    x    = [13,11,9] ;
    imat  = rand(x) ;
   
    J             = 11;
    K             = 9;
    td    = ConDir() ;
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,hdr);
    
    for k = 1:K
        for j = 1:J-2
            slice = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(path,[j j+2],[k 1]);
            orig  = imat(:,j:j+2,k);
            assert(isequal(single(orig),slice)) ;
        end
    end
    SeisDataContainer_init ;
    nmat  = imat+1;
    td    = ConDir();
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,nmat,hdr);
    for k = 1:K
        SDCpckg.io.JavaSeis.serial.FileWriteLeftChunk(path,nmat(:,1:2,k),[1 2],[k 1]);
        SDCpckg.io.JavaSeis.serial.FileWriteLeftChunk(path,nmat(:,3:J,k),[3 J],[k 1]);
    end
    smat  = SDCpckg.io.JavaSeis.serial.FileRead(path,'single');
    assert(isequal(smat,single(nmat))) ;
end

function test_serial_file_LeftChunk_lastOne_double_real
%%
    imat  = rand(13,11,9);
    J     = 11;
    K     = 9;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(td),imat);
    for k = 1:K
        for j = 1:J-2
            slice = SDCpckg.io.NativeBin.serial.FileReadLeftChunk(path(td),[j j+2],[k]);
            orig  = imat(:,j:j+2,k);
            assert(isequal(orig,slice))
        end
    end
    nmat  = imat+1;
    td    = ConDir();
    SDCpckg.io.NativeBin.serial.FileAlloc(path(td),SDCpckg.basicHeaderStructFromX(nmat));
    for k = 1:K
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,1:2,k),[1 2],[k]);
        SDCpckg.io.NativeBin.serial.FileWriteLeftChunk(path(td),nmat(:,3:J,k),[3 J],[k]);
    end
    smat  = SDCpckg.io.NativeBin.serial.FileRead(path(td));
    assert(isequal(smat,nmat))
end

function test_serial_file_Transpose_double_real
%%
    imat             = rand(13,11);
    header           = SDCpckg.basicHeaderStructFromX(imat);
    in               = ConDir();
    out              = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(in),imat,header);
    SDCpckg.io.NativeBin.serial.FileTranspose(path(in),path(out),1);
    x                = SDCpckg.io.NativeBin.serial.FileRead(path(out));
    assert(isequal(transpose(imat),x))
end

function test_serial_file_Transpose_double_complex
%%
    imat             = rand(13,11);
    imat             = complex(imat,1);
    header           = SDCpckg.basicHeaderStructFromX(imat);
    in               = ConDir();
    out              = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(in),imat,header);
    SDCpckg.io.NativeBin.serial.FileTranspose(path(in),path(out),1);
    x                = SDCpckg.io.NativeBin.serial.FileRead(path(out));
    assert(isequal(transpose(imat),x))
end

function test_serial_file_Transpose_single_real
%%
    imat             = rand(13,11);
    header           = SDCpckg.basicHeaderStructFromX(imat);
    header.precision = 'single';
    in               = ConDir();
    out              = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(in),imat,header);
    SDCpckg.io.NativeBin.serial.FileTranspose(path(in),path(out),1);
    x                = SDCpckg.io.NativeBin.serial.FileRead(path(out),'single');
    assert(isequal(single(transpose(imat)),x))
end

function test_serial_file_Transpose_single_complex
%%
    imat             = rand(13,11);
    imat             = complex(imat,1);
    header           = SDCpckg.basicHeaderStructFromX(imat);
    header.precision = 'single';
    in               = ConDir();
    out              = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(in),imat,header);
    SDCpckg.io.NativeBin.serial.FileTranspose(path(in),path(out),1);
    x                = SDCpckg.io.NativeBin.serial.FileRead(path(out),'single');
    assert(isequal(single(transpose(imat)),x))
end

function test_serial_file_Norm_double_real
%%
    imat   = rand(14,12,5);
    in     = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(in),imat);
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),0);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),0);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),1);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),1);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),2);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),2);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),inf);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),inf);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),-inf);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),-inf);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),'fro');
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),'fro');
    assertElementsAlmostEqual(x,n)
end

function test_serial_file_Norm_double_complex
%%
    imat   = rand(14,12,5);
    imat   = complex(imat,imat);
    in     = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(in),imat);
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),0);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),0);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),1);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),1);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),2);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),2);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),inf);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),inf);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),-inf);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),-inf);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),'fro');
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),'fro');
    assertElementsAlmostEqual(x,n)
end

function test_serial_file_Norm_single_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    SDCpckg.io.isFileClean(path);
    x    = [14,12,5] ;
    imat  = rand(x) ;
   %imat = single(x) ;
    td    = ConDir() ;
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'single',0);
    hdr.precision='single';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,hdr);
    K=5;
    J=12;
    
    
    % Matlab norm (2-norm)
    %MATnorm = norm(x,1) % works for a 2d chunks only

    
    % Norm over pieces of 2-D chunks
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,K,J,0) 
    %x      = norm(SDCpckg.utils.vecNativeSerial(imat),0) 
    %assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,K,J,1)
    %x      = norm(SDCpckg.utils.vecNativeSerial(imat),1)
    %assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,K,J,2)
    %x      = norm(SDCpckg.utils.vecNativeSerial(imat),2)
    %assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,K,J,inf)
    %x      = norm(SDCpckg.utils.vecNativeSerial(imat),inf)
    %assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,K,J,-inf)
    %x      = norm(SDCpckg.utils.vecNativeSerial(imat),-inf)
    %assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,K,J,'fro')
    %x      = norm(SDCpckg.utils.vecNativeSerial(imat),'fro')
    %assertElementsAlmostEqual(x,n)
end

function test_serial_file_Norm_single_complex
%%
    imat   = single(rand(14,12,5));
    imat   = complex(imat,imat);
    in     = ConDir();
    SDCpckg.io.NativeBin.serial.FileWrite(path(in),imat);
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),0);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),0);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),1);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),1);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),2);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),2);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),inf);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),inf);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),-inf);
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),-inf);
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.NativeBin.serial.FileNorm(path(in),'fro');
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),'fro');
    assertElementsAlmostEqual(x,n)
end


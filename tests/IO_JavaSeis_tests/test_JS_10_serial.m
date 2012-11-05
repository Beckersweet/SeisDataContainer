function test_suite = test_JS_10_serial
initTestSuite;
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
    
    class(single(imat))
    class(single(new))
    
    assert(isequal(single(imat),new))
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
        orig  = imat(:,:,k:k+2)
        assert(isequal(single(orig),slice))
        
    end

end


function test_serial_file_LeftChunk_lastOne_single_real
%%
    global globalTable
    
    SeisDataContainer_init ;
    path = 'newtest' ;
    x    = [13,11,9] ;
    globalTable = zeros(x);
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
    
    
end

function test_serial_file_Norm_double_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    SDCpckg.io.isFileClean(path);
    SeisDataContainer_init ;
    x    = [14,12,5] ;
    imat  = rand(x) ;
    imat = double(imat) ;
    td    = ConDir() ;
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',0);
    hdr.precision='double';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,hdr);
    K=5;
    J=12;

    type = class(imat)    
    
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,0,'double') 
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),0) 
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,1,'double')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),1)
    assertElementsAlmostEqual(x,n)
    n     = SDCpckg.io.JavaSeis.serial.FileNorm(path,2,'double')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),2)
    assertElementsAlmostEqual(x,n)
    
    class(n)
    class(x)
    
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,inf,'double')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),inf)
    assertElementsAlmostEqual(x,n)
    n    = SDCpckg.io.JavaSeis.serial.FileNorm(path,-inf,'double')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),-inf)
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,'fro','double')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),'fro')
    
   
    class(n)
    class(x)
    
    assertElementsAlmostEqual(x,n)
end

function test_serial_file_Norm_single_real
%%
    SeisDataContainer_init ;
    path = 'newtest' ;
    SDCpckg.io.isFileClean(path);
    SeisDataContainer_init ;
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
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,0,'single') 
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),0) 
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,1,'single')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),1)
    assertElementsAlmostEqual(x,n)
      
    
    n     = SDCpckg.io.JavaSeis.serial.FileNorm(path,2,'single')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),2)
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,inf,'single')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),inf)
    assertElementsAlmostEqual(x,n)
    n    = SDCpckg.io.JavaSeis.serial.FileNorm(path,-inf,'single')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),-inf)
    assertElementsAlmostEqual(x,n)
    n      = SDCpckg.io.JavaSeis.serial.FileNorm(path,'fro','single')
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),'fro')
    
    class(n)
    class(x)
    
    assertElementsAlmostEqual(x,n)
end


function test_serial_file_NormTest2_double_real
%%
   % javaaddpath('/Users/bcollignon/Documents/workspace/javaSeisExample_test2.jar');
    SeisDataContainer_init ;
    path = 'newtest' ;
    SDCpckg.io.isFileClean(path);
    SeisDataContainer_init ;
    x    = [14,12,5] ;
  % x = [3,3,1,1] 
    imat  = rand(x) ;
  % imat = single(x) ;
  %  imat = double(imat) ;
    td    = ConDir() ;
    hdr  = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',0);
    hdr.precision='double';
    SDCpckg.io.JavaSeis.serial.FileAlloc(path,hdr) ;
    SDCpckg.io.JavaSeis.serial.FileWrite(path,imat,hdr);
    K=5;
    J=12;
  
   % K=1;
   % J=1;
    
    [n,m,o] = SDCpckg.io.JavaSeis.serial.FileNorm_test2(path,K,J,0) 
   % JS function take 2d input only
   % y = beta.javaseis.examples.io.sum_inf.fileNormScalar(imat,0) ;
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),0) 
    
  
    assertElementsAlmostEqual(x,m)
    assertElementsAlmostEqual(x,o)
    
    [n,m,o]      = SDCpckg.io.JavaSeis.serial.FileNorm_test2(path,K,J,1)
    % y = beta.javaseis.examples.io.sum_inf.fileNormScalar(imat,1) ;
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),1)
    assertElementsAlmostEqual(x,m)
    assertElementsAlmostEqual(x,o)
    [n,m,o]     = SDCpckg.io.JavaSeis.serial.FileNorm_test2(path,K,J,2)
    % y = beta.javaseis.examples.io.sum_inf.fileNormScalar(imat,2) ;
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),2)
    assertElementsAlmostEqual(x,m)
    assertElementsAlmostEqual(x,o)
    
    % assertion work in double-precision mode
    class(n)
    class(m)
    class(o)
    class(x)
   
    
    [n,m,o]     = SDCpckg.io.JavaSeis.serial.FileNorm_test2(path,K,J,inf)
  %  y = beta.javaseis.examples.io.sum_inf.fileNormScalar(imat,inf) ;
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),inf)
    assertElementsAlmostEqual(x,m)
    assertElementsAlmostEqual(x,o)
    [n,m,o]    = SDCpckg.io.JavaSeis.serial.FileNorm_test2(path,K,J,-inf)
  %  y = beta.javaseis.examples.io.sum_inf.fileNormScalar(imat,-inf) ;
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),-inf)
    assertElementsAlmostEqual(x,m)
    assertElementsAlmostEqual(x,o)
    [n,m,o]      = SDCpckg.io.JavaSeis.serial.FileNorm_test2(path,K,J,'fro')
  %  y = beta.javaseis.examples.io.sum_inf.fileNormScalar(imat,'fro') ;
    x      = norm(SDCpckg.utils.vecNativeSerial(imat),'fro')
    assertElementsAlmostEqual(x,m)
    assertElementsAlmostEqual(x,o)
end


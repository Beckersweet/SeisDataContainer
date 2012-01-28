function test_suite = test_SeisDataContainer
%TEST_SEISDATACONTAINER Unit tests for the SeisDataContainer
initTestSuite;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_dist_oof_readWriteSlice
%%
n = randi(10)+1;
m = randi(n);
A = distributed.rand(n,n,n,n,n);
SeisDataContainer.io.NativeBin.dist_deprecated.DataWrite('test',A);
SeisDataContainer.io.NativeBin.dist_oof.DataSliceRead('test',[n n n n n],m,'./');
SeisDataContainer.io.NativeBin.dist_oof.DataSliceWrite('slice',[n n n n n],m);
B = SeisDataContainer.io.NativeBin.dist_deprecated.DataRead('slice',[n n n n n]);
isequal(B(:,:,:,:,m),A(:,:,:,:,m));
delete test;
delete slice;
rmdir('1', 's');
rmdir('2', 's');
end

function test_HeaderReadWrite
%%
    x = randi(100)+1;
    y = randi(50);
    n1 = randi(x,[1,y]);   
    n1 = SeisDataContainer.basicHeaderStructFromX(n1);
    SeisDataContainer.io.NativeBin.HeaderWrite('test',n1);
    n2 = SeisDataContainer.io.NativeBin.HeaderRead('test');
    delete test.xml;
    assert(isequal(n1,n2));   
end

function test_dist_DataReadWrite
%%
    x = randi(20)+1;
    n1 = distributed.randn(x,x,x,x);
    SeisDataContainer.io.NativeBin.dist_deprecated.DataWrite('test',n1);
    n2 = SeisDataContainer.io.NativeBin.dist_deprecated.DataRead('test', [x x x x]);
    delete test;
    assert(isequal(n1,n2));   
end

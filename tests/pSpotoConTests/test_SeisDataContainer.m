function test_suite = test_SeisDataContainer
%TEST_SEISDATACONTAINER Unit tests for the SeisDataContainer
initTestSuite;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_dist_oof_readWriteSlice
%%
n = randi(10);
m = randi(n);
A = distributed.rand(n,n,n,n,n);
DataContainer.io.memmap.dist.DataWrite('test',A);
DataContainer.io.memmap.dist_oof.DataSliceRead('test',[n n n n n],m,'./');
DataContainer.io.memmap.dist_oof.DataSliceWrite('slice',[n n n n n],m);
B = DataContainer.io.memmap.dist.DataRead('slice',[n n n n n]);
isequal(B(:,:,:,:,m),A(:,:,:,:,m));
delete test;
delete slice;
rmdir('1', 's');
rmdir('2', 's');
end

function test_dist_readWriteData
%%
end

function test_HeaderReadWrite
%%
    x = randi(100);
    y = randi(50);
    n1 = randi(x,[1,y]);   
    n1 = DataContainer.io.basicHeaderStructFromX(n1);
    DataContainer.io.memmap.HeaderWrite('test',n1);
    n2 = DataContainer.io.memmap.HeaderRead('test');
    delete test.xml;
    assert(isequal(n1,n2));   
end

function test_dist_DataReadWrite
%%
    x = randi(20);
    n1 = distributed.randn(x,x,x,x);
    DataContainer.io.memmap.dist.DataWrite('test',n1);
    n2 = DataContainer.io.memmap.dist.DataRead('test', [x x x x]);
    delete test;
    assert(isequal(n1,n2));   
end
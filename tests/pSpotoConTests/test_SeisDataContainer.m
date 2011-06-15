function test_suite = test_SeisDataContainer
%TEST_DISTOOF Summary of this function goes here
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
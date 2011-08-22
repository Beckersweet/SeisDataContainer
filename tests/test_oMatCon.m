function test_suite = test_oMatCon
initTestSuite;
end

function test_oMatCon_subref
%% subref
imat   = rand(5,3,8);
header = DataContainer.io.basicHeaderStructFromX(imat);
in     = DataContainer.io.makeDir();
DataContainer.io.memmap.serial.FileWrite(in,imat,header);
x      = oMatCon(in,'real');
assert(isequal(x(:,2:3,5),imat(:,2:3,5)))
end
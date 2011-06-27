function test_distributed()
assert(matlabpool('size')>0,'matlabpool has to be open first')
disp('Start');
I=13; J=11; K=9;
imat=distributed.rand(I,J,K);

hdrb=DataContainer.io.basicHeaderStructFromX(imat);
hdrx=DataContainer.io.addDistHeaderStructFromX(imat,hdrb);
hdrd=DataContainer.io.addDistHeaderStruct(hdrx.distribution.dim,hdrx.distribution.partition,hdrb);

assert(isequal(hdrx,hdrd),'distributions do not match')

hdrx
hdrx.distribution

disp('Done');
end

function test_suite = test_NativeBin_00_misc
initTestSuite;
end

function test_serial_basicHeaderStruct
%%
    imat=rand(13,11,9);
    hdrx=SDCpckg.basicHeaderStructFromX(imat);
    hdrb=SDCpckg.basicHeaderStruct(hdrx.size,hdrx.precision,hdrx.complex);
    assert(isequal(hdrx,hdrb))
end

function test_distributed_basicHeaderStruct_real
%%
    imat = distributed.rand(2,2,4);
    hdrb = SDCpckg.basicHeaderStructFromX(imat);
    hdrx = SDCpckg.addDistHeaderStructFromX(hdrb,imat);
    hdrd = SDCpckg.addDistHeaderStruct(hdrb,hdrx.distribution.dim,hdrx.distribution.partition);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_distributed_basicHeaderStruct_complex
%%
    imat = distributed.rand(2,2,4);
    imat = complex(imat,imat);
    hdrb = SDCpckg.basicHeaderStructFromX(imat);
    hdrx = SDCpckg.addDistHeaderStructFromX(hdrb,imat);
    hdrd = SDCpckg.addDistHeaderStruct(hdrb,hdrx.distribution.dim,hdrx.distribution.partition);
    assert(isequal(hdrx,hdrd),'distributions do not match')
end

function test_getSliceIndex
%%
    I=randi(13);
    J=randi(15);
    K=randi(17);

    S=0;
    for k=1:K
        for j=1:J
            for i=1:I
                S=S+1;
                s=SDCpckg.utils.getSliceIndexV2S([I J K],[i j k]);
                assert(s==S,'global index does not match');
                v=SDCpckg.utils.getSliceIndexS2V([I J K],s);
                assert(isequal([i j k],v),'index vectors do not match');
                %disp([i j k s v]);
            end
        end
    end
end

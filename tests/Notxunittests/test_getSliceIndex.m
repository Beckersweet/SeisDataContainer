function test_getSliceIndex()
I=randi(43);
J=randi(45);
K=randi(47);

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

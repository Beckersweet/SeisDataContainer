clc

x = iCon.zeros(3,3,3,3);

for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                x(i,j,k,l) = i + 0.1*j + 0.01*k + 0.001*l;
            end
        end
    end
end

x = reshape(x,9,9);
x = x';
x.perm
x.perm{1}
x = invvec(x);
x.perm
x = invpermute(x);
x.perm
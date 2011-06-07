function test_mvopKron
%% test_opKron  Unit tests for Kronecker products
   A1 = iCon.randn(3,4) + 1i*iCon.randn(3,4);
   A2 = iCon.randn(3,2) + 1i*iCon.randn(3,2);
   A3 = iCon.randn(2,2) + 1i*iCon.randn(2,2);
   A  = kron(A1,kron(A2,A3));
   B  = kron(opMatrix(A1),kron(opMatrix(A2),opMatrix(A3)));
   x  = iCon.randn(size(A,1),2) + 1i*iCon.randn(size(A,1),2);
   y  = iCon.randn(size(A,2),2) + 1i*iCon.randn(size(A,2),2);
   assertElementsAlmostEqual(A *y, B *y)
   assertElementsAlmostEqual(A'*x, B'*x)
   assertElementsAlmostEqual(A ,double(B ))
   assertElementsAlmostEqual(A',double(B'))
end

function test_mvopKron
%% test_opKron  Unit tests for Kronecker products
   A1 = iCon.randn(3,4) + 1i*iCon.randn(3,4);
   A2 = iCon.randn(3,2) + 1i*iCon.randn(3,2);
   A3 = iCon.randn(2,2) + 1i*iCon.randn(2,2);
   A  = kron(A1,kron(A2,A3));
   B  = kron(opMatrix(A1),kron(opMatrix(A2),opMatrix(A3)));
   x  = iCon.randn(size(A,1),2) + 1i*iCon.randn(size(A,1),2);
   y  = iCon.randn(size(A,2),2) + 1i*iCon.randn(size(A,2),2);
   y_header = y.header;
   y_header.size = [2 2 4 2];
   y_header.delta = [1 1 1 1];
   y_header.origin = [0 0 0 0];
   y_header.unit = {'u1' 'u2' 'u3' 'u4'};
   y_header.label = {'l1' 'l2' 'l3' 'l4'};
   y.header = y_header;
   y.exsize = [1 4;3 4];
   assertElementsAlmostEqual(A*y, B*y)
   x_header = x.header;
   x_header.size = [2 3 3 2];
   x_header.delta = [1 1 1 1];
   x_header.origin = [0 0 0 0];
   x_header.unit = {'u1' 'u2' 'u3' 'u4'};
   x_header.label = {'l1' 'l2' 'l3' 'l4'};
   x.header = x_header;
   x.exsize = [1 4;3 4];
   assertElementsAlmostEqual(A'*x, B'*x)
   assertElementsAlmostEqual(A ,double(B ))
   assertElementsAlmostEqual(A',double(B'))
end
